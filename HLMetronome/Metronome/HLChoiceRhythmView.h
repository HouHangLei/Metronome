//
//  HLChoiceRhythmView.h
//  HLMetronome
//
//  Created by hhl on 2018/11/5.
//  Copyright © 2018年 HL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLMetronomeAudioManager.h"

NS_ASSUME_NONNULL_BEGIN

// 代理
@protocol HLChoiceRhythmViewDelegate <NSObject>

/** 改变节拍 */
- (void)hlChangeRhythm:(HLMetronomeType)metronomeStat;

@end

/** 调节节拍View */
@interface HLChoiceRhythmView : UIView

- (void)creatUI;

/** 代理 */
@property (nonatomic, weak) id <HLChoiceRhythmViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
