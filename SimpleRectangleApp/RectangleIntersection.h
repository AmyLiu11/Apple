//
//  RectangleIntersection.h
//  SimpleRectangleApp
//
//  Created by Amy on 2/27/15.
//  Copyright (c) 2015 Xiaofen Liu. All rights reserved.
//

// helper class to detect whether two rectangles have intersection and calculate the intersection area
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RectangleIntersection : NSObject

//method to detect if there is a intersection between two rectangles
+ (BOOL)isIntersectionInRect:(CGRect)rect1 andRect:(CGRect)rect2;

//method to return the area of of intersection area
+ (CGRect)getIntersectionInRect:(CGRect)rect1 andRect:(CGRect)rect2;

@end
