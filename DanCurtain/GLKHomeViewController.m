//
//  GLKHomeViewController.m
//  DanCurtain
//
//  Created by Sobf Leo on 16/8/26.
//  Copyright © 2016年 SOBF. All rights reserved.
//

#import "GLKHomeViewController.h"
#import "GLKDanView.h"
#import "GLKDanManager.h"
#import "OneViewController.h"
#import <CoreMotion/CoreMotion.h>
@interface GLKHomeViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) CMMotionManager * motionManager;
@property (nonatomic,strong)GLKDanManager *manager;
@property (nonatomic,strong)UITextField * text;
@property BOOL vip;
@end

@implementation GLKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"弹幕网";
        [self initDan];
//    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:UIDeviceOrientationDidChangeNotification object:nil];

    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startMotionManager) userInfo:nil repeats:YES];
    NSRunLoop * roop = [NSRunLoop currentRunLoop];
    [roop addTimer:timer forMode:NSRunLoopCommonModes];

}
- (void)startMotionManager{
    if (_motionManager == nil) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    _motionManager.deviceMotionUpdateInterval = 1/15.0;
    if (_motionManager.deviceMotionAvailable) {
//        NSLog(@"Device Motion Available");
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue]
                                            withHandler: ^(CMDeviceMotion *motion, NSError *error){
                                                [self performSelectorOnMainThread:@selector(handleDeviceMotion:) withObject:motion waitUntilDone:YES];
                                                
                                            }];
    } else {
//        NSLog(@"No device motion on device.");
        [self setMotionManager:nil];
    }
}
- (void)handleDeviceMotion:(CMDeviceMotion *)deviceMotion{
    double x = deviceMotion.gravity.x;
    double y = deviceMotion.gravity.y;
    double z = deviceMotion.gravity.z;
    CGFloat device_angle = M_PI / 2.0f - atan2(y, x);
    
    
    
    if ( (device_angle > -M_PI_4) && (device_angle < M_PI_4) ){
        
//        orientation = UIDeviceOrientationPortrait;
    }
    else if ((device_angle < -M_PI_4) && (device_angle > -3 * M_PI_4))
        
//        orientation = UIDeviceOrientationLandscapeLeft;
        NSLog(@"left!!!");
    
    else if ((device_angle > M_PI_4) && (device_angle < 3 * M_PI_4)){
        
//        orientation = UIDeviceOrientationLandscapeRight;
        NSLog(@"right!!!");
        [_motionManager stopDeviceMotionUpdates];
    }
    
    else{
    
    }
        
//        orientation = UIDeviceOrientationPortraitUpsideDown;




//
//    if (fabs(y) >= fabs(x))
//    {
//        if (y >= 0){
//            // UIDeviceOrientationPortraitUpsideDown;
//        }
//        else{
//            // UIDeviceOrientationPortrait;
//        }
//    }
//    else
//    {
//        if (x >= 0){
//            // UIDeviceOrientationLandscapeRight;
//            NSLog(@"right");
//        }
//        else{
//            // UIDeviceOrientationLandscapeLeft;
//            NSLog(@"left");
//        }
//    }
}
- (void)didRotate:(NSTimer *)timer{
    UIDevice * divice = [UIDevice currentDevice];
    switch (divice.orientation) {
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"left");
            break;
            case UIDeviceOrientationLandscapeRight:
            NSLog(@"right");
            break;
        default:
            break;
    }
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if (self.interfaceOrientation == UIDeviceOrientationPortrait) {
        NSLog(@"竖直");
    } else if (self.interfaceOrientation == UIDeviceOrientationLandscapeLeft) {
        NSLog(@"水平向左");
    } else if(self.interfaceOrientation == UIDeviceOrientationLandscapeLeft) {
        NSLog(@"水平向右");
    }
}
-(void)change:(NSObject*)sender{
    UIDevice* device = [sender valueForKey:@"object"];
    NSLog(@"%zd",device.orientation);
    
}
-(void)initDan{
    self.text = [[UITextField alloc]initWithFrame:CGRectMake(80, 300, 200, 44)];
   self.text.keyboardType=UIKeyboardTypeDefault;
    self.text.delegate  =self;
    self.text.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.text];
    UIButton * start = [[UIButton alloc]initWithFrame:CGRectMake(80, 350, 60, 60)];
    [start setTitle:@"发送" forState:UIControlStateNormal];
    [start setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [start addTarget:self action:@selector(startDan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:start];
    UIButton * stop = [[UIButton alloc]initWithFrame:CGRectMake(180, 350, 60, 60)];
    [stop setTitle:@"停止" forState:UIControlStateNormal];
    [stop addTarget:self action:@selector(stopDan) forControlEvents:UIControlEventTouchUpInside];
    [stop setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:stop];
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(280, 350, 60, 60)];
    [button addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"send" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    __weak typeof (self) weak = self;
    self.manager = [[GLKDanManager alloc]init];
   
   self.manager.callBackView = ^(GLKDanView * view){
        [weak createView:view];
    };
}
-(void)startDan{
    [self.manager start];
}
-(void)stopDan{
//    [self.manager stop];
    OneViewController *one = [[OneViewController alloc]init];
    [self.navigationController pushViewController:one animated:NO];
}
-(void)send{
//    NSLog(@"%@",self.text.text);
    
  [self.manager sendComentsArr:self.text.text];
   
}

-(void)createView:(GLKDanView *) view{
    view.frame = CGRectMake(CGRectGetWidth(self.view.frame), 100 + 34 * view.traje, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    [self.view addSubview:view];
    [view startAnimation];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
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

@end
