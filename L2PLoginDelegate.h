//
//  L2PLoginDelegate.h
//  L2P-Quiz
//
//  Created by Emil Atanasov on 1/26/14.
//  Copyright (c) 2014 RWTHi10. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol L2PLoginDelegate <NSObject>

-(void) loginSucessful;
-(void) loginError: (NSString *) error;

@end
