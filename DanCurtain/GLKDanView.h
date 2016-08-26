//
//  GLKDanView.h
//  DanCurtain
//
//  Created by Sobf Leo on 16/8/26.
//  Copyright © 2016年 SOBF. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  移动的状态
 */
typedef NS_ENUM(NSInteger,MoveStatus) {
    
    start=0,// 开始进入
    
    enter,// 在屏幕中
    
    end // 滚出到屏幕
};
/**
 *  移动的轨迹
 */
typedef NS_ENUM(NSInteger,Trajectory) {
    trajectory_one =0,
    trajectory_two,
    trajectory_three
};

@interface GLKDanView : UIView
/**
 *  移动的回调
 */
@property (nonatomic,copy) void(^moveBlock)(MoveStatus status);
/**
 *  vip 特殊字体
 */
@property (nonatomic,assign) BOOL VIP;
/**
 *  弹道
 */
@property (nonatomic,assign)Trajectory traje;
/**
 *  添加弹幕
 *
 *  @param frame   frame
 *  @param comment 发送的评论
 *
 *  @return
 */
-(instancetype)initWithComment:(NSString*)comment;
/**
 *  开始动画弹幕
 */
-(void)startAnimation;
/**
 *  停止动画弹幕
 */
-(void)stopAnimation;


@end
