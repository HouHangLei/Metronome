//
//  HLRhythmSpotView.h
//  HLMetronome
//
//  Created by hhl on 2018/11/5.
//  Copyright © 2018年 HL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLMetronomeAudioManager.h"

NS_ASSUME_NONNULL_BEGIN

/** 节拍点 */
@interface HLRhythmSpotView : UIView

/** 更新当前点View（显示几个点） */
- (void)updateSpotView:(HLMetronomeType)metronomeStat;

/**
 更新某个点闪烁

 @param currentTotalNo 可以被currentTotalNo余0的闪烁一下
 */
- (void)updateSpotViewHeightState:(int)currentTotalNo;

@end

NS_ASSUME_NONNULL_END
