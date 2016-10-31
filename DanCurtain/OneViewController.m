//
//  OneViewController.m
//  DanCurtain
//
//  Created by Sobf Leo on 16/9/27.
//  Copyright © 2016年 SOBF. All rights reserved.
//

#import "OneViewController.h"
#import "GlKScrollview.h"
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#import "G1KDownloadManager.h"
@interface OneViewController ()<DownloadDelegate>
@property (nonatomic,strong) UIProgressView * progressView;
@property (nonatomic,strong) UIButton * start;
@property (nonatomic,strong) UIButton * stop;
@property (nonatomic,strong) UIButton * resume;
@property (nonatomic,strong) G1KDownloadManager * manager;
@property (nonatomic,strong) UILabel * label;
@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"one";
//    GlKScrollview * sc = [[GlKScrollview alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [self.view addSubview:sc];
//  http://sony.it168.com/data/attachment/forum/201410/20/2154195j037033ujs7cio0.jpg
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(100, 200, 240, 10)];
    self.progressView.progressTintColor = [UIColor cyanColor];
    self.progressView.trackTintColor = [UIColor grayColor];
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(100, 260, 100, 60)];
    self.label.textColor = [UIColor redColor];
    [self.view addSubview:self.label];
    self.start = [[UIButton alloc]initWithFrame:CGRectMake(200, 300, 60, 60)];
    [self.start setTitle:@"开始" forState:UIControlStateNormal];
    [self.start setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.start addTarget:self action:@selector(startBt) forControlEvents:UIControlEventTouchUpInside];
    
    self.stop = [[UIButton alloc]initWithFrame:CGRectMake(200, 370, 60, 60)];
    [self.stop setTitle:@"暂停" forState:UIControlStateNormal];
    [self.stop setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [self.stop addTarget:self action:@selector(stopBt) forControlEvents:UIControlEventTouchUpInside];

    
    self.resume = [[UIButton alloc]initWithFrame:CGRectMake(200, 400, 60, 60)];
    [self.resume setTitle:@"恢复" forState:UIControlStateNormal];
    [self.resume setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.resume addTarget:self action:@selector(resumeBt) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.stop];
    [self.view addSubview:self.start];
    [self.view addSubview:self.resume];
    self.manager.strPath = @"http://sony.it168.com/data/attachment/forum/201410/20/2154195j037033ujs7cio0.jpg";
}
-(void)downloadData:(G1KDownloadManager *)downloadData connection:(NSURLSession *)session data:(NSData *)data progress:(float)progress{
    NSLog(@"%f",progress);
    self.progressView.progress = progress;
    self.label.text = [NSString stringWithFormat:@"%.0f%",progress*100];
}
-(void)startBt{
    [self.manager startDownload];
}
-(void)stopBt{
    [self.manager pauseDownload];
}
-(void)resumeBt{
    [self.manager resumeDownload];
}
-(void)remove{
    
}
-(G1KDownloadManager*)manager{
    if (!_manager) {
        _manager =[G1KDownloadManager sharedInstance];
        _manager.delegate = self;
    }
    return _manager;
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
