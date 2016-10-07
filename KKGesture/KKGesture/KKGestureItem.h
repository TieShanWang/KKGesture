//
//  KKGestureItem.h
//  KKSideViewController
//
//  Created by MR.KING on 16/7/15.
//  Copyright © 2016年 KING. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    KKGestureItemStateNoraml,
    KKGestureItemStateSeleted,
    KKGestureItemStateError,
} KKGestureItemState;



/**
 *  对于手势中圆点的一个抽象类
 *  需要子类集成本类，并且需要在视图绘制之前初始化所有的属性
 */
@interface KKGestureItem : UIView
{
    KKGestureItemState _state;
    CGFloat itemRadius;
    UIColor * _itemBackGroundColor;
    UIColor * _itemBorderColor;
    UIColor * _itemSeletedBackGroundColor;
    UIColor * _itemSeletedBorderColor;
    UIColor * _itemErrorBackGroundColor;
    UIColor * _itemErrorBorderColor;
    CGFloat _itemBorderWidth;
}

/// 圆的半径
@property(nonatomic,assign,readonly)CGFloat itemRadius;

/// 背景颜色
@property(nonatomic,strong)UIColor * itemBackGroundColor;

/// 边框颜色
@property(nonatomic,strong)UIColor * itemBorderColor;

/// 选中下的背景颜色
@property(nonatomic,strong)UIColor * itemSeletedBackGroundColor;

/// 选中下的边框颜色
@property(nonatomic,strong)UIColor * itemSeletedBorderColor;

/// 错误下的背景颜色
@property(nonatomic,strong)UIColor * itemErrorBackGroundColor;

/// 错误下的边框颜色
@property(nonatomic,strong)UIColor * itemErrorBorderColor;

/// 边框宽度
@property(nonatomic,assign)CGFloat itemBorderWidth;

/// state
@property(nonatomic,assign)KKGestureItemState state;

@end





/**
 *  手势中 圆 中小圆的抽象类
 */
@interface KKGestureForgroundItem : KKGestureItem

@end






/**
 *  手势中 圆 中大圆的抽象类
 */
@interface KKGestureBackItem : KKGestureItem

@end

