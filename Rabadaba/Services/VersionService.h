//
//  VersionService.h
//  Medication Reminder
//
//  Created by mac mini on 3/21/14.
//  Copyright (c) 2014 Devinition. All rights reserved.
//

#import "BaseService.h"
#import <StoreKit/StoreKit.h>

@interface VersionService : BaseService
+ (VersionService *)sharedInstance;
@property (assign) BOOL checkedUpddate;
- (void)checkForNewVersion;
@end
