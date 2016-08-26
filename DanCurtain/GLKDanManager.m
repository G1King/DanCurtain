//
//  GLKDanManager.m
//  DanCurtain
//
//  Created by Sobf Leo on 16/8/26.
//  Copyright © 2016年 SOBF. All rights reserved.
//

#import "GLKDanManager.h"
#import "GLKDanView.h"

@interface GLKDanManager ()
@property (nonatomic,strong) NSMutableArray * allCommentsArr;
@property (nonatomic,strong) NSMutableArray * danCommentQueue;
@property (nonatomic,strong) NSMutableArray * tempComments;
@property (nonatomic,assign) BOOL isStopAnimation;
@property (nonatomic,assign) BOOL isStarted;
@end

@implementation GLKDanManager
-(void)start{
  
    if (self.tempComments.count == 0) {
        [self.tempComments addObjectsFromArray:self.allCommentsArr];
    }
    self.isStarted = YES;
    self.isStopAnimation = NO;
    [self initDanView];
    for (NSString * co in self.allCommentsArr) {
        NSLog(@"%@",co);
    }
}
-(void)initDanView{
    NSMutableArray * trace  = [NSMutableArray arrayWithArray:@[@(0),@(1),@(2)]];
    for (int i= 3; i >0 ; i--) {
        
        NSString * obj = [self.tempComments firstObject];
        if (obj) {
            [self.tempComments removeObjectAtIndex:0];
            NSInteger idex = arc4random() % trace.count;// 0 -- x-1
            Trajectory tr = [[trace objectAtIndex:idex] intValue];// 随机的轨迹
            [trace removeObjectAtIndex:idex];
            [self createDanComments:obj withRrace:tr];
        }else{
            break;
        }
    }
    
}
-(void)createDanComments:(NSString *) comments withRrace:(Trajectory) trace{
    if(self.isStopAnimation)return;
    GLKDanView * view = [[GLKDanView alloc]initWithComment:comments];
    view.VIP = self.isVIP;
    view.traje = trace;
    __weak GLKDanView * weakView = view;
    __weak typeof(self) weak =self;
    view.moveBlock = ^(MoveStatus status){
        if(weak.isStopAnimation)return ;
        switch (status) {
            case start:
                //start
                [self.danCommentQueue addObject:weakView];
                break;
            case enter:
                //enter
                if ([weak nextComments]) {
                    [weak createDanComments:[weak nextComments] withRrace:trace];
                    
                }else{
                    
                }
                break;
            case end:
                //end
                if ([self.danCommentQueue containsObject:weakView]) {
                    [self.danCommentQueue removeObject:weakView];
                }
                if (self.danCommentQueue.count==0) {
                    [weak start];
                }
                break;
            default:
                break;
        }
        
        
    };
    if (self.callBackView) {
        self.callBackView(view);
    }
}
-(NSString*)nextComments{
    NSString * obj = [self.tempComments firstObject];
    if (obj) {
        [self.tempComments removeObjectAtIndex:0];
    }
    return obj;
    
}
-(void)stop{
    self.isStarted = NO;
    self.isStopAnimation = YES;
    [self.danCommentQueue enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GLKDanView * view = obj;
        [view stopAnimation];
        view = nil;
    }];
}
-(void)sendComentsArr:(NSString *)comentsArr{
//    NSArray * temp = @[@"我是弹幕1",@"666666666",@"233333",@"我的弹幕2"];
//    [self.allCommentsArr addObjectsFromArray:temp];
    [self.allCommentsArr addObject:comentsArr];
    [self stop];
    [self start];
}
-(NSMutableArray*)allCommentsArr{
    if (!_allCommentsArr) {
        _allCommentsArr = [NSMutableArray arrayWithObjects:@"我是一条弹幕1",
                           @"我是一条弹幕我是一条弹幕2",
                           @"弹幕3",
                           @"弹幕4在这里",
                           @"弹幕5 hhh",
                           @"弹6", nil];
    }
    return _allCommentsArr;
}
-(NSMutableArray*)tempComments{
    if (!_tempComments) {
        _tempComments = [NSMutableArray new];
    }
    return _tempComments;
}
-(NSMutableArray*)danCommentQueue{
    if (!_danCommentQueue) {
        _danCommentQueue = [NSMutableArray new];
    }
    return _danCommentQueue;
}
@end
