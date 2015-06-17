//
//  Utilities.m
//  CaoBien
//
//  Created by MACBOOK PRO on 8/5/13.
//  Copyright (c) 2013 Devinition. All rights reserved.
//

#import "Utilities.h"
#import "Reachability.h"
#import "AppConfig.h"

@implementation Utilities

+(UIAlertView *) showMessageBox:(NSString *)message withTitle:(NSString *)title{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle: title message:message delegate:Nil cancelButtonTitle:Nil otherButtonTitles:@"OK", nil];
    alert.alertViewStyle=UIAlertViewStyleDefault;
    [alert show];
    return alert;
}

@end
