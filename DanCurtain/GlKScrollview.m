//
//  GlKScrollview.m
//  GoBang
//
//  Created by Sobf Leo on 16/10/13.
//  Copyright © 2016年 SOBF. All rights reserved.
//

#import "GlKScrollview.h"
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
@interface GlKScrollview ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView  * scrollview;
@property (nonatomic,strong) UIImageView * leftImageView;
@property (nonatomic,strong) UIImageView * rightImageView;
@property (nonatomic,strong) UIImageView * centerImageView;
@property (nonatomic,assign) NSInteger currentImageIndex;
@property (nonatomic,assign) NSInteger imageCount;
@property (nonatomic,strong) UIPageControl * pageControl;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) NSMutableDictionary * data;

@end

@implementation GlKScrollview

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 读取数据
        [self loadDATA];
        //初始ui
        [self addUI];
    }
    return self;
}
-(void)loadDATA{
    self.data = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"11",@"22",@"33",@"44",@"55", nil];
    self.imageCount = 5;
}
-(void)addUI{
    _scrollview = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _scrollview.pagingEnabled = YES;
    _scrollview.delegate = self;
    _scrollview.bounces = NO;
    _scrollview.showsVerticalScrollIndicator = NO;
    [self addSubview:self.scrollview];
    
    [self.scrollview setContentSize:CGSizeMake(self.imageCount * SCREEN_WIDTH, SCREEN_HEIGHT)];
    //
    [self addImages];
    [self addPagesControl];
    [self addLabel];
}
-(void)addImages{
    self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollview addSubview:self.leftImageView];
    self.centerImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.centerImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollview addSubview:self.centerImageView];
    self.rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollview addSubview:self.rightImageView];
    
    self.leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",_imageCount-1]];
    self.centerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd.jpg",0]];
    self.rightImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd.jpg",1]];
    self.currentImageIndex = 0;
    self.pageControl.currentPage = self.currentImageIndex;
    [self.scrollview setContentOffset:CGPointMake(SCREEN_WIDTH  ,0 )];
}
-(void)addPagesControl{
    self.pageControl = [[UIPageControl alloc]init];
    CGSize size = [self.pageControl sizeForNumberOfPages:self.imageCount];
    self.pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    self.pageControl.center = CGPointMake(SCREEN_WIDTH/2 , SCREEN_HEIGHT - 100);
    self.pageControl.numberOfPages = self.imageCount;
    _pageControl.pageIndicatorTintColor=[UIColor colorWithRed:193/255.0 green:219/255.0 blue:249/255.0 alpha:1];
    //设置当前页颜色
    _pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:0 green:150/255.0 blue:1 alpha:1];
    [self addSubview:self.pageControl];
}
-(void)addLabel{
    
    self.title=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH,30)];
    self.title.textAlignment=NSTextAlignmentCenter;
    self.title.textColor=[UIColor redColor];
    NSString * str = [NSString stringWithFormat:@"%zd.jpg",self.currentImageIndex];
    self.title.text = self.data[str];
    [self addSubview:self.title];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self reloadImage];
    [self.scrollview setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
    self.pageControl.currentPage = self.currentImageIndex;
    NSString *imageName=[NSString stringWithFormat:@"%zd.jpg",_currentImageIndex];
    self.title.text=self.data[imageName];
}
-(void)reloadImage{
    NSInteger leftImageIndex,rightImageIndex;
    CGPoint offSet = [self.scrollview contentOffset];
    NSLog(@"%f",offSet.x);
    if (offSet.x > SCREEN_WIDTH) {
        //向右滑
        self.currentImageIndex = (self.currentImageIndex + 1) % self.imageCount;
    }else if (offSet.x< SCREEN_WIDTH){
        self.currentImageIndex = (self.currentImageIndex+self.imageCount -1)%self.imageCount;// 向左滑
    }
    self.centerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd.jpg",self.currentImageIndex]];
    leftImageIndex = (self.currentImageIndex+self.imageCount-1)%self.imageCount;
    rightImageIndex = (self.currentImageIndex+1)%self.imageCount;
    self.leftImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%zd.jpg",leftImageIndex]];
    self.rightImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%zd.jpg",rightImageIndex]];
    
}

@end
