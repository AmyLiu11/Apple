//
//  RectangleIntersection.m
//  SimpleRectangleApp
//
//  Created by Amy on 2/27/15.
//  Copyright (c) 2015 Xiaofen Liu. All rights reserved.
//

#import "RectangleIntersection.h"

@implementation RectangleIntersection

+ (BOOL)isIntersectionInRect:(CGRect)rect1 andRect:(CGRect)rect2{
    BOOL res;
    CGFloat rect1_x = rect1.origin.x;
    CGFloat rect1_y = rect1.origin.y;
    CGFloat rect1_w = rect1.size.width;
    CGFloat rect1_h = rect1.size.height;
    CGFloat rect2_x = rect2.origin.x;
    CGFloat rect2_y = rect2.origin.y;
    CGFloat rect2_w = rect2.size.width;
    CGFloat rect2_h = rect2.size.height;
    
    CGPoint p1 = CGPointMake(rect1_x, rect1_y);
    CGPoint p2 = CGPointMake(rect1_x + rect1_w, rect1_y + rect1_h);
    CGPoint p3 = CGPointMake(rect2_x, rect2_y);
    CGPoint p4 = CGPointMake(rect2_x + rect2_w, rect2_y + rect2_h);
    
    if (!(p2.y < p3.y || p1.y > p4.y || p2.x < p3.x || p1.x > p4.x )) {
        res = YES;
    }else{
        res = NO;
    }
    return res;
}

+ (CGRect)getIntersectionInRect:(CGRect)rect1 andRect:(CGRect)rect2{
    CGRect intersection = CGRectZero;
    CGFloat rect1_x = rect1.origin.x;
    CGFloat rect1_y = rect1.origin.y;
    CGFloat rect1_w = rect1.size.width;
    CGFloat rect1_h = rect1.size.height;
    CGFloat rect2_x = rect2.origin.x;
    CGFloat rect2_y = rect2.origin.y;
    CGFloat rect2_w = rect2.size.width;
    CGFloat rect2_h = rect2.size.height;
    
    CGFloat x_diff = fabsf(rect1_x - rect2_x);
    CGFloat y_diff = fabsf(rect1_y - rect2_y);
    CGFloat interRect_x = 0;
    CGFloat interRect_y = 0;
    CGFloat interRect_w = 0;
    CGFloat interRect_h = 0;
    if (rect1_x <= rect2_x) {
            if (rect2_x + rect2_w >= rect1_x + rect1_w) {
                interRect_w = rect1_w - x_diff;
            }else{
                interRect_w = rect2_w;
            }
            interRect_x = rect1_x + x_diff;
    }else{
            if (rect1_x + rect1_w >= rect2_x + rect2_w) {
                interRect_w = rect2_w - x_diff;
            }else{
                interRect_w = rect1_w;
            }
            interRect_x = rect2_x + x_diff;
    }
        
    if (rect2_y >= rect1_y) {
            if (rect2_y + rect2_h >= rect1_y + rect1_h) {
                interRect_h = rect1_h - y_diff;
            }else{
                interRect_h = rect2_h;
            }
            interRect_y = rect1_y + y_diff;
    }else{
            if (rect1_y + rect1_h >= rect2_y + rect2_h) {
                interRect_h = rect2_h - y_diff;
            }else{
                interRect_h = rect1_h;
            }
            interRect_y = rect2_y + y_diff;
    }
    intersection = CGRectMake(interRect_x, interRect_y, interRect_w, interRect_h);
    return intersection;
}



@end
