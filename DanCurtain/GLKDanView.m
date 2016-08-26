//
//  GLKDanView.m
//  DanCurtain
//
//  Created by Sobf Leo on 16/8/26.
//  Copyright © 2016年 SOBF. All rights reserved.
//

#import "GLKDanView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
static const NSInteger duration = 5;
static const NSInteger padd = 5;
@interface GLKDanView ()
@property (nonatomic,strong) UILabel * commentLabel;//评论
@property (nonatomic,assign) BOOL isKill;
@end

@implementation GLKDanView
-(instancetype)initWithComment:(NSString *)comment{
    
    if (self = [super init]) {
        self.backgroundColor = [UIColor cyanColor];//弹幕的背影色
        NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        
        float width = [comment sizeWithAttributes:dic].width;
        self.bounds = CGRectMake(0, 0, width+2*padd, 20);
        self.commentLabel = [UILabel new];
        self.commentLabel.frame = CGRectMake(padd, 0, width, 20);
        self.commentLabel.text = comment;
        self.commentLabel.textColor = [UIColor blackColor];
        self.commentLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.commentLabel];
        if (self.VIP) {
            self.commentLabel.textColor = [UIColor redColor];
        }
    }
    
    return self;
    
}
-(void)startAnimation{
    
    
    CGFloat  totalWidth = CGRectGetWidth(self.frame) + SCREEN_WIDTH ;//总长度
    CGFloat speed = totalWidth / duration;// 弹幕的 速度
    CGFloat time = (CGRectGetWidth(self.frame))/ speed;
    if (self.moveBlock) {
        self.moveBlock(start);// 开始进入屏幕
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)time * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (self.isKill) {
            return ;
        }
        if (self.moveBlock) {
            self.moveBlock(enter);// 在屏幕 中
        }
        
    });
    __block CGRect frame =  self.frame;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x =  -CGRectGetWidth(frame);
        self.frame = frame;
    } completion:^(BOOL finished) {
        if (self.moveBlock) {
            self.moveBlock(end);// 出屏幕
        }
        [self removeFromSuperview];
    }];
    
}
-(void)stopAnimation{
    self.isKill = YES;
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
  
    
}
@end
