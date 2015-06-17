//
//  BaseService.h
//  redcross
//
//  Created by MACBOOK PRO on 8/12/13.
//  Copyright (c) 2013 Devinition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

#define REMINDER_BASE_URL @"http://www.apotheekvoorzorg.nl/api/appvanced"

typedef enum {
    kHTTPStatusCodeOK = 200,
    kHTTPStatusCodeUnauthorized = 401,
}kHTTPStatusCode;

@interface BaseService : NSObject<ASIHTTPRequestDelegate>

-(void) doRequestWithAction:(NSString*) action url:(NSURL *)url requestFinished:(SEL)processOnFinished requestFailed:(SEL) processOnFailed;
-(void) doRequestWithData:(NSString*) action data:(NSDictionary*)data url:(NSURL *)url requestFinished:(SEL)processOnFinished requestFailed:(SEL) processOnFailed;
@end
