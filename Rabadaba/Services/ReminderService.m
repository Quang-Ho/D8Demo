//
//  CrimeReportService.m
//  crimereport
//
//  Created by MACBOOK PRO on 12/24/13.
//  Copyright (c) 2013 Devinition. All rights reserved.
//

#import "ReminderService.h"
#import "AppConfig.h"
#import "UserInfo.h"
#import "Pouche.h"
#import "PouchesModel.h"


@interface ReminderService(){
    
}

@end

@implementation ReminderService

#pragma Login

-(BOOL)IsLoggedOut:(ASIHTTPRequest *)request{
    int statusCode = [request responseStatusCode];
    if (statusCode==kHTTPStatusCodeUnauthorized) {
        [[AppConfig sharedManager]logoutApp];
        [[NSNotificationCenter defaultCenter]postNotificationName:NTF_REMINDER_LOGOUT object:Nil];
        return YES;
    }
    return NO;
}

-(void) LogIn{
    NSString* strURL=[NSString stringWithFormat:@"%@/getInnameTijdstippen.php",REMINDER_BASE_URL];
    NSURL* url=[NSURL URLWithString:strURL];
    [self doRequestWithAction:@"HEAD" url:url requestFinished:@selector(onLogInFinished:) requestFailed:@selector(onLogInFailed:)];
}

- (void)onLogInFinished:(ASIHTTPRequest *)request{
    int statusCode = [request responseStatusCode];
    NSLog(@"onLogInFinished:\n Status Code: %d",statusCode);
    BaseObject * obj=[[BaseObject alloc]init];
    UserInfo* userData=[[AppConfig sharedManager]userData];
    if (statusCode==kHTTPStatusCodeOK) {
        obj.success=YES;
        userData.isLoggedIn=YES;
        [[AppConfig sharedManager]setUserData:userData];
    }
    else{
        obj.success=NO;
        if (statusCode==kHTTPStatusCodeUnauthorized) {
            obj.errorMessage=[[AppConfig sharedManager]localized:@"Onjuiste login gegevens"];
        }
        else
        {
            obj.errorMessage=[[AppConfig sharedManager]localized:@"Onverwachte fout"];
        }
        userData.isLoggedIn=NO;
        [[AppConfig sharedManager]setUserData:userData];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:NTF_REMINDER_LOGIN object:obj];
}

- (void)onLogInFailed:(ASIHTTPRequest *)request{
    int statusCode = [request responseStatusCode];
    NSLog(@"onLogInFinished:\n Status Code: %d",statusCode);
    BaseObject * obj=[[BaseObject alloc]init];
    UserInfo* userData=[[AppConfig sharedManager]userData];
    userData.isLoggedIn=NO;
    [[AppConfig sharedManager]setUserData:userData];
    obj.success=NO;
    if (statusCode==kHTTPStatusCodeUnauthorized) {
        obj.errorMessage=[[AppConfig sharedManager]localized:@"Onjuiste login gegevens"];
    }
    else
    {
        obj.errorMessage=[[AppConfig sharedManager]localized:@"Kan geen verbinding maken met server"];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:NTF_REMINDER_LOGIN object:obj];
}

#pragma get pouches

-(void) GetPouches{
    NSString* strURL=[NSString stringWithFormat:@"%@/getInnameTijdstippen.php",REMINDER_BASE_URL];
    NSURL* url=[NSURL URLWithString:strURL];
    [self doRequestWithAction:@"GET" url:url requestFinished:@selector(onGetPouchesFinished:) requestFailed:@selector(onGetPouchesFailed:)];
}

- (void)onGetPouchesFinished:(ASIHTTPRequest *)request{
    //Check Authorization
    if ([self IsLoggedOut:request]) {
        return;
    }
    int statusCode = [request responseStatusCode];
    NSLog(@"onGetPouchesFinished:\n Status Code: %d",statusCode);
    //Parse array to Pouches
    PouchesModel* pouchesModel= [[PouchesModel alloc]init];
    if (statusCode==kHTTPStatusCodeOK) {
        pouchesModel.success=YES;
        NSString *responseString = [request responseString];
        //responseString=@"[{ \"pouche\": \"04921964041\",\"toedien_datum\": \"2014-04-26\",\"toedien_tijd\": \"08:00\",\"zi_nr\": 14753383,\"omschr\":\"Paracetamol\" },{ \"pouche\": \"04921964041\",\"toedien_datum\": \"2014-04-27\",\"toedien_tijd\": \"08:00\",\"zi_nr\": 14211106,\"omschr\":\"Paracetamol\" },{ \"pouche\": \"04921964041\",\"toedien_datum\": \"2014-04-30\",\"toedien_tijd\": \"08:00\",\"zi_nr\": 14987716,\"omschr\":\"Paracetamol\" },{ \"pouche\": \"04921964041\",\"toedien_datum\": \"2014-04-30\",\"toedien_tijd\": \"08:00\",\"zi_nr\": 15715345,\"omschr\":\"Paracetamol\" }]";
        NSLog(@"onGetPouchesFinished:\n %@",responseString);
        NSArray * responseArray= [responseString JSONValue];
        for (NSDictionary *poucheDict in responseArray) {
            Pouche * pouche=[[Pouche alloc]init];
            [pouchesModel.pouches addObject:pouche];
            pouche.pouche=[poucheDict objectForKey:@"pouche"];
            pouche.zi_nr=[poucheDict objectForKey:@"zi_nr"];
            pouche.aantal=[poucheDict objectForKey:@"aantal"];
            pouche.omschr=[poucheDict objectForKey:@"omschr"];
            pouche.toedien_datum=[poucheDict objectForKey:@"toedien_datum"];
            pouche.toedien_tijd=[poucheDict objectForKey:@"toedien_tijd"];
            pouche.beschr=[poucheDict objectForKey:@"beschr"];
            pouche.bijsluiter=[poucheDict objectForKey:@"bijsluiter"];
            pouche.artnr=[poucheDict objectForKey:@"artnr"];
            pouche.foto=[poucheDict objectForKey:@"foto"];
        }
        [[AppConfig sharedManager]initializeLocalNotificaitonWithPouchesModel:pouchesModel];
        [[AppConfig sharedManager]setPouchesModel:pouchesModel];
    }
    else
    {
        pouchesModel.success=NO;
        pouchesModel.errorMessage=[[AppConfig sharedManager]localized:@"Onverwachte fout"];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:NTF_REMINDER_POUCHES object:pouchesModel];
}

- (void)onGetPouchesFailed:(ASIHTTPRequest *)request{
    //Check Authorization
    if ([self IsLoggedOut:request]) {
        return;
    }
    PouchesModel* pouchesModel= [[PouchesModel alloc]init];
    pouchesModel.success=NO;
    pouchesModel.errorMessage=[[AppConfig sharedManager]localized:@"Kan geen verbinding maken met server"];
    [[NSNotificationCenter defaultCenter]postNotificationName:NTF_REMINDER_POUCHES object:pouchesModel];
}

@end
