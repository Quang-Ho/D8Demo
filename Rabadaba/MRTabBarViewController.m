//
//  MRTabBarViewController.m
//  Medication Reminder
//
//  Created by mac mini on 2/27/14.
//  Copyright (c) 2014 Devinition. All rights reserved.
//

#import "MRTabBarViewController.h"
#import "AppConfig.h"


@interface MRTabBarViewController ()<UITabBarControllerDelegate>{
    BOOL IS_IOS7;
}

@end

@implementation MRTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        IS_IOS7=YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
        //[self customizeAppearanceForDutchVersion];
    
        [self customizeAppearanceForEnglishVersion];
    
    
    /*[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];*/
    self.delegate = self;
    if ([self.tabBar.items count]==3) {
        if (IS_IOS7) {
            UITabBarItem * tabItem=[self.tabBar.items objectAtIndex:0];
            [tabItem setImage:[[UIImage imageNamed:@"icon_setting.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [tabItem setSelectedImage:[[UIImage imageNamed:@"icon_setting_active.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            
            tabItem=[self.tabBar.items objectAtIndex:1];
            [tabItem setImage:[[UIImage imageNamed:@"icon_pouches.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [tabItem setSelectedImage:[[UIImage imageNamed:@"icon_pouches_active.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            
            tabItem=[self.tabBar.items objectAtIndex:2];
            [tabItem setImage:[[UIImage imageNamed:@"icon_info.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [tabItem setSelectedImage:[[UIImage imageNamed:@"icon_info_active.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        } else {
            UITabBarItem * tabItem=[self.tabBar.items objectAtIndex:0];
            [tabItem setSelectedImage:[UIImage imageNamed:@"icon_setting_active.png"]];
            
            tabItem=[self.tabBar.items objectAtIndex:1];
            [tabItem setSelectedImage:[UIImage imageNamed:@"icon_pouches_active.png"]];
            
            tabItem=[self.tabBar.items objectAtIndex:2];
            [tabItem setSelectedImage:[UIImage imageNamed:@"icon_info_active.png"]];
        }
    }
    
    _isOpenTabPouches=YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_isOpenTabPouches) {
        _isOpenTabPouches=NO;
        if (self.selectedIndex!=1) {
            self.selectedIndex=1;
        }
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Customize appearance for the Tab bar, Navigation Bar, Bottom Tool Bar

-(void) customizeAppearanceForDutchVersion{
    
#pragma Tab Bar
    // Change the tab bar background
    UIColor* bgTabBarColor=[UIColor colorWithRed:(float)(0/255.0) green:(float)(160/255.0) blue:(float)(217/255.0) alpha:1.0];
    CGRect rectTabBar = CGRectMake(0.0f, 0.0f, 320.0f, 44.0f);
    
    UIImage* bgTabBarImage=[self imageWithColor:bgTabBarColor andRect:rectTabBar];
    
    [[UITabBar appearance] setBackgroundColor:bgTabBarColor];
    [[UITabBar appearance] setBackgroundImage:bgTabBarImage];
    if (IS_IOS7) {
        //[[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    }
    
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    // Change the title color of tab bar items
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor whiteColor], UITextAttributeTextColor,
                                                       nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = [UIColor blackColor];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateSelected];
    
#pragma Navigation Bar
    UIColor* bgNavigationBarColor=[UIColor colorWithRed:(float)(228/255.0) green:(float)(248/255.0) blue:(float)(221/255.0) alpha:1.0];
    
    // Set the background image for *all* UINavigationBars
    [[UINavigationBar appearance] setBackgroundColor:bgNavigationBarColor];
    
    UIColor* tintNavigationBarColor=[UIColor colorWithRed:(float)(174/255.0) green:(float)(213/255.0) blue:(float)(162/255.0) alpha:1.0];
    if (IS_IOS7) {
        [[UINavigationBar appearance] setBarTintColor:bgNavigationBarColor];
    }
    
    [[UINavigationBar appearance] setTintColor:tintNavigationBarColor];
    
    // Customize the title text for *all* UINavigationBars
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor blackColor],
      UITextAttributeTextColor,
      nil]];
#pragma Tool Bar
    
    UIImage* bgToolBarImage=[self imageWithColor:bgTabBarColor andRect:rectTabBar];
    // Set the background image for *all* UIToolBars
    [[UIToolbar appearance] setBackgroundImage:bgToolBarImage forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
    [[UIToolbar appearance] setBackgroundColor:bgTabBarColor];
    
    if (IS_IOS7) {
        [[UIToolbar appearance] setBarTintColor:tintNavigationBarColor];
    }
    
    [[UIToolbar appearance] setTintColor:tintNavigationBarColor];
    
}

-(void) customizeAppearanceForEnglishVersion{
    
#pragma Tab Bar
    // Change the tab bar background
    UIColor* bgTabBarColor=[UIColor colorWithRed:(float)(181/255.0) green:(float)(181/255.0) blue:(float)(181/255.0) alpha:1.0];
    CGRect rectTabBar = CGRectMake(0.0f, 0.0f, 320.0f, 44.0f);
    
    UIImage* bgTabBarImage=[self imageWithColor:bgTabBarColor andRect:rectTabBar];
    
    [[UITabBar appearance] setBackgroundColor:bgTabBarColor];
    [[UITabBar appearance] setBackgroundImage:bgTabBarImage];
    if (IS_IOS7) {
        //[[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    }
    
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    // Change the title color of tab bar items
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor whiteColor], UITextAttributeTextColor,
                                                       nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = [UIColor blackColor];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateSelected];
    
#pragma Navigation Bar
    UIColor* bgNavigationBarColor=[UIColor colorWithRed:(float)(224/255.0) green:(float)(211/255.0) blue:(float)(230/255.0) alpha:1.0];
    
    // Set the background image for *all* UINavigationBars
    [[UINavigationBar appearance] setBackgroundColor:bgNavigationBarColor];
    
    UIColor* tintNavigationBarColor=[UIColor colorWithRed:(float)(102/255.0) green:(float)(35/255.0) blue:(float)(130/255.0) alpha:1.0];
    if (IS_IOS7) {
        [[UINavigationBar appearance] setBarTintColor:bgNavigationBarColor];
    }
    
    [[UINavigationBar appearance] setTintColor:tintNavigationBarColor];
    
    // Customize the title text for *all* UINavigationBars
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor blackColor],
      UITextAttributeTextColor,
      nil]];
#pragma Tool Bar
    
    UIImage* bgToolBarImage=[self imageWithColor:bgTabBarColor andRect:rectTabBar];
    // Set the background image for *all* UIToolBars
    [[UIToolbar appearance] setBackgroundImage:bgToolBarImage forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
    [[UIToolbar appearance] setBackgroundColor:bgTabBarColor];
    
    if (IS_IOS7) {
        [[UIToolbar appearance] setBarTintColor:tintNavigationBarColor];
    }
    
    [[UIToolbar appearance] setTintColor:tintNavigationBarColor];
    
}

- (UIImage *)imageWithColor:(UIColor *)color andRect:(CGRect) rect {
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma Manage navigation

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"selected index %lu",(unsigned long)self.selectedIndex);
    UINavigationController *navController=(UINavigationController *)viewController;
    [navController popToRootViewControllerAnimated:NO];
}

@end
