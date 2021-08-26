//
//  CCProgressView.h
//  UserClient
//
//  Created by user on 2016/7/23.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/**
 * 動畫開始
 */
typedef void(^block_progress_start)();

/**
 * 動畫正在進行
 * @param NSTimeInterval
 */
typedef void(^block_progress_animing)(NSTimeInterval);

/**
 * 動畫結束
 */
typedef void(^block_progress_stop)();

@interface CCProgressView : UIView
{
    NSTimeInterval _animationTime;
}

@property (nonatomic, strong) UILabel *centerLabel;    // 中心Label

@property (nonatomic, copy) block_progress_start start;   // 動畫開始回調
@property (nonatomic, copy) block_progress_animing animing; // 動畫進行
@property (nonatomic, copy) block_progress_stop stop;    // 動畫結束回調

- (void) setAnimationTime:(NSTimeInterval)animationTime;

- (void)startAnimation;

- (void)stopAnimation;

-(void)setTimeLabelText:(NSString*)text;

-(void)setLabelText:(NSString*)text;

@end