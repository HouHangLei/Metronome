//
//  HLChoiceRhythmView.m
//  HLMetronome
//
//  Created by hhl on 2018/11/5.
//  Copyright © 2018年 HL. All rights reserved.
//

#import "HLChoiceRhythmView.h"

@interface HLChoiceRhythmView ()

/** 节拍数据源 */
@property (nonatomic, strong) NSArray *rhythmTextArray;

/** 背景View */
@property (nonatomic, strong) UIImageView *bacImageView;

/** 节拍数 */
@property (nonatomic, strong) UILabel *rhythmLabel;

/** 上下箭头View */
@property (nonatomic, strong) UIImageView *arrowImageView;

/** 选择节拍背景 */
@property (nonatomic, strong) UIImageView *choiceRhythmBacView;

@end

@implementation HLChoiceRhythmView

- (void)creatUI{
    
    self.rhythmTextArray = @[@"1/4",@"2/4",@"3/4",@"4/4",@"3/8",@"6/8"];
    
    self.bacImageView = [[UIImageView alloc] init];
    self.bacImageView.image = [UIImage imageNamed:@"节拍器-下拉框"];
    self.bacImageView.userInteractionEnabled = YES;
    [self addSubview:self.bacImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.bacImageView addGestureRecognizer:tap];
    
    [self.bacImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(0);
    }];
    
    self.arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"节拍器-下拉箭头"] highlightedImage:[UIImage imageNamed:@"节拍器-下拉收起箭头"]];
    [self.bacImageView addSubview:self.arrowImageView];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-15);
    }];
    
    self.rhythmLabel = [[UILabel alloc] init];
    self.rhythmLabel.textColor = [UIColor blackColor];
    self.rhythmLabel.textAlignment = NSTextAlignmentCenter;
    self.rhythmLabel.font = [UIFont systemFontOfSize:13.f];
    self.rhythmLabel.text = self.rhythmTextArray[0];
    [self.bacImageView addSubview:self.rhythmLabel];
    
    [self.rhythmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(0);
    }];
}

- (void)tapClick{
    
    if (!_choiceRhythmBacView || _choiceRhythmBacView.hidden == YES) {
        
        self.choiceRhythmBacView.hidden = NO;
        self.arrowImageView.highlighted = YES;
        
    }else{
        
        self.choiceRhythmBacView.hidden = YES;
        self.arrowImageView.highlighted = NO;
    }
}

- (UIImageView *)choiceRhythmBacView{
    
    if (!_choiceRhythmBacView) {
        
        _choiceRhythmBacView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"节拍器-下拉列表"]];
        _choiceRhythmBacView.userInteractionEnabled = YES;
        [self.superview addSubview:_choiceRhythmBacView];
        
        [_choiceRhythmBacView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.mas_bottom).offset(5);
            make.width.mas_equalTo(self);
            make.height.mas_equalTo(240);
        }];
        
        NSMutableArray *buttonArray = [NSMutableArray array];
        for (int i = 0; i < self.rhythmTextArray.count; i ++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [button setTitle:self.rhythmTextArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button.tag = 100 +i;
            [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [_choiceRhythmBacView addSubview:button];
            
            [buttonArray addObject:button];
        }
        
        [buttonArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0 leadSpacing:10 tailSpacing:10];
        [buttonArray mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.mas_equalTo(0);
        }];
    }
    return _choiceRhythmBacView;
}

- (void)onButtonClick:(UIButton *)button{
    
    self.choiceRhythmBacView.hidden = YES;
    self.arrowImageView.highlighted = NO;

    self.rhythmLabel.text = self.rhythmTextArray[button.tag -100];

    if (self.delegate && [self.delegate respondsToSelector:@selector(hlChangeRhythm:)]) {
        
        [self.delegate hlChangeRhythm:button.tag -100];
    }
}

@end
