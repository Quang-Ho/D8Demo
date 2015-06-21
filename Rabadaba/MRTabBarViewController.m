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
    
    //[self customizeAppearanceForEnglishVersion];
    
    
    /*[[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(applicationDidBecomeActive:)
     name:UIApplicationDidBecomeActiveNotification object:nil];*/
    self.delegate = self;
    
    [self.tabBar setTranslucent:YES];
    UIColor* bgTabBarColor=[UIColor colorWithRed:(float)(37/255.0) green:(float)(55/255.0) blue:(float)(96/255.0) alpha:1.0];
    CGRect rectTabBar = CGRectMake(0.0f, 0.0f, 320.0f, 44.0f);
    
    UIImage* bgTabBarImage=[self imageWithColor:bgTabBarColor andRect:rectTabBar];
    
    [[UITabBar appearance] setBackgroundColor:bgTabBarColor];
    [[UITabBar appearance] setBackgroundImage:bgTabBarImage];
    
    if ([self.tabBar.items count]==5) {
        UITabBarItem * tabItem=[self.tabBar.items objectAtIndex:0];
        [tabItem setImage:[[UIImage imageNamed:@"home-inactive"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [tabItem setSelectedImage:[[UIImage imageNamed:@"home-active"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        tabItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        
        tabItem=[self.tabBar.items objectAtIndex:1];
        [tabItem setImage:[[UIImage imageNamed:@"profile-inactive"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [tabItem setSelectedImage:[[UIImage imageNamed:@"profile-active"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        tabItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        
        tabItem=[self.tabBar.items objectAtIndex:2];
        [tabItem setImage:[[UIImage imageNamed:@"plus"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [tabItem setSelectedImage:[[UIImage imageNamed:@"plus"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        tabItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        
        tabItem=[self.tabBar.items objectAtIndex:3];
        [tabItem setImage:[[UIImage imageNamed:@"search-inactive"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [tabItem setSelectedImage:[[UIImage imageNamed:@"search-active"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        tabItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        
        tabItem=[self.tabBar.items objectAtIndex:4];
        [tabItem setImage:[[UIImage imageNamed:@"carot-inactive"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [tabItem setSelectedImage:[[UIImage imageNamed:@"carot-active"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        tabItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
    UIColor* bgTabBarColor=[UIColor colorWithRed:(float)(29/255.0) green:(float)(41/255.0) blue:(float)(77/255.0) alpha:1.0];
    
    [[UITabBar appearance] setBackgroundColor:bgTabBarColor];
    
    if (IS_IOS7) {
        //[[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    }
    
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    // Change the title color of tab bar items
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor whiteColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = [UIColor blackColor];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
#pragma Navigation Bar
    /*UIColor* bgNavigationBarColor=[UIColor colorWithRed:(float)(228/255.0) green:(float)(248/255.0) blue:(float)(221/255.0) alpha:1.0];
     
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
     NSForegroundColorAttributeName,
     nil]];*/
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
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = 320;//screenRect.size.width;
    
    CGRect rectTabBar = CGRectMake(0.0f, 0.0f, screenWidth, 44.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rectTabBar);
    
    UIColor* bgCenter=[UIColor colorWithRed:(float)(125/255.0) green:(float)(208/255.0) blue:(float)(224/255.0) alpha:1.0];
    float itemWidth=screenWidth/5;
    float x = itemWidth*2 + (itemWidth - 50)/2;
    CGRect rectCenter = CGRectMake(x, 0.0f, 50.f, 44.0f);
    CGContextSetFillColorWithColor(context, [bgCenter CGColor]);
    CGContextFillRect(context, rectCenter);
    NSLog(@"screen width: %f",screenWidth);
    
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
