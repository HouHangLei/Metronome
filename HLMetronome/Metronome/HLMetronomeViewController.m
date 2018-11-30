//
//  HLMetronomeViewController.m
//  HLMetronome
//
//  Created by hhl on 2018/11/5.
//  Copyright © 2018年 HL. All rights reserved.
//

#import "HLMetronomeViewController.h"
#import "HLRhythmSpotView.h"
#import "HLChoiceRhythmView.h"
#import "HLChangeSpeedView.h"
#import "HLPlaySwitchView.h"
#import "HLMetronomeAudioManager.h"

@interface HLMetronomeViewController () <HLPlaySwitchViewDelegate,HLChangeSpeedViewDelegate,HLChoiceRhythmViewDelegate,HLMetronomeAudioManagerDelegate>

/** 上部点View */
@property (nonatomic, strong) HLRhythmSpotView *rhythmSpotView;

/** 节拍数 */
@property (nonatomic, strong) HLChoiceRhythmView *choiceRhythmView;

/** 修改节拍频率 */
@property (nonatomic, strong) HLChangeSpeedView *changeSpeedView;

/** 播放暂停开关 */
@property (nonatomic, strong) HLPlaySwitchView *playSwitchView;

@end

@implementation HLMetronomeViewController

- (void)dealloc{
    
    [[HLMetronomeAudioManager sharedAudioManager] removeAll];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    
//    背景图
    UIImageView *bacImageView = [[UIImageView alloc] init];
    bacImageView.image = [UIImage imageNamed:@"节拍器-背景"];
    [self.view addSubview:bacImageView];
    
    [bacImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(0);
    }];
    
//    节拍点View
    self.rhythmSpotView = [[HLRhythmSpotView alloc] init];
    [self.view addSubview:self.rhythmSpotView];
    
    [self.rhythmSpotView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(100);
        make.height.mas_offset(115);
    }];
    
//    选择节拍View
    self.choiceRhythmView = [[HLChoiceRhythmView alloc] init];
    self.choiceRhythmView.delegate = self;
    [self.view addSubview:self.choiceRhythmView];
    [self.choiceRhythmView creatUI];
    
    [self.choiceRhythmView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.rhythmSpotView.mas_bottom).offset(28);
        make.size.mas_equalTo(CGSizeMake(125, 40));
    }];
    
//    修改节拍频率View
    self.changeSpeedView = [[HLChangeSpeedView alloc] init];
    self.changeSpeedView.delegate = self;
    [self.view addSubview:self.changeSpeedView];
    
    [self.changeSpeedView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(self.choiceRhythmView.mas_bottom).offset(18);
        make.height.mas_offset(50);
    }];
    
//    播放暂停View
    self.playSwitchView = [[HLPlaySwitchView alloc] init];
    self.playSwitchView.delegate = self;
    [self.view addSubview:self.playSwitchView];
    
    [self.playSwitchView mas_makeConstraints:^(MASConstraintMaker *make) {
       
//        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.changeSpeedView.mas_bottom).offset(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(self.playSwitchView.mas_width);
//        make.size.mas_equalTo(CGSizeMake(230, 230));
    }];

    [self initMetronomeAudio];
}

#pragma mark -- 初始化节拍器播放器
- (void)initMetronomeAudio{
    
    [HLMetronomeAudioManager sharedAudioManager].delegate = self;
    [[HLMetronomeAudioManager sharedAudioManager] setMetronomeStat:HLMetronomeType1V4];
    [[HLMetronomeAudioManager sharedAudioManager] setRate:40];
    [self.rhythmSpotView updateSpotView:HLMetronomeType1V4];
}

#pragma mark -- HLChoiceRhythmViewDelegate
- (void)hlChangeRhythm:(HLMetronomeType)metronomeStat{
    
    [self.rhythmSpotView updateSpotView:metronomeStat];
    [[HLMetronomeAudioManager sharedAudioManager] setMetronomeStat:metronomeStat];
}

#pragma mark -- HLChangeSpeedViewDelegate
- (void)hlChangeSpeed:(int)speed{
    
    [[HLMetronomeAudioManager sharedAudioManager] setRate:speed];
}

#pragma mark -- HLPlaySwitchViewDelegate
- (void)hlPlay{
    
    [[HLMetronomeAudioManager sharedAudioManager] play];
}

- (void)hlPause{
    
    [[HLMetronomeAudioManager sharedAudioManager] pause];
}

- (void)hlChangeSpeedWithIsAdd:(BOOL)isAdd speed:(int)speed{
    
    [self.changeSpeedView changeSpeedWithIsAdd:isAdd speed:speed];
}

#pragma mark -- HLMetronomeAudioManagerDelegate
- (void)hlMetronomeAudioCurrentTotalNo:(int)currentTotalNo{
    
    [self.rhythmSpotView updateSpotViewHeightState:currentTotalNo];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

@end
