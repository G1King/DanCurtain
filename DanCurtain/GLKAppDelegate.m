//
//  GLKAppDelegate.m
//  DanCurtain
//
//  Created by Sobf Leo on 16/8/26.
//  Copyright © 2016年 SOBF. All rights reserved.
//

#import "GLKAppDelegate.h"
#import "GLKHomeViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface GLKAppDelegate ()

@end


@implementation GLKAppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    
    GLKHomeViewController * home  = [[GLKHomeViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController= nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self test];
    [self set];
    NSUserDefaults * str = [NSUserDefaults standardUserDefaults];
    [str setObject:@"one" forKey:@"qhy1"];
    [str synchronize];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"qhy1"]);
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredInterfaceOrientationForPresentation) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    return  YES;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (BOOL)shouldAutorotate {
    
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    UIDevice * device = [UIDevice currentDevice];
    switch (device.orientation) {
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"12111dsdsfd");
            break;
            
        default:
            break;
    }

    return UIInterfaceOrientationLandscapeLeft;
}
-(void)test{
    [self performSelector:@selector(log) withObject:nil afterDelay:10];
      
}
-(void)set{
    NSLog(@"544");
}
-(void)log{
    NSLog(@"33");
    
}
@end
