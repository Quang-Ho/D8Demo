//
//  AppConfig.h
//  redcross
//
//  Created by MACBOOK PRO on 8/12/13.
//  Copyright (c) 2013 Devinition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

#define APPCONFIG_USERINFO @"APPCONFIG_USERINFO"

@interface AppConfig : NSObject

@property (retain,nonatomic) UserInfo* userData;

@property (readonly) BOOL IsLoggedIn;
-(void)logoutApp;

+ (id)sharedManager;

@end
