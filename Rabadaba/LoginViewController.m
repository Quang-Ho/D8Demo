//
//  ViewController.m
//  vCard
//
//  Created by mac mini on 6/15/15.
//  Copyright (c) 2015 Devintion. All rights reserved.
//

#import "LoginViewController.h"

#import "ASIHTTPRequestDelegate.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

#import "MBProgressHUD.h"

#import "Utilities.h"
#import "AppConfig.h"

#import "UserInfo.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doLogin:(id)sender {
    BOOL result=YES;
    //validate login information
    if (_txtUsername.text==Nil||[[_txtUsername.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@""] ) {
        [Utilities showMessageBox:@"Username is empty." withTitle:@"Warning"];
        result=NO;
        return;
    }
    if (_txtPassword.text==Nil||[[_txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@""] ) {
        [Utilities showMessageBox:@"Password is empty." withTitle:@"Warning"];
        result=NO;
        return;
    }
    if (result) {
        NSString *address=@"http://wordpress422.local/api/vcard/login/";
        address = [address stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url=[NSURL URLWithString:address];
        
        __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request addPostValue:self.txtUsername.text forKey:@"username"];
        [request addPostValue:self.txtPassword.text forKey:@"password"];
        
        [request setRequestMethod:@"POST"];
        [request setCompletionBlock:^{
            // Use when fetching text data
            NSString *responseString = [request responseString];
            NSLog(@"%@",responseString);
            NSError *error;
            NSDictionary * dict= [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
            if(dict){
                NSString *status=[dict objectForKey:@"status"];
                if ([@"ok" isEqualToString:status]) {
                    NSDictionary *data = [dict objectForKey:@"data"];
                    UserInfo * userInfo=[[UserInfo alloc]init];
                    userInfo.userId=[data objectForKey:@"id"];
                    userInfo.username=[data objectForKey:@"username"];
                    userInfo.password=[_txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    userInfo.display_name=[data objectForKey:@"display_name"];
                    userInfo.user_url=[data objectForKey:@"user_url"];
                    userInfo.token=[data objectForKey:@"token"];
                    userInfo.isLoggedIn = YES;
                    [[AppConfig sharedManager]setUserData:userInfo];
                    [self performSegueWithIdentifier:@"show_contact" sender:Nil];
                }else{
                    [Utilities showMessageBox:@"Invalid username and password." withTitle:@"Error"];
                }
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
        [request setFailedBlock:^{
            NSError *error = [request error];
            NSLog(@"%@",error);
            [Utilities showMessageBox:@"Unknow Error." withTitle:@"Error"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
        [request startAsynchronous];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Login";

    }
}


@end
