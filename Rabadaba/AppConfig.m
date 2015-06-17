//
//  AppConfig.m
//  redcross
//
//  Created by MACBOOK PRO on 8/12/13.
//  Copyright (c) 2013 Devinition. All rights reserved.
//

#import "AppConfig.h"

@interface AppConfig(){
    
}

@end

@implementation AppConfig

@synthesize userData=_userData;

#pragma mark Singleton Methods

+ (AppConfig*)sharedManager {
    static AppConfig *sharedAppConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAppConfig = [[self alloc] init];
    });
    return sharedAppConfig;
}

-(id) init{
    if (self=[super init]) {
       
    }
    return self;
}

-(void)setUserData:(UserInfo *)userData{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userData];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:data forKey:(NSString*)APPCONFIG_USERINFO];
    [prefs synchronize];
}

-(UserInfo *)userData{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:APPCONFIG_USERINFO]==Nil) {
        return Nil;
    }
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *data = [prefs objectForKey:APPCONFIG_USERINFO];
    _userData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return _userData;
}


-(void)logoutApp{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:APPCONFIG_USERINFO];
    [prefs synchronize];
    _userData=Nil;
}

-(BOOL)IsLoggedIn{
    _userData=self.userData;
    return _userData!=Nil;
}


@end
