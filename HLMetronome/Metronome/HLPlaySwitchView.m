//
//  HLPlaySwitchView.m
//  HLMetronome
//
//  Created by hhl on 2018/11/5.
//  Copyright © 2018年 HL. All rights reserved.
//

#import "HLPlaySwitchView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface HLPlaySwitchView (){
    
    CGFloat _lastPointAngle;//上一个点相对于x轴角度
    CGPoint _centerPoint;

}

/** 背景View */
@property (nonatomic, strong) UIImageView *bacImageView;

/** 控制频率View */
@property (nonatomic, strong) UIImageView *controlSpeedImageView;

/** 记录旋转方向 */
@property (nonatomic, assign) float transforma;
@property (nonatomic, assign) float transformb;
@property (nonatomic, assign) float transformc;
@property (nonatomic, assign) float transformd;
@property (nonatomic, assign) int lastSpeed;

@end

@implementation HLPlaySwitchView

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        [self creatUI];
    }
    return self;
}

- (void)creatUI{

    _centerPoint = CGPointMake(SCREEN_WIDTH /2, SCREEN_WIDTH /2);//中心点

    self.bacImageView = [[UIImageView alloc] init];
    self.bacImageView.image = [UIImage imageNamed:@"节拍器-圆盘"];
    self.bacImageView.userInteractionEnabled = YES;
    [self addSubview:self.bacImageView];
    
    [self.bacImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(230, 230));
        make.centerX.mas_equalTo(0);
    }];
    
    self.controlSpeedImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"节拍器-控制-小点"]];
    self.controlSpeedImageView.userInteractionEnabled  = YES;
    [self.bacImageView addSubview:self.controlSpeedImageView];
    
    [self.controlSpeedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(0);
    }];
    
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [playButton setImage:[UIImage imageNamed:@"节拍器-控制-播放"] forState:UIControlStateNormal];
    [playButton setImage:[UIImage imageNamed:@"节拍器-控制-播放点击态"] forState:UIControlStateHighlighted];
    [playButton setImage:[UIImage imageNamed:@"节拍器-控制-暂停"] forState:UIControlStateSelected];
    [playButton setImage:[UIImage imageNamed:@"节拍器-控制-暂停点击态"] forState:UIControlStateSelected | UIControlStateHighlighted];
    [playButton addTarget:self action:@selector(onPlayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bacImageView addSubview:playButton];
    
    [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(140, 140));
    }];
}

- (void)onPlayButtonClick:(UIButton *)button{
    
    button.selected = !button.selected;
    
    if (button.selected) {
//        播放
        if (self.delegate && [self.delegate respondsToSelector:@selector(hlPlay)]) {
            
            [self.delegate hlPlay];
        }
   
    }else{
//        暂停
        if (self.delegate && [self.delegate respondsToSelector:@selector(hlPause)]) {
            
            [self.delegate hlPause];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    //计算上一个点相对于x轴的角度
    CGFloat lastPointRadius = sqrt(pow(point.y - _centerPoint.y, 2) + pow(point.x - _centerPoint.x, 2));
    if (lastPointRadius == 0) {
        return;
    }
    _lastPointAngle = acos((point.x - _centerPoint.x) / lastPointRadius);
    if (point.y > _centerPoint.y) {
        _lastPointAngle = 2 * M_PI - _lastPointAngle;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    //1.计算当前点相对于x轴的角度
    CGFloat currentPointRadius = sqrt(pow(currentPoint.y - _centerPoint.y, 2) + pow(currentPoint.x - _centerPoint.x, 2));
    if (currentPointRadius == 0) {//当点在中心点时，被除数不能为0
        return;
    }
    CGFloat curentPointAngle = acos((currentPoint.x - _centerPoint.x) / currentPointRadius);
    if (currentPoint.y > _centerPoint.y) {
        curentPointAngle = 2 * M_PI - curentPointAngle;
    }
    //2.变化的角度
    CGFloat angle = _lastPointAngle - curentPointAngle;
    
    self.controlSpeedImageView.transform = CGAffineTransformRotate(self.controlSpeedImageView.transform, angle);
    _lastPointAngle = curentPointAngle;
    
    if (angle > 0) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(hlChangeSpeedWithIsAdd:speed:)]) {

            [self.delegate hlChangeSpeedWithIsAdd:YES speed:MIN(10, MAX(angle *20, 1))];
        }

    }else{
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(hlChangeSpeedWithIsAdd:speed:)]) {
            
            [self.delegate hlChangeSpeedWithIsAdd:NO speed:MIN(10, MAX(angle *20, 1))];
        }

    }
}

@end
