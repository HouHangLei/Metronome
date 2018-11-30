//
//  HLChangeSpeedView.m
//  HLMetronome
//
//  Created by hhl on 2018/11/5.
//  Copyright © 2018年 HL. All rights reserved.
//

#import "HLChangeSpeedView.h"

@interface HLChangeSpeedView ()

/** 当前节拍频率 */
@property (nonatomic, strong) UILabel *speedLabel;

/** 当前频率 */
@property (nonatomic, assign) int currentSpeed;

@end

@implementation HLChangeSpeedView

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        [self creatUI];
    }
    return self;
}

- (void)creatUI{

    self.currentSpeed = 40;
    
//    减按钮
    UIButton *reduceButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [reduceButton setImage:[[UIImage imageNamed:@"节拍器-减"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [reduceButton addTarget:self action:@selector(onReduceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:reduceButton];
    
    [reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(reduceButton.mas_height);
    }];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [addButton setImage:[[UIImage imageNamed:@"节拍器-加"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(onAddButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addButton];
    
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(reduceButton.mas_height);
    }];
    
    self.speedLabel = [[UILabel alloc] init];
    self.speedLabel.textAlignment = NSTextAlignmentCenter;
    self.speedLabel.textColor = [UIColor whiteColor];
    self.speedLabel.font = [UIFont systemFontOfSize:15.f];
    [self addSubview:self.speedLabel];
    
    [self updateSpeedLabelText];
    
    [self.speedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(addButton);
    }];
}

#pragma mark -- 减按钮触发事件
- (void)onReduceButtonClick{
    
    if (self.currentSpeed > 40) {
        self.currentSpeed --;
    }else{
        self.currentSpeed = 40;
    }
    [self updateSpeedLabelText];
}

#pragma mark -- 加按钮触发事件
- (void)onAddButtonClick{
    
    if (self.currentSpeed < 240) {
        self.currentSpeed ++;
    }else{
        self.currentSpeed = 240;
    }
    [self updateSpeedLabelText];
}

- (void)updateSpeedLabelText{
    
    self.speedLabel.text = [NSString stringWithFormat:@"%d",self.currentSpeed];

    if (self.delegate && [self.delegate respondsToSelector:@selector(hlChangeSpeed:)]) {
        
        [self.delegate hlChangeSpeed:self.currentSpeed];
    }
}

- (void)changeSpeedWithIsAdd:(BOOL)isAdd speed:(int)speed{
    
    if (isAdd) {
        self.currentSpeed = MIN(self.currentSpeed +speed, 240);
    }else{
        self.currentSpeed = MAX(self.currentSpeed -speed, 40);
    }
    [self updateSpeedLabelText];
}

@end
