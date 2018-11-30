//
//  HLMetronomeAudioManager.h
//  HLMetronome
//
//  Created by hhl on 2018/11/6.
//  Copyright © 2018年 HL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HLMetronomeType) {
    
    HLMetronomeType1V4 =0,     // 1/4
    HLMetronomeType2V4,        // 2/4
    HLMetronomeType3V4,        // 3/4
    HLMetronomeType4V4,        // 4/4
    HLMetronomeType3V8,        // 3/8
    HLMetronomeType6V8         // 6/8
};

// 代理
@protocol HLMetronomeAudioManagerDelegate <NSObject>

/** 当前播放音频的总次数（用来处理上部圆View那个显示高亮状态） */
- (void)hlMetronomeAudioCurrentTotalNo:(int)currentTotalNo;

@end

@interface HLMetronomeAudioManager : NSObject

+ (instancetype)sharedAudioManager;

/** 代理 */
@property (nonatomic, weak) id <HLMetronomeAudioManagerDelegate> delegate;

/** 节拍类型 */
@property (nonatomic, assign) HLMetronomeType metronomeStat;

/** 播放速率，范围40～240 */
@property (nonatomic, assign) int rate;

/** 播放 */
- (void)play;

/** 暂停 */
- (void)pause;

- (void)removeAll;

@end

NS_ASSUME_NONNULL_END
