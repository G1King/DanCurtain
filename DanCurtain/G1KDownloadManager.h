//
//  G1KDownloadManager.h
//  G1KDownloadManager
//
//  Created by Sobf Leo on 16/10/21.
//  Copyright © 2016年 SOBF. All rights reserved.
//

#import <Foundation/Foundation.h>
@class G1KDownloadManager;
#undef    X_SINGLETON_DEC
#define X_SINGLETON_DEC( __class ) \
+ (__class *)sharedInstance;

#undef    X_SINGLETON_DEF
#define X_SINGLETON_DEF( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}



/**
 下载的协议
 */
@protocol DownloadDelegate <NSObject>
-(void)downloadData:(G1KDownloadManager*)downloadData connection:(NSURLSession*)session data:(NSData*)data progress:(float)progress;

-(void)downloadFinishData:(G1KDownloadManager*)downloadData connection:(NSURLSession*)connection;
-(void)downloadFinishData:(G1KDownloadManager*)downloadData downloadDiction:(NSDictionary*)dic connection:(NSURLSession *)connection didReceiveResponse:(NSURLResponse *)response;

-(void)downloadFailWithData:(G1KDownloadManager*)downloadData connection:(NSURLSession *)connection didFailWithError:(NSError *)error;


@end

@interface G1KDownloadManager : NSObject

/**
 遵守改协议的指针
 */
@property (nonatomic,weak) id<DownloadDelegate>delegate;
// 单利
X_SINGLETON_DEC(G1KDownloadManager);

/**
 下载的地址
 */
@property (nonatomic,copy) NSString * strPath;

/**
 开始下载
 */
-(void)startDownload;

/**
 暂停下载
 */
-(void)pauseDownload;

/**
 继续下载
 */
-(void)resumeDownload;

/**
 取消下载
 */
-(void)canleDonwload;

@end
