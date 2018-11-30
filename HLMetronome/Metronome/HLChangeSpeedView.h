//
//  HLChangeSpeedView.h
//  HLMetronome
//
//  Created by hhl on 2018/11/5.
//  Copyright © 2018年 HL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 代理
@protocol HLChangeSpeedViewDelegate <NSObject>

/** 改变频率 */
- (void)hlChangeSpeed:(int)speed;

@end

/** 更改速度频率View */
@interface HLChangeSpeedView : UIView

/** 代理 */
@property (nonatomic, weak) id <HLChangeSpeedViewDelegate> delegate;

/**
 改变频率
 
 @param isAdd 增加频率还是减小频率
 @param speed 增加或减小的值
 */
- (void)changeSpeedWithIsAdd:(BOOL)isAdd speed:(int)speed;

@end

NS_ASSUME_NONNULL_END
