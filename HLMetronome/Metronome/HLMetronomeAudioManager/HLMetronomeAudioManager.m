//
//  HLMetronomeAudioManager.m
//  HLMetronome
//
//  Created by hhl on 2018/11/6.
//  Copyright © 2018年 HL. All rights reserved.
//

#import "HLMetronomeAudioManager.h"
#import <AVFoundation/AVFoundation.h>

@interface HLMetronomeAudioManager ()

/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

/** 定时器多少秒循环一次 */
@property (nonatomic, assign) float timerLength;

/** 记录上一次的频率 */
@property (nonatomic, assign) int lastRate;

/** 发出"嘀"声的播放器 */
@property (nonatomic, strong) AVAudioPlayer *audioPlayDI;

/** 发出"咚"声的播放器 */
@property (nonatomic, strong) AVAudioPlayer *audioPlayDONG;

/** 当前发出的声次数（用来判断播放"嘀"还是"咚"声音） */
@property (nonatomic, assign) int currentTotalNo;

/** 当前是否播放状态 */
@property (nonatomic, assign) BOOL isPlay;

@end

@implementation HLMetronomeAudioManager

// 创建静态对象
static HLMetronomeAudioManager *_sharedAudioManager;

/** 重写初始化方法 */
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_sharedAudioManager == nil) {
            _sharedAudioManager = [super allocWithZone:zone];
            
        }
    });
    return _sharedAudioManager;
}

+ (instancetype)sharedAudioManager{
    
    return [[self alloc]init];
    
}

/** 重写copyWithZone */
-(id)copyWithZone:(NSZone *)zone
{
    return _sharedAudioManager;
}

/** 重写mutableCopyWithZone */
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _sharedAudioManager;
}

- (void)setMetronomeStat:(HLMetronomeType)metronomeStat{
    
    _metronomeStat = metronomeStat;
    
    self.currentTotalNo = 0;
    
    if (_timer && _isPlay) {
        
        [self resetTimer];
    }
}

- (void)setRate:(int)rate{
    
    _rate = rate;
    
    CGFloat rateFloat = rate;
    
    self.timerLength = 1 /(rateFloat /60);
    
    if (self.lastRate == 0) {
        
        self.lastRate = _rate;
    }
    
    //    超过10间隔再重置定时器，设置最新间隔秒数
    if (abs(self.lastRate -_rate) >= 10 && _isPlay) {
        
        self.lastRate = _rate;
        
        [self resetTimer];
    }
    
    if (abs(self.lastRate -_rate) >= 10 && !_isPlay) {
        
        if (_timer) {
            [_timer invalidate];
            _timer = nil;
        }
    }
}

- (void)play{
    
    _isPlay = YES;
    [self.timer setFireDate:[NSDate distantPast]];
}

- (void)pause{
    
    _isPlay = NO;
    [self.audioPlayDI pause];
    if (_audioPlayDONG) {
        [self.audioPlayDONG pause];
    }
    [self.timer setFireDate:[NSDate distantFuture]];//暂停计时器
}

- (AVAudioPlayer *)audioPlayDI{
    
    if (!_audioPlayDI) {
        
        NSString *soundPath = [[NSBundle mainBundle]pathForResource:@"tick" ofType:@"wav"];
        NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
        //        初始化播放器对象
        self.audioPlayDI = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:nil];
        //        设置循环次数，如果为负数，就是无限循环
        self.audioPlayDI.numberOfLoops = 0;
        //        是否可以更改播放速率
        //        self.audioPlay.enableRate = YES;
        
    }
    return _audioPlayDI;
}

- (AVAudioPlayer *)audioPlayDONG{
    
    if (!_audioPlayDONG) {
        
        NSString *soundPath = [[NSBundle mainBundle]pathForResource:@"tock" ofType:@"wav"];
        NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
        self.audioPlayDONG = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:nil];
        self.audioPlayDONG.numberOfLoops = 0;
        
    }
    return _audioPlayDONG;
}

- (NSTimer *)timer{
    
    if (!_timer) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.timerLength target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)timerAction{
    
    if (_metronomeStat == HLMetronomeType1V4) {
        [self.audioPlayDI play];
    }else{
        
        if (_metronomeStat == HLMetronomeType2V4 && self.currentTotalNo %2 == 0) {
            [self.audioPlayDI play];
        }else if (_metronomeStat == HLMetronomeType3V4 && self.currentTotalNo %3 == 0){
            [self.audioPlayDI play];
        }else if (_metronomeStat == HLMetronomeType4V4 && self.currentTotalNo %4 == 0){
            [self.audioPlayDI play];
        }else if (_metronomeStat == HLMetronomeType3V8 && self.currentTotalNo %3 == 0){
            [self.audioPlayDI play];
        }else if (_metronomeStat == HLMetronomeType6V8 && self.currentTotalNo %6 == 0){
            [self.audioPlayDI play];
        }else{
            
            [self.audioPlayDONG play];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(hlMetronomeAudioCurrentTotalNo:)]) {
        
        [self.delegate hlMetronomeAudioCurrentTotalNo:self.currentTotalNo];
    }
    
    self.currentTotalNo ++;
}

#pragma mark -- 重置定时器
- (void)resetTimer{
    
    [_timer invalidate];
    _timer = nil;
    [self.timer setFireDate:[NSDate distantPast]];
}

- (void)removeAll{
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    if (_audioPlayDI) {
        _audioPlayDI = nil;
    }
    
    if (_audioPlayDONG) {
        _audioPlayDONG = nil;
    }
}

@end
