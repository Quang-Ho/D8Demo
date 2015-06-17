//
//  ContactViewController.m
//  vCard
//
//  Created by mac mini on 6/15/15.
//  Copyright (c) 2015 Devintion. All rights reserved.
//

#import "ContactViewController.h"
#import "AppConfig.h"

@interface ContactViewController (){
    __weak IBOutlet UIWebView *wvFrontside;
    __weak IBOutlet UIWebView *wvBackside;
    __weak IBOutlet UIWebView *wvQRCode;
    UIWebView *_previousView;
    UIWebView *_currentView;
    UIWebView *_nextView;
    CGFloat widthOfScreen;
    CGFloat heightOfScreen;
}

@end

@implementation ContactViewController

-(void)initWebViews{
    self->wvFrontside.frame=CGRectMake(0, 20, widthOfScreen, heightOfScreen-20);
    self->wvBackside.frame=CGRectMake(widthOfScreen*(-1), 0, widthOfScreen, heightOfScreen);
    self->wvQRCode.frame=CGRectMake(widthOfScreen*(-1), 0, widthOfScreen, heightOfScreen);
    
    self->wvFrontside.scrollView.scrollEnabled=NO;
    self->wvBackside.scrollView.scrollEnabled=NO;
    self->wvQRCode.scrollView.scrollEnabled=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    widthOfScreen  = screenSize.width;
    heightOfScreen = screenSize.height;
    
    [self initWebViews];
    [self setupSwipeGestures];
    
    UserInfo *userInfo = [[AppConfig sharedManager]userData];
    NSString *address= [NSString stringWithFormat:@"http://wordpress422.local/update-profile/?action=front&token=%@&type=api",userInfo.token];
    NSLog(@"%@",address);
    address = [address stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url=[NSURL URLWithString:address];
    [self->wvFrontside loadRequest:[NSURLRequest requestWithURL:url]];
    
    _currentView=self->wvFrontside;
    
    address=[NSString stringWithFormat:@"http://wordpress422.local/update-profile/?action=back&token=%@&type=api",userInfo.token];
    NSLog(@"%@",address);
    address = [address stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    url=[NSURL URLWithString:address];
    [self->wvBackside loadRequest:[NSURLRequest requestWithURL:url]];
    
    address=[NSString stringWithFormat:@"http://wordpress422.local/update-profile/?action=qrcode&token=%@&type=api",userInfo.token];
    NSLog(@"%@",address);
    address = [address stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    url=[NSURL URLWithString:address];
    [self->wvQRCode loadRequest:[NSURLRequest requestWithURL:url]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)setupSwipeGestures{
    {
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognizer:)];
        [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        swipeLeft.delegate = self;
        [self->wvFrontside addGestureRecognizer:swipeLeft];
        
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognizer:)];
        [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        swipeRight.delegate = self;
        swipeRight.cancelsTouchesInView=YES;
        [self->wvFrontside addGestureRecognizer:swipeRight];
        
        UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognizer:)];
        [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
        swipeUp.delegate = self;
        swipeUp.cancelsTouchesInView=YES;
        [self->wvFrontside addGestureRecognizer:swipeUp];
        
        UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognizer:)];
        [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
        swipeDown.delegate = self;
        swipeDown.cancelsTouchesInView=YES;
        [self->wvFrontside addGestureRecognizer:swipeDown];
    }
    
    {
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognizer:)];
        [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        swipeLeft.delegate = self;
        [self->wvBackside addGestureRecognizer:swipeLeft];
        
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognizer:)];
        [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        swipeRight.delegate = self;
        swipeRight.cancelsTouchesInView=YES;
        [self->wvBackside addGestureRecognizer:swipeRight];
        
        UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognizer:)];
        [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
        swipeUp.delegate = self;
        swipeUp.cancelsTouchesInView=YES;
        [self->wvBackside addGestureRecognizer:swipeUp];
        
        UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognizer:)];
        [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
        swipeDown.delegate = self;
        swipeDown.cancelsTouchesInView=YES;
        [self->wvBackside addGestureRecognizer:swipeDown];
    }
    
    {
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognizer:)];
        [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        swipeLeft.delegate = self;
        [self->wvQRCode addGestureRecognizer:swipeLeft];
        
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognizer:)];
        [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        swipeRight.delegate = self;
        swipeRight.cancelsTouchesInView=YES;
        [self->wvQRCode addGestureRecognizer:swipeRight];
        
        UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognizer:)];
        [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
        swipeUp.delegate = self;
        swipeUp.cancelsTouchesInView=YES;
        [self->wvQRCode addGestureRecognizer:swipeUp];
        
        UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognizer:)];
        [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
        swipeDown.delegate = self;
        swipeDown.cancelsTouchesInView=YES;
        [self->wvQRCode addGestureRecognizer:swipeDown];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void) swipeRecognizer:(UISwipeGestureRecognizer *)sender {
    if ( sender.direction == UISwipeGestureRecognizerDirectionLeft ){
        NSLog(@" *** SWIPE LEFT ***");
        [self showFrontside];
    }
    if ( sender.direction == UISwipeGestureRecognizerDirectionRight ){
        NSLog(@" *** SWIPE RIGHT ***");
        [self showQRCode];
    }
    if ( sender.direction == UISwipeGestureRecognizerDirectionDown ){
        NSLog(@" *** SWIPE DOWN ***");
        [self showBackside];
    }
    if ( sender.direction == UISwipeGestureRecognizerDirectionUp ){
        NSLog(@" *** SWIPE UP ***");
        [self showFrontside];
    }
}

-(BOOL)isFrontside{
    return _currentView==self->wvFrontside;
}

-(BOOL)isBackside{
    return _currentView==self->wvBackside;
}

-(BOOL)isQRCode{
    return _currentView==self->wvQRCode;
}

-(void)showFrontside{
    if (![self isFrontside]) {
        NSLog(@"Frontside");
        _currentView=self->wvFrontside;
        self->wvFrontside.frame=CGRectMake(0, 20, widthOfScreen, heightOfScreen-20);
        self->wvBackside.frame=CGRectMake(widthOfScreen*(-1), 0, widthOfScreen, heightOfScreen);
        self->wvQRCode.frame=CGRectMake(widthOfScreen*(-1), 0, widthOfScreen, heightOfScreen);
    }
}

-(void)showBackside{
    if (![self isBackside]) {
        NSLog(@"Backside");
        _currentView=self->wvBackside;
        self->wvBackside.frame=CGRectMake(0, 0, widthOfScreen, heightOfScreen-20);
        self->wvFrontside.frame=CGRectMake(widthOfScreen*(-1), 0, widthOfScreen, heightOfScreen);
        self->wvQRCode.frame=CGRectMake(widthOfScreen*(-1), 0, widthOfScreen, heightOfScreen);
    }
}

-(void)showQRCode{
    if (![self isQRCode]) {
        NSLog(@"QRCodeside");
        _currentView=self->wvQRCode;
        self->wvQRCode.frame=CGRectMake(0, 20, widthOfScreen, heightOfScreen-20);
        self->wvFrontside.frame=CGRectMake(widthOfScreen*(-1), 0, widthOfScreen, heightOfScreen);
        self->wvBackside.frame=CGRectMake(widthOfScreen*(-1), 0, widthOfScreen, heightOfScreen);
        
    }
}

@end
