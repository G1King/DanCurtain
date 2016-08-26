//
//  GLKDanManager.h
//  DanCurtain
//
//  Created by Sobf Leo on 16/8/26.
//  Copyright © 2016年 SOBF. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GLKDanView;
@interface GLKDanManager : NSObject

/**
 *  VIP 用户
 */
@property (nonatomic,assign) BOOL isVIP;

/**
 *  开启弹幕
 */
-(void)start;
/**
 *  关闭弹幕
 */
-(void)stop;
/**
 *  弹幕数组
 *
 *  @param comentsArr 
 */
-(void)sendComentsArr:(NSString*)comentsArr;

/**
 *  回调的弹幕view
 */
@property (nonatomic,copy) void(^callBackView)(GLKDanView * view);

@end
