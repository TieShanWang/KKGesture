//
//  KKGestureItem.m
//  KKSideViewController
//
//  Created by MR.KING on 16/7/15.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "KKGestureItem.h"

@implementation KKGestureItem

-(CGFloat)itemRadius{
    return self.frame.size.width / 2.0f;
}

-(void)setState:(KKGestureItemState)state{
    _state = state;
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    
    CGFloat width = self.frame.size.width;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor * itemBGColor = (_state == KKGestureItemStateNoraml)?self.itemBackGroundColor:
    ((_state == KKGestureItemStateError)?self.itemErrorBackGroundColor:self.itemSeletedBackGroundColor);
    
    UIColor * itemBDColor = (_state == KKGestureItemStateNoraml)?self.itemBorderColor:
    ((_state == KKGestureItemStateError)?self.itemErrorBorderColor:self.itemSeletedBorderColor);
    
    
    
    // 大圆 边框
    CGContextSetLineWidth(context, self.itemBorderWidth);
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    
    CGContextSetStrokeColorWithColor(context,itemBDColor.CGColor);
    
    CGContextAddArc(context, width / 2.0, width / 2.0, width / 2.0 - _itemBorderWidth / 2.0, 0, M_PI * 2, 1);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    
    CGContextSetLineWidth(context, 0);
    
    CGContextSetFillColorWithColor(context, itemBGColor.CGColor);
    
    CGContextSetStrokeColorWithColor(context,[UIColor clearColor].CGColor);
    
    CGContextAddArc(context, width / 2.0, width / 2.0, width / 2.0 - _itemBorderWidth, 0, M_PI * 2, 1);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
}



@end






@implementation KKGestureForgroundItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self iniData];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self iniData];
    }
    return self;
}

-(CGFloat)itemRadius{
    return self.frame.size.width / 2.0f;
}

-(void)setState:(KKGestureItemState)state{
    if (state == _state) {
        return ;
    }
    _state = state;
    [self setNeedsDisplay];
}



-(void)iniData{
    
    _state = KKGestureItemStateNoraml;
    
    _itemBorderWidth = 2;
    
    _itemBackGroundColor = [UIColor whiteColor];
    
    _itemSeletedBackGroundColor = [UIColor cyanColor];
    
    _itemBorderColor = [UIColor cyanColor];
    
    _itemSeletedBorderColor = [UIColor redColor];
    
    _itemErrorBackGroundColor = [UIColor redColor];
    
    _itemErrorBorderColor = [UIColor blueColor];
    
}


@end




@implementation KKGestureBackItem


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self iniData];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self iniData];
    }
    return self;
}

-(CGFloat)itemRadius{
    return self.frame.size.width / 2.0f;
}

-(void)setState:(KKGestureItemState)state{
    _state = state;
    [self setNeedsDisplay];
}



-(void)iniData{
    
    _state = KKGestureItemStateNoraml;
    
    _itemBorderWidth = 5;
    
    _itemBackGroundColor = [UIColor blueColor];
    
    _itemSeletedBackGroundColor = [UIColor purpleColor];
    
    _itemBorderColor = [UIColor redColor];
    
    _itemSeletedBorderColor = [UIColor greenColor];
    
    _itemErrorBackGroundColor = [UIColor redColor];
    
    _itemErrorBorderColor = [UIColor blueColor];
    
}
@end


