//
//  UserInfo1.h
//  vCard
//
//  Created by mac mini on 6/15/15.
//  Copyright (c) 2015 Devintion. All rights reserved.
//

#import "BaseObject.h"

@interface UserInfo : BaseObject<NSCoding>
@property (strong,nonatomic) NSString* userId;
@property (strong,nonatomic) NSString* username;
@property (strong,nonatomic) NSString* password;
@property (strong,nonatomic) NSString* display_name;
@property (strong,nonatomic) NSString* user_url;
@property (strong,nonatomic) NSString* token;
@property (assign,nonatomic) BOOL isLoggedIn;
@end
