//
//  LoginViewController.m
//  L2P-Quiz
//
//  Created by Claude Bemtgen on 1/7/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import "LoginViewController.h"
#import "WebServicesConstants.h"
#import "Constants.h"
#import "APIViewController.h"
#import "WebViewController.h"

@interface LoginViewController ()

//TODO: all props here should be moved to a model class, which could be a singleton

@property(retain) NSURLConnection   *userCodeURLConnection;
@property(retain) NSURLConnection   *tokenURLConnection;
@property(retain) NSURLConnection   *refreshTokenURLConnection;


//device and user code
@property(retain) NSString  *deviceCode;
@property(retain) NSString  *userCode;
@property(retain) NSURL     *verificationURL;
@property(retain) NSNumber  *userCodeExpiresIn;
@property(retain) NSNumber  *requestIntervalInMinutes;

//accesss and refresh token
@property(retain) NSString  *accessToken;
@property(retain) NSNumber  *accessExpiresIn;
@property(retain) NSString  *refreshToken;
@property(retain) NSDate    *lastTokenRequestDate;
@property(retain) NSDate    *accessExpiresAtDate;

//controller needed to display a web-view
@property(retain) APIViewController *apiVC;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.apiVC = [[APIViewController alloc] initWithNibName:@"APIViewController" bundle:Nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

//save & load prefs
-(void)viewDidDisappear:(BOOL)animated
{
    [self saveUserDefaults];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [self saveUserDefaults];
}


// -----------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark NSURLConnectionDataDelegate
// -----------------------------------------------------------------------------------------------------------------

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSError *error = nil;
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error)
    {
        NSLog(@"Error: %@", error);
        NSLog(@"Data is: %@", dataDictionary);
    }
    //obtaining user code
    else if (connection == self.userCodeURLConnection)
    {
        [self handleUsercodeResponseDictionary:dataDictionary];
    }
    //obtaining access token
    else if (connection == self.tokenURLConnection || connection == self.refreshTokenURLConnection)
    {
        [self handleAccessTokenResponseDictionary:dataDictionary];
        
        //present api view controller
        if (connection == self.tokenURLConnection)
        {
            self.refreshToken = [dataDictionary objectForKey:@"refresh_token"];
            
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimeTillRefreshLabel:) userInfo:Nil repeats:YES];
        }
        
        [self.apiVC setAccessToken:self.accessToken];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //NSLog(@"Recieved response: %@", response);
}


// -----------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark UI helpers
// -----------------------------------------------------------------------------------------------------------------

-(void)updateTimeTillRefreshLabel:(NSTimer*)timer
{
    //access token time
    NSInteger currentTimeInterval = [NSDate date].timeIntervalSince1970;
    NSInteger timeIntervalOfNextRequest = self.accessExpiresAtDate.timeIntervalSince1970;
    NSInteger secondsTillNextRequest = timeIntervalOfNextRequest - currentTimeInterval;
    
//    [self.timeTillRefreshLabel setText:[NSString stringWithFormat:@"%is", secondsTillNextRequest]];
    
        NSLog(@"%@", [NSString stringWithFormat:@"%is", secondsTillNextRequest]);
    
    if (secondsTillNextRequest < 0) {
//        [self.timeTillRefreshLabel setText:@"Obtain new user code"];
        NSLog(@"Obtain new user code.");
    }
}

// -----------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark HTTP response handlers
// -----------------------------------------------------------------------------------------------------------------

-(void)handleUsercodeResponseDictionary:(NSDictionary*)dict
{
    //save to local variables
    self.deviceCode = [dict objectForKey:@"device_code"];
    self.userCode = [dict objectForKey:@"user_code"];
    self.verificationURL = [NSURL URLWithString:[dict objectForKey:@"verification_url"]];
    self.userCodeExpiresIn = [dict objectForKey:@"expires_in"];
    self.requestIntervalInMinutes = [dict objectForKey:@"interval"];
    
    [self saveUserDefaults];
    
    //present web view
    NSString *pathComponent = [NSString stringWithFormat:@"?q=verify&d=%@", self.userCode];
    NSURL *verficationURLWithCode = [self.verificationURL URLByAppendingPathComponent:pathComponent];
    WebViewController *webVC = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:Nil];
    [self presentViewController:webVC animated:YES completion:nil];
    [webVC setVerificationURL:verficationURLWithCode];
}

-(void)handleAccessTokenResponseDictionary:(NSDictionary*)dict
{
    //test for errors
    NSString *status = [dict objectForKey:@"status"];
    NSRange rangeOfErrorInStatusString = [status rangeOfString:@"error"];
    if (rangeOfErrorInStatusString.location != NSNotFound) {
        NSLog(@"%@", status);
        return;
    }
    
    self.accessToken = [dict objectForKey:@"access_token"];
    self.accessExpiresIn = [dict objectForKey:@"expires_in"];
    
    self.lastTokenRequestDate = [NSDate date];
    self.accessExpiresAtDate = [NSDate dateWithTimeIntervalSinceNow:self.accessExpiresIn.integerValue * 60 - 30];
    
    [self saveUserDefaults];
}

// -----------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark user default helpers
// -----------------------------------------------------------------------------------------------------------------

-(void)loadUserDefaults
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.deviceCode = [userDefaults objectForKey:@"deviceCode"];
    self.userCode = [userDefaults objectForKey:@"userCode"];

    self.verificationURL = [userDefaults URLForKey:@"verificationURL"];
    self.userCodeExpiresIn = [userDefaults objectForKey:@"expiresInMinutes"];
    self.requestIntervalInMinutes = [userDefaults objectForKey:@"requestIntervalInMinutes"];
    
    self.accessToken = [userDefaults objectForKey:@"accessToken"];

    self.accessExpiresIn = [userDefaults objectForKey:@"accessExpiresIn"];
    self.refreshToken = [userDefaults objectForKey:@"refreshToken"];
    self.lastTokenRequestDate = [userDefaults objectForKey:@"lastTokenRequestDate"];
    self.accessExpiresAtDate = [userDefaults objectForKey:@"accessExpiresAtDate"];
    if (self.lastTokenRequestDate != nil && self.accessExpiresAtDate != nil) {
        [self updateTimeTillRefreshLabel:nil];
    }
}

-(void)saveUserDefaults
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.deviceCode forKey:@"deviceCode"];
    [userDefaults setObject:self.userCode forKey:@"userCode"];
    [userDefaults setURL:self.verificationURL forKey:@"verificationURL"];
    [userDefaults setObject:self.userCodeExpiresIn forKey:@"expiresInMinutes"];
    [userDefaults setObject:self.requestIntervalInMinutes forKey:@"requestIntervalInMinutes"];
    
    [userDefaults setObject:self.accessToken forKey:@"accessToken"];
    [userDefaults setObject:self.accessExpiresIn forKey:@"accessExpiresIn"];
    [userDefaults setObject:self.refreshToken forKey:@"refreshToken"];
    [userDefaults setObject:self.lastTokenRequestDate forKey:@"lastTokenRequestDate"];
    [userDefaults setObject:self.accessExpiresAtDate forKey:@"accessExpiresAtDate"];
}


//API calls
-(void)obtainUserCode:(UIButton*)sender
{
//    NSString *url = OAUTH_CODE_ENDPOINT;
//    
//    NSString *body = [NSString stringWithFormat:@"client_id=%@&scope=l2p.rwth userinfo.rwth", OAUTH_KEY];
//    
//    NSMutableURLRequest *userCodeRequest = [self requestWithURL:url body:body];
//    
//    self.userCodeURLConnection = [[NSURLConnection alloc]
//                                  initWithRequest:userCodeRequest
//                                  delegate:self
//                                  startImmediately:YES];
}

-(void) obtainAcessToken:(UIButton*)sender
{
//    NSString *url = OAUTH_TOKEN_ENDPOINT;
//    NSString *body = [NSString stringWithFormat:@"client_id=%@&code=%@&grant_type=device", OAUTH_KEY, self.deviceCode];
//    
//    NSMutableURLRequest *tokenRequest = [self requestWithURL:url body:body];
//    
//    self.tokenURLConnection = [[NSURLConnection alloc]
//                               initWithRequest:tokenRequest
//                               delegate:self
//                               startImmediately:YES];
}

-(void)
refreshAccessToken:(UIButton*)button
{
//    
//    NSString *url = OAUTH_TOKEN_ENDPOINT;
//    NSString *body = [NSString stringWithFormat: @"client_id=%@&refresh_token=%@&grant_type=refresh_token",OAUTH_KEY, self.refreshToken];
//    
//    NSMutableURLRequest *tokenRequest = [self requestWithURL:url body:body];
//    self.refreshTokenURLConnection = [[NSURLConnection alloc]
//                                      initWithRequest:tokenRequest
//                                      delegate:self
//                                      startImmediately:YES];
    
}

// -----------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark HTTP request utils
// -----------------------------------------------------------------------------------------------------------------

-(NSMutableURLRequest *)requestWithURL:(NSString *)urlString
                                  body:(NSString *)bodyString;
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    return request;
}

@end

