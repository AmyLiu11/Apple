//
//  RectangleIntersection.h
//  SimpleRectangleApp
//
//  Created by Amy on 2/27/15.
//  Copyright (c) 2015 Xiaofen Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RectangleIntersection : NSObject

+ (BOOL)isIntersectionInRect:(CGRect)rect1 andRect:(CGRect)rect2;
+ (CGRect)getIntersectionInRect:(CGRect)rect1 andRect:(CGRect)rect2;

@end
