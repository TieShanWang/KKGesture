//
//  KKGestureBackView.m
//  KKSideViewController
//
//  Created by MR.KING on 16/7/15.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "KKGestureBackView.h"

#import "KKGestureItem.h"

#import "KKGestureLineView.h"

@interface KKGestureBackView()
{
    CGPoint * _points;
}
/// 代表点的个数
@property(nonatomic,assign)int count;

@property(nonatomic,assign)CGPoint * points;
@property(nonatomic,strong)NSMutableArray * arrForgViews;
@property(nonatomic,strong)NSMutableArray * arrBackViews;

@property(nonatomic,assign)CGFloat radius;
@property(nonatomic,assign)CGFloat inRadius;
@property(nonatomic,assign)NSTimeInterval errorDuraiton;

@property(nonatomic,strong)KKGestureLineView * lineView;

@property(nonatomic,strong)NSMutableArray * arrItems;

@property(nonatomic,assign)KKGestureViewState state;

@property(nonatomic,copy)KKGestureViewState(^ResultBackBlock)(int count);

@property(nonatomic,copy)void(^StateChangeBlock)(KKGestureViewState newState, KKGestureViewState oldState);
@end

@implementation KKGestureBackView

- (instancetype)initWithPoints:(CGPoint*)points
                         count:(int)count
                        radius:(CGFloat)radius
                      inRadius:(CGFloat)inRadius
                 errorDuration:(double)errorDuration
                        result:(KKGestureViewState(^)(int count))result
                         state:(void(^)(KKGestureViewState newState, KKGestureViewState oldState))stateBlock
{
    self = [super init];
    if (self) {
        _arrForgViews = [[NSMutableArray alloc]init];
        _arrBackViews = [[NSMutableArray alloc]init];
        _arrItems = [[NSMutableArray alloc]init];
        _ResultBackBlock = result;
        _StateChangeBlock = stateBlock;
        _errorDuraiton = errorDuration;
        _count = count;
        _points = points;
        _radius = radius;
        _inRadius = inRadius;
        _state = KKGestureViewStateNormal;
        [self initView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
                      points:(CGPoint*)points
                       count:(int)count
                      radius:(CGFloat)radius 
                    inRadius:(CGFloat)inRadius
               errorDuration:(double)errorDuration
                      result:(KKGestureViewState(^)(int count))result
                       state:(void(^)(KKGestureViewState newState, KKGestureViewState oldState))stateBlock{
    self = [super initWithFrame:frame];
    if (self) {
        _arrForgViews = [[NSMutableArray alloc]init];
        _arrBackViews = [[NSMutableArray alloc]init];
        _arrItems = [[NSMutableArray alloc]init];
        _ResultBackBlock = result;
        _StateChangeBlock = stateBlock;
        _errorDuraiton = errorDuration;
        _count = count;
        _points = points;
        _radius = radius;
        _inRadius = inRadius;
        [self initView];
    }
    return self;
}

-(void)setState:(KKGestureViewState)state{
    if (self.StateChangeBlock) {
        self.StateChangeBlock(state,_state);
    }
    _state = state;
}

-(void)changeToState:(KKGestureItemState)state{
    for (KKGestureItem * item in self.arrForgViews) {
        item.state = state;
    }
    for (KKGestureItem * item in self.arrBackViews) {
        item.state = state;
    }
}

-(void)changeToState:(KKGestureItemState)state atIndex:(int)index{
    ((KKGestureItem*)self.arrForgViews[index]).state = state;
    ((KKGestureItem*)self.arrBackViews[index]).state = state;
}

-(void)initView{
    for (int i = 0; i < self.count; i++) {
        
        KKGestureBackItem * inItem = [[KKGestureBackItem alloc]init];
        inItem.bounds = CGRectMake(0, 0, self.radius * 2, self.radius * 2);
        inItem.center = self.points[i];
        inItem.backgroundColor = [UIColor clearColor];
        [self addSubview:inItem];
        [self.arrBackViews addObject:inItem];
    }
    for (int i = 0; i < self.count; i++) {
        KKGestureForgroundItem * item = [[KKGestureForgroundItem alloc]init];
        item.bounds = CGRectMake(0, 0, self.inRadius * 2, self.inRadius * 2);
        item.center = self.points[i];
        item.backgroundColor = [UIColor clearColor];
        [self addSubview:item];
        [self.arrForgViews addObject:item];
    }
    
    _lineView = [[KKGestureLineView alloc]initWithPoints:self.points];
    _lineView.autoresizingMask =  UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self insertSubview:_lineView belowSubview:self.arrForgViews.firstObject];
}

-(void)needUpConfigureValue:(id)value keyPath:(NSString *)keyPath{
    
}

-(void)beginErrorState{
    self.state = KKGestureViewStateError;
    for (NSNumber * num in _arrItems) {
        [self changeToState:KKGestureItemStateError atIndex:num.intValue];
    }
    _lineView.error = YES;
    [self performSelector:@selector(reset) withObject:nil afterDelay:self.errorDuraiton];
}

-(void)reset{
    [_lineView reset];
    [_arrItems removeAllObjects];
    [self changeToState:KKGestureItemStateNoraml];
    self.state = KKGestureViewStateNormal;
}

-(void)endMove{
    KKGestureViewState state;
    if (self.ResultBackBlock && _arrItems.count) {
        state = self.ResultBackBlock((int)_arrItems.count);
    }
    
    if (state == KKGestureViewStateError) {
        [self beginErrorState];
    }else if (state == KKGestureViewStateNormal){
        [self reset];
    }
}

-(void)saveForNewItem:(int)index{
    if ([_arrItems containsObject:@(index)]) {
        return;
    }
    if (_arrItems.count == 0) {
        self.state = KKGestureViewStateNormal;
    }
    [_arrItems addObject:@(index)];
}


-(void)gestureTrackView:(KKGestureTrackView *)gestureTrackView moveToNewPoint:(CGPoint)point{
    if (self.state == KKGestureViewStateError) {
        return;
    }
    [self.lineView moveToPoint:point];
}

-(void)gestureTrackView:(KKGestureTrackView *)gestureTrackView moveToNewItem:(int)index point:(CGPoint)newPoint{
    if (self.state == KKGestureViewStateError) {
        return;
    }
    [self saveForNewItem:index];
    [self changeToState:KKGestureItemStateSeleted atIndex:index];
    [_lineView moveToItem:index point:newPoint];
}

-(void)gestureTrackViewEndTrack:(KKGestureTrackView *)gestureTrackView{
    if (self.state == KKGestureViewStateError) {
        return;
    }
    [_lineView endMove];
    [self endMove];
}

-(void)layoutSubviews{
    _lineView.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _lineView.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
