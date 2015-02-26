//
//  Rectangle.m
//  SimpleRectangleApp
//
//  Created by Xiaofen Liu on 2/24/15.
//  Copyright (c) 2015 Xiaofen Liu. All rights reserved.
//

#import "Rectangle.h"
#import "RectangleDefines.h"

@interface Rectangle()
@property (assign, nonatomic)CGFloat trans_x;
@property (assign, nonatomic)CGFloat trans_y;
@property (assign, nonatomic)CGFloat scaleFactor;
@property (strong, nonatomic)Rectangle * highLightView;

@end

@implementation Rectangle


- (id)initWithFrame:(CGRect)frame andColor:(UIColor*)color{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        
        self.userInteractionEnabled = YES;
        
        self.transform = CGAffineTransformIdentity;
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(handlePinch:)];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(handlePan:)];
        
//        UIPanGestureRecognizer *swipe = [[UIPanGestureRecognizer alloc]
//                                       initWithTarget:self action:@selector(handleSwipe:)];

        
        self.gestureRecognizers = @[pinch, pan];
        
        for (UIGestureRecognizer *recognizer in self.gestureRecognizers){
            recognizer.delegate = self;
        }
        
        self.trans_y = 0.0f;
        self.trans_x = 0.0f;
        self.scaleFactor = 1.0f;
        self.recColor = color;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, self.recColor.CGColor);
    CGContextFillRect (context, CGRectMake (0, 0, rect.size.width, rect.size.height));
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.superview bringSubviewToFront:self];
    
    self.trans_x = self.transform.tx;
    self.trans_y = self.transform.ty;
    self.scaleFactor = [self getScaleFactor:self.transform];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
      [self.delegate cancelInteractionDisplay:self];
}

- (CGFloat)getScaleFactor:(CGAffineTransform)transform{
    CGFloat scale = sqrt(transform.a * transform.a + transform.c * transform.c);
    return scale;
}


- (void)handlePinch:(UIPinchGestureRecognizer*)pinchGes{
    self.scaleFactor = pinchGes.scale;
    NSLog(@"%f",self.scaleFactor);
    if (pinchGes.state == UIGestureRecognizerStateChanged) {
        [self.delegate testIntersectionRect:self];
    }else if(pinchGes.state == UIGestureRecognizerStateCancelled || pinchGes.state == UIGestureRecognizerStateEnded){
        [self.delegate cancelInteractionDisplay:self];
    }else{
        // do nothing
    }

    [self updateScaleAndTranslation:CGPointZero];
}

- (void)handlePan:(UIPanGestureRecognizer*)panGes{
    CGPoint trans = [panGes translationInView:self.superview];
    if (panGes.state == UIGestureRecognizerStateChanged) {
        [self.delegate testIntersectionRect:self];
    }else if(panGes.state == UIGestureRecognizerStateCancelled || panGes.state == UIGestureRecognizerStateEnded){
        [self.delegate cancelInteractionDisplay:self];
    }else{
        //do nothing
    }
    [self updateScaleAndTranslation:trans];
}

- (void)updateScaleAndTranslation:(CGPoint)trans{
    self.transform = CGAffineTransformMakeTranslation(trans.x + self.trans_x, trans.y + self.trans_y);
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat threshold = width / RecDefaultWidth;
    if (self.scaleFactor > threshold){
        self.transform = CGAffineTransformScale(self.transform, threshold, threshold);
    }else if(self.scaleFactor < 0.5f){
        self.transform = CGAffineTransformScale(self.transform, 0.5f, 0.5f);
    }else{
        self.transform = CGAffineTransformScale(self.transform, self.scaleFactor, self.scaleFactor);
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}

@end
