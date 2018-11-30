//
//  HLRhythmSpotView.m
//  HLMetronome
//
//  Created by hhl on 2018/11/5.
//  Copyright © 2018年 HL. All rights reserved.
//

#import "HLRhythmSpotView.h"

@interface HLRhythmSpotView ()

/** 背景图 */
@property (nonatomic, strong) UIImageView *bacImageView;

@property (nonatomic, assign) HLMetronomeType currentMetronomeType;

@end

@implementation HLRhythmSpotView

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
    
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    
    self.bacImageView = [[UIImageView alloc] init];
    self.bacImageView.image = [UIImage imageNamed:@"节拍器-点背景"];
    [self addSubview:self.bacImageView];
    
    [self.bacImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(0);
    }];
}

- (void)updateSpotViewHeightState:(int)currentTotalNo{
    
//    当前圆个数
    int spotNo;
    
    if (self.currentMetronomeType == HLMetronomeType1V4) {
        spotNo = 1;
    }else if (self.currentMetronomeType == HLMetronomeType2V4){
        spotNo = 2;
    }else if (self.currentMetronomeType == HLMetronomeType3V4 || self.currentMetronomeType == HLMetronomeType3V8){
        spotNo = 3;
    }else if (self.currentMetronomeType == HLMetronomeType4V4){
        spotNo = 4;
    }else{
        spotNo = 6;
    }
    
    UIImageView *currentImageView = [self.bacImageView viewWithTag:currentTotalNo % spotNo +100];
    currentImageView.highlighted = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        currentImageView.highlighted = NO;
    });
}

- (void)updateSpotView:(HLMetronomeType)metronomeStat{
    
    self.currentMetronomeType = metronomeStat;
    
    [self.bacImageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    [self creatSpotImageView:metronomeStat];
}

- (void)creatSpotImageView:(HLMetronomeType)metronomeStat{
 
    if (metronomeStat == HLMetronomeType1V4) {
        
        UIImageView *spotView = [self creatLargeSpotImageView];
        spotView.tag = 100;
        [self.bacImageView addSubview:spotView];
        
        [spotView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.center.mas_equalTo(0);
        }];
        
    }else if (metronomeStat == HLMetronomeType2V4){
        
        UIImageView *spotView = [self creatLargeSpotImageView];
        spotView.tag = 100;
        [self.bacImageView addSubview:spotView];
        
        [spotView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(self.mas_centerX).offset(-10);
            make.centerY.mas_equalTo(0);
        }];
        
        UIImageView *spotView1 = [self creatSmallSpotImageView];
        spotView1.tag = 101;
        [self.bacImageView addSubview:spotView1];
        
        [spotView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.mas_centerX).offset(10);
            make.centerY.mas_equalTo(0);
        }];
        
    }else if (metronomeStat == HLMetronomeType3V4 || metronomeStat == HLMetronomeType3V8){
        
        UIImageView *spotView1 = [self creatSmallSpotImageView];
        spotView1.tag = 101;
        [self.bacImageView addSubview:spotView1];
        
        [spotView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.center.mas_equalTo(0);
        }];
        
        UIImageView *spotView = [self creatLargeSpotImageView];
        spotView.tag = 100;
        [self.bacImageView addSubview:spotView];
        
        [spotView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(spotView1.mas_left).offset(-20);
            make.centerY.mas_equalTo(0);
        }];
        
        UIImageView *spotView2 = [self creatSmallSpotImageView];
        spotView2.tag = 102;
        [self.bacImageView addSubview:spotView2];
        
        [spotView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(spotView1.mas_right).offset(20);
            make.centerY.mas_equalTo(0);
        }];
        
    }else if (metronomeStat == HLMetronomeType4V4){
        
        UIImageView *spotView1 = [self creatSmallSpotImageView];
        spotView1.tag = 101;
        [self.bacImageView addSubview:spotView1];
        
        [spotView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(self.mas_centerX).offset(-10);
            make.centerY.mas_equalTo(0);
        }];
        
        UIImageView *spotView2 = [self creatSmallSpotImageView];
        spotView2.tag = 102;
        [self.bacImageView addSubview:spotView2];
        
        [spotView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.mas_centerX).offset(10);
            make.centerY.mas_equalTo(0);
        }];
        
        UIImageView *spotView = [self creatLargeSpotImageView];
        spotView.tag = 100;
        [self.bacImageView addSubview:spotView];
        
        [spotView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(spotView1.mas_left).offset(-20);
            make.centerY.mas_equalTo(0);
        }];
        
        UIImageView *spotView3 = [self creatSmallSpotImageView];
        spotView3.tag = 103;
        [self.bacImageView addSubview:spotView3];
        
        [spotView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(spotView2.mas_right).offset(20);
            make.centerY.mas_equalTo(0);
        }];
        
    }else if (metronomeStat == HLMetronomeType6V8){
        
        UIImageView *spotView1 = [self creatSmallSpotImageView];
        spotView1.tag = 102;
        [self.bacImageView addSubview:spotView1];
        
        [spotView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(self.mas_centerX).offset(-10);
            make.centerY.mas_equalTo(0);
        }];
        
        UIImageView *spotView2 = [self creatSmallSpotImageView];
        spotView2.tag = 103;
        [self.bacImageView addSubview:spotView2];
        
        [spotView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.mas_centerX).offset(10);
            make.centerY.mas_equalTo(0);
        }];
        
        UIImageView *spotView3 = [self creatSmallSpotImageView];
        spotView3.tag = 101;
        [self.bacImageView addSubview:spotView3];
        
        [spotView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(spotView1.mas_left).offset(-20);
            make.centerY.mas_equalTo(0);
        }];
        
        UIImageView *spotView4 = [self creatSmallSpotImageView];
        spotView4.tag = 104;
        [self.bacImageView addSubview:spotView4];
        
        [spotView4 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(spotView2.mas_right).offset(20);
            make.centerY.mas_equalTo(0);
        }];
        
        UIImageView *spotView = [self creatLargeSpotImageView];
        spotView.tag = 100;
        [self.bacImageView addSubview:spotView];
        
        [spotView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(spotView3.mas_left).offset(-20);
            make.centerY.mas_equalTo(0);
        }];
        
        UIImageView *spotView5 = [self creatSmallSpotImageView];
        spotView5.tag = 105;
        [self.bacImageView addSubview:spotView5];
        
        [spotView5 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(spotView4.mas_right).offset(20);
            make.centerY.mas_equalTo(0);
        }];
        
    }
}

#pragma mark -- 创建大圆View
- (UIImageView *)creatLargeSpotImageView{
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"节拍器-轮播点大"] highlightedImage:[UIImage imageNamed:@"节拍器-轮播点大-高亮"]];
    return imageView;
}

#pragma mark -- 创建小圆View
- (UIImageView *)creatSmallSpotImageView{
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"节拍器-轮播点小"] highlightedImage:[UIImage imageNamed:@"节拍器-轮播点小-高亮"]];
    return imageView;
}

@end
