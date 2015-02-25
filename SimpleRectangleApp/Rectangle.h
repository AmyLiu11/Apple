//
//  Rectangle.h
//  SimpleRectangleApp
//
//  Created by Xiaofen Liu on 2/24/15.
//  Copyright (c) 2015 Xiaofen Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Rectangle;
@protocol rectangleIntersectionProtocol <NSObject>

- (void)testIntersectionRect:(Rectangle*)rec;
- (void)cancelInteractionDisplay:(Rectangle*)rec;

@end

@interface Rectangle : UIView<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIColor * recColor;
@property(nonatomic,weak)id<rectangleIntersectionProtocol> delegate;

- (id)initWithPosition:(CGPoint)position andColor:(UIColor*)color;

@end
