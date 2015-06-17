//
//  UserInfo1.m
//  vCard
//
//  Created by mac mini on 6/15/15.
//  Copyright (c) 2015 Devintion. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
-(id)init{
    self=[super init];
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self.userId=[aDecoder decodeObjectForKey:@"userId"];
    self.username=[aDecoder decodeObjectForKey:@"username"];
    self.password=[aDecoder decodeObjectForKey:@"password"];
    self.display_name=[aDecoder decodeObjectForKey:@"display_name"];
    self.user_url=[aDecoder decodeObjectForKey:@"user_url"];
    self.token=[aDecoder decodeObjectForKey:@"token"];
    self.isLoggedIn=[aDecoder decodeBoolForKey:@"isLoggedIn"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_userId forKey:@"userId"];
    [aCoder encodeObject:_username forKey:@"username"];
    [aCoder encodeObject:_password forKey:@"password"];
    [aCoder encodeObject:_display_name forKey:@"display_name"];
    [aCoder encodeObject:_user_url forKey:@"user_url"];
    [aCoder encodeObject:_token forKey:@"token"];
    [aCoder encodeBool:_isLoggedIn forKey:@"isLoggedIn"];
}
@end
