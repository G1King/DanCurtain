//
//  GLKAppDelegate.m
//  DanCurtain
//
//  Created by Sobf Leo on 16/8/26.
//  Copyright © 2016年 SOBF. All rights reserved.
//

#import "GLKAppDelegate.h"
#import "GLKHomeViewController.h"

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
    return  YES;
}
@end
