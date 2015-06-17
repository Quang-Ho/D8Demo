//
//  BaseObject1.h
//  vCard
//
//  Created by mac mini on 6/15/15.
//  Copyright (c) 2015 Devintion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseObject : NSObject
@property (assign,nonatomic)BOOL success;
@property (strong,nonatomic) NSString* errorMessage;
@end
