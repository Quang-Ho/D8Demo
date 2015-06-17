//
//  CrimeReportService.h
//  crimereport
//
//  Created by MACBOOK PRO on 12/24/13.
//  Copyright (c) 2013 Devinition. All rights reserved.
//

#import "BaseService.h"
#define NTF_REMINDER_LOGIN @"NTF_REMINDER_LOGIN"
#define NTF_REMINDER_LOGOUT @"NTF_REMINDER_LOGOUT"
#define NTF_REMINDER_POUCHES @"NTF_REMINDER_POUCHES"

@interface ReminderService : BaseService
-(void) LogIn;
-(void) GetPouches;
@end
