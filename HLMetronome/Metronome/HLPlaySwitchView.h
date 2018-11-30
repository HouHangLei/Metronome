//
//  HLPlaySwitchView.h
//  HLMetronome
//
//  Created by hhl on 2018/11/5.
//  Copyright © 2018年 HL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 代理
@protocol HLPlaySwitchViewDelegate <NSObject>

/** 播放 */
- (void)hlPlay;

/** 暂停 */
- (void)hlPause;

/**
 改变频率

 @param isAdd 增加频率还是减小频率
 @param speed 增加或减小的值
 */
- (void)hlChangeSpeedWithIsAdd:(BOOL)isAdd speed:(int)speed;

@end

/** 播放开关View */
@interface HLPlaySwitchView : UIView

/** 代理 */
@property (nonatomic, weak) id <HLPlaySwitchViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
