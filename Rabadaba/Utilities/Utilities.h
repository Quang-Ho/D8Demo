//
//  Utilities.h
//  CaoBien
//
//  Created by MACBOOK PRO on 8/5/13.
//  Copyright (c) 2013 Devinition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

BOOL isConnected;

@interface Utilities : NSObject{
    
}
+(UIAlertView *) showMessageBox:(NSString *) message withTitle:(NSString*) title;
+(void) startWatchingInternetConnection;
+(BOOL) isInternetConnected;
@end

