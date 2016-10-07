//
//  KKGestureView.m
//  KKSideViewController
//
//  Created by MR.KING on 16/7/15.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "KKGestureView.h"

#import "KKGestureBackView.h"

#import "UIView+KKFrame.h"

@interface KKGestureView()
{
    NSArray * _arrObservers;
}

/// 观察着，观察属性的变化
@property(nonatomic,readonly)NSArray * arrObservers;

/// 放置 圆 图层
@property(nonatomic,strong)KKGestureBackView * backGroundView;

/// 手势处理图层
@property(nonatomic,strong)KKGestureTrackView * trackView;

/// 行间距
@property(nonatomic,assign,readonly)double rowsPad;

/// 列间距
@property(nonatomic,assign,readonly)double colsPad;

@end

@implementation KKGestureView


#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initView];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
        [self initView];
    }
    return self;
}

-(void)initData{
    [self addObservers];
    
    _state = KKGestureViewStateNormal;
    
    _errorDuration = 2.0f;
    
    _edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _rows = 3;
    _cols = 3;
    
    _itemRadius = 30;
    _itemBorderWidth = 2;
        
    _itemInBorderWidth = 5;
    _itemInCircleRadius = 18;
    
    
    
    _itemBackGroundColor = [UIColor whiteColor];
    
    _itemSeletedBackGroundColor = [UIColor cyanColor];
    
    _itemBorderColor = [UIColor cyanColor];
    
    _itemSeletedBorderColor = [UIColor redColor];
    
    _itemErrorBackGroundColor = [UIColor redColor];
    
    _itemErrorBorderColor = [UIColor blueColor];
    
    
    
    _itemInBackGroundColor = [UIColor blueColor];
    
    _itemInBorderColor = [UIColor redColor];
    
    _itemInSeletedBackGroundColor = [UIColor purpleColor];
    
    _itemInSeletedBorderColor = [UIColor greenColor];
    
    _itemInErrorBackGroundColor = [UIColor redColor];
    
    _itemInErrorBorderColor = [UIColor blueColor];
}

-(void)initView{
    CGPoint * point = [self getPoints];
    
    __weak typeof(self) weakSelf = self;
    _backGroundView = [[KKGestureBackView alloc]initWithPoints:point
                                                         count:self.rows * self.cols
                                                        radius:self.itemRadius
                                                      inRadius:self.itemInCircleRadius
                                                 errorDuration:self.errorDuration
                                                        result:^(int count) {
                                                            return [weakSelf delegateForEndCount:count];
                                                        } state:^(KKGestureViewState newState, KKGestureViewState oldState) {
                                                            [weakSelf delegateForNewState:newState oldState:oldState];
                                                        }];
    [self addSubview:_backGroundView];
    
    for (NSString * keyPath in self.arrObservers) {
        [_backGroundView needUpConfigureValue:[self valueForKey:keyPath] keyPath:keyPath];
    }
        
    _trackView = [[KKGestureTrackView alloc]initWithPoints:point
                                                     count:self.rows * self.cols
                                                    radius:self.itemRadius
                                              refrenceView:_backGroundView];
    _trackView.delegate = _backGroundView;
    [self addSubview:_trackView];
    
}

#pragma mark - tool

-(CGPoint*)getPoints{
    CGFloat rowPad = self.rowsPad;
    CGFloat colPad = self.colsPad;
    
    int count = self.rows * self.cols;
    
    CGPoint * points = new CGPoint[count] ;
    
    
    int flag = 0;
    for ( int i = 0 ; i < self.rows; i++) {
        for (int j = 0; j < self.cols; j++) {
            CGFloat X = self.itemRadius + j * (self.itemRadius * 2 + colPad);
            CGFloat Y = self.itemRadius + i * (self.itemRadius * 2 + rowPad);
            CGPoint pointTmp = CGPointMake(X, Y);
            points[flag] = pointTmp;
            flag++;
        }
    }
    return points;
}



#pragma mark - layoutSubviews

-(void)layoutSubviews{
    
    _trackView.bounds = CGRectMake(0, 0, self.kk_width, self.kk_height);
    _trackView.center = CGPointMake(self.kk_width / 2.0, self.kk_height / 2.0);
    
    CGFloat backWidth = self.kk_width - self.edgeInsets.left - self.edgeInsets.right;
    CGFloat backHeight = self.kk_height - self.edgeInsets.top - self.edgeInsets.bottom;
    CGFloat backCenterX = self.edgeInsets.left + backWidth / 2.0;
    CGFloat backCenterY = self.edgeInsets.top + backHeight / 2.0;
    
    _backGroundView.bounds = CGRectMake(0, 0, backWidth, backHeight);
    _backGroundView.center = CGPointMake(backCenterX, backCenterY);

}


#pragma mark - set/get

-(double)rowsPad{
    return (self.kk_height - self.rows * self.itemRadius * 2) / (self.rows - 1);
}

-(double)colsPad{
    return (self.kk_width - self.cols * self.itemRadius * 2) / (self.cols - 1);
}

-(void)setEdgeInsets:(UIEdgeInsets)edgeInsets{
    [self willChangeValueForKey:NSStringFromSelector(@selector(edgeInsets))];
    _edgeInsets = edgeInsets;
    [self layoutIfNeeded];
    [self didChangeValueForKey:NSStringFromSelector(@selector(edgeInsets))];
}

-(void)setItemRadius:(CGFloat)itemRadius{
    [self willChangeValueForKey:NSStringFromSelector(@selector(itemRadius))];
    _itemRadius = itemRadius;
    [self didChangeValueForKey:NSStringFromSelector(@selector(itemRadius))];
}


#pragma mark - observer
-(NSArray *)arrObservers{
    if (!_arrObservers) {
        _arrObservers = @[
                          NSStringFromSelector(@selector(itemRadius)),
                          NSStringFromSelector(@selector(itemInCircleRadius)),
                          
                          NSStringFromSelector(@selector(itemBorderWidth)),
                          NSStringFromSelector(@selector(itemInBorderWidth)),
                          
                          NSStringFromSelector(@selector(itemBackGroundColor)),
                          NSStringFromSelector(@selector(itemSeletedBackGroundColor)),
                          NSStringFromSelector(@selector(itemBorderColor)),
                          NSStringFromSelector(@selector(itemSeletedBorderColor)),
                          NSStringFromSelector(@selector(itemErrorBorderColor)),
                          NSStringFromSelector(@selector(itemErrorBackGroundColor)),
                          
                          NSStringFromSelector(@selector(itemInBackGroundColor)),
                          NSStringFromSelector(@selector(itemInBorderColor)),
                          NSStringFromSelector(@selector(itemInSeletedBackGroundColor)),
                          NSStringFromSelector(@selector(itemInSeletedBorderColor)),
                          NSStringFromSelector(@selector(itemInErrorBorderColor)),
                          NSStringFromSelector(@selector(itemInErrorBackGroundColor)),
                          ];
    }
    return _arrObservers;
}

-(void)addObservers{
    for (NSString * tmp in self.arrObservers) {
        [self addObserver:self forKeyPath:tmp options:NSKeyValueObservingOptionNew context:nil];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void *)context{
    [_backGroundView needUpConfigureValue:change[NSKeyValueChangeNewKey] keyPath:keyPath];
}



#pragma mark - 回调代理
-(KKGestureViewState)delegateForEndCount:(int)count{
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(gestureView:currentConnectPoints:)]) {
        return [self.delegate gestureView:self currentConnectPoints:count];
    }
    return KKGestureViewStateNormal;
}

-(void)delegateForNewState:(KKGestureViewState)newState oldState:(KKGestureViewState)oldState{
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(gestureView:changeToState:fromState:)]) {
        [self.delegate gestureView:self changeToState:newState fromState:oldState];
    }
}

-(void)dealloc{
    for (NSString * tmp in self.arrObservers) {
        [self removeObserver:self forKeyPath:tmp];
    }
}

@end
