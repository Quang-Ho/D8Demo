//
//  VersionService.m
//  Medication Reminder
//
//  Created by mac mini on 3/21/14.
//  Copyright (c) 2014 Devinition. All rights reserved.
//

#import "VersionService.h"
#import <StoreKit/StoreKit.h>
#import "AppConfig.h"

#define REQUEST_TIMEOUT 60.0
static NSString *const iOSVersionFileURL = @"http://services.appvanced.net/medicatierol/ios/_version.txt";
static NSString *const iOSAppStoreURLFormat = @"itms-apps://itunes.apple.com/app/id%@";
static NSString * ApplicationAppleID= @"826478229";

@implementation NSString(iVersion)

- (NSComparisonResult)compareVersion:(NSString *)version
{
    return [self compare:version options:NSNumericSearch];
}

- (NSComparisonResult)compareVersionDescending:(NSString *)version
{
    switch ([self compareVersion:version])
    {
        case NSOrderedAscending:
        {
            return NSOrderedDescending;
        }
        case NSOrderedDescending:
        {
            return NSOrderedAscending;
        }
        case NSOrderedSame:
        {
            return NSOrderedSame;
        }
    }
}

@end

@interface VersionService()<UIAlertViewDelegate>{
    NSString * applicationVersion;
    NSString * lastVersion;
    NSString * applicationBundleID;
    BOOL onlyPromptIfMainWindowIsAvailable;
    BOOL checkingForNewVersion;
}

@end

@implementation VersionService

+ (VersionService *)sharedInstance
{
    static VersionService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (VersionService *)init
{
    if ((self = [super init]))
    {
        ApplicationAppleID=[[AppConfig sharedManager]IsDutchVersion]?@"826478229":@"826482179";
        
        //application version (use short version preferentially)
        applicationVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        if ([applicationVersion length] == 0)
        {
            applicationVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
        }
        
        //bundle id
        applicationBundleID = [[NSBundle mainBundle] bundleIdentifier];
        
        //default settings
        onlyPromptIfMainWindowIsAvailable = YES;
    }
    return self;
}

- (void)checkForNewVersionInBackground
{
    @synchronized (self)
    {
        @autoreleasepool
        {
            BOOL newerVersionAvailable = NO;
            
            NSError *error = nil;
            NSURLResponse *response = nil;
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:iOSVersionFileURL]
                                                     cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                 timeoutInterval:REQUEST_TIMEOUT];
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            NSInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
            if (data && statusCode == 200)
            {
                lastVersion=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"The version of app is %@",applicationVersion);
                NSLog(@"The version on service is %@",lastVersion);
                newerVersionAvailable= ([lastVersion compareVersion:applicationVersion] == NSOrderedDescending);
                if (newerVersionAvailable) {
                    [self performSelectorOnMainThread:@selector(askUserUpdateApp) withObject:nil waitUntilDone:YES];
                }
            }
        }
    }
}

- (void)checkForNewVersion
{
    if (!checkingForNewVersion&&!_checkedUpddate)
    {
        checkingForNewVersion = YES;
        _checkedUpddate=YES;
        [self performSelectorInBackground:@selector(checkForNewVersionInBackground) withObject:nil];
    }
}

-(void)askUserUpdateApp{
    UIAlertView* questionAlert=[[UIAlertView alloc]initWithTitle:[[AppConfig sharedManager]localized:@"Nieuwe versie" message:@"Nieuwe versie beschikbaar, wilt u nu updaten?"] delegate:self cancelButtonTitle:[[AppConfig sharedManager]localized:@"Ja"] otherButtonTitles:[[AppConfig sharedManager]localized:@"Nee"], nil];
    [questionAlert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    checkingForNewVersion=NO;
    if (buttonIndex==0) {
        [self openAppPageInAppStore];
    }
}

-(void)openAppPageInAppStore{
    NSURL* updateURL=[NSURL URLWithString:[NSString stringWithFormat:iOSAppStoreURLFormat, ApplicationAppleID]];
    [[UIApplication sharedApplication] openURL:updateURL];
}

@end
