//
//  Rectangle.h
//  SimpleRectangleApp
//
//  Created by Xiaofen Liu on 2/24/15.
//  Copyright (c) 2015 Xiaofen Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Rectangle;
@protocol rectangleProtocol <NSObject>

- (Rectangle*)needLowerView:(Rectangle*)rec;

@end

@interface Rectangle : UIView<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIColor * recColor;
@property(nonatomic,weak)id<rectangleProtocol> delegate;

- (id)initWithPosition:(CGPoint)position andColor:(UIColor*)color;
-(void)testIntersectionRect:(Rectangle*)rect;

@end
