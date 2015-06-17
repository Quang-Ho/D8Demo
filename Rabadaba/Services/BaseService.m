//
//  BaseService.m
//  redcross
//
//  Created by MACBOOK PRO on 8/12/13.
//  Copyright (c) 2013 Devinition. All rights reserved.
//

#import "BaseService.h"
#import "AppConfig.h"
#import "Utilities.h"
#import "UserInfo.h"

@interface BaseService()

@end

@implementation BaseService

-(id)init{
    if (self=[super init]) {
        
    }
    return self;
}

-(void)doRequestWithAction:(NSString *)action url:(NSURL *)url requestFinished:(SEL)processOnFinished requestFailed:(SEL)processOnFailed{
    NSLog(@"%@",url.absoluteString);
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    //Basic Authentication
    UserInfo *userInfo=[[AppConfig sharedManager]userData];
    request.username=userInfo.username;
    request.password=userInfo.password;
    
    [request setRequestMethod:action];
    [request setDelegate:self];
    [request setDidFinishSelector:processOnFinished];
    [request setDidFailSelector:processOnFailed];
    [request startAsynchronous];
}

-(void)doRequestWithData:(NSString *)action data:(NSDictionary*)data url:(NSURL *)url requestFinished:(SEL)processOnFinished requestFailed:(SEL)processOnFailed{
    if ([action isEqualToString:@"GET"]) {
        NSString* stringURL=url.absoluteString;
        if ([data.allKeys count]>0) {
            stringURL=[NSString stringWithFormat:@"%@?",stringURL];
        }
        for (NSString* key in data.allKeys) {
            stringURL=[NSString stringWithFormat:@"%@%@=%@&",stringURL,key,(NSString*)[data objectForKey:key]];
        }
        if ( [stringURL length] > 0)
            stringURL = [stringURL substringToIndex:[stringURL length] - 1];
        url=[NSURL URLWithString:stringURL];
    }
    NSLog(@"%@",url.absoluteString);
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //Basic Authentication
    UserInfo *userInfo=[[AppConfig sharedManager]userData];
    request.username=userInfo.username;
    request.password=userInfo.password;
    
    [request setRequestMethod:action];
    if (![action isEqualToString:@"GET"]) {
        for (NSString* key in data.allKeys) {
            [request setPostValue:[data objectForKey:key] forKey:key];
        }
    }
    
    [request setDelegate:self];
    [request setDidFinishSelector:processOnFinished];
    [request setDidFailSelector:processOnFailed];
    [request startAsynchronous];
}

@end
