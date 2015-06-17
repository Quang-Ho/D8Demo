//
//  MRTabBarViewController.h
//  Medication Reminder
//
//  Created by mac mini on 2/27/14.
//  Copyright (c) 2014 Devinition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRTabBarViewController : UITabBarController

@property (assign,nonatomic) BOOL isOpenTabPouches;

-(void)checkReminderInQueue;

@end
