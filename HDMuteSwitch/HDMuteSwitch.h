//
//  HDMuteSwitch.h
//  Seven
//
//  Created by HeDong on 2016/12/13.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDSingleton.h"
#include <AudioToolbox/AudioToolbox.h>

@protocol HDMuteSwitchDelegate

@optional
- (void)isMuted:(BOOL)muted;

@end

@interface HDMuteSwitch : NSObject

@property (nonatomic, weak) id<HDMuteSwitchDelegate> delegate;

HDSingletonH(HDMuteSwitch)

/**
 等待回调或代理
 */
- (void)detectMuteSwitch:(void(^)(BOOL muted))muted;

/**
 根据系统设置来自适应是否震动(只一次)
 */
- (void)playSystemSoundVibrate;

/**
 根据系统设置来自适应是否重复震动
 */
- (void)repeatPlaySystemSoundVibrate;

/**
 移除震动
 */
- (void)removePlaySystemSoundVibrate;

@end
