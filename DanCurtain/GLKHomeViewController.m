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
@interface GLKHomeViewController ()<UITextFieldDelegate>

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
    [self.manager stop];
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
