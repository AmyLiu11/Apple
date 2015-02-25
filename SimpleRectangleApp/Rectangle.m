//
//  Rectangle.m
//  SimpleRectangleApp
//
//  Created by Xiaofen Liu on 2/24/15.
//  Copyright (c) 2015 Xiaofen Liu. All rights reserved.
//

#import "Rectangle.h"


static const CGFloat RecDefaultWidth = 200;
static const CGFloat RecDefaultHeight = 100;

@interface Rectangle()
@property (assign, nonatomic)CGFloat trans_x;
@property (assign, nonatomic)CGFloat trans_y;
@property (assign, nonatomic)CGFloat scaleFactor;
@property (strong, nonatomic)Rectangle * highLightView;

@end

@implementation Rectangle

//- (id)initWithFrame:(CGRect)frameRect
//{
//    self = [super initWithFrame:frameRect];
//    return self;
//}

- (id)initWithPosition:(CGPoint)position andColor:(UIColor*)color{
    CGRect frame = CGRectMake(0, 0, RecDefaultWidth, RecDefaultHeight);
    
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(position.x, position.y, frame.size.width, frame.size.height);
        
        self.userInteractionEnabled = YES;
        
        self.transform = CGAffineTransformIdentity;
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(handlePinch:)];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(handlePan:)];
        
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
    Rectangle * lower = [self.delegate needLowerView:self];
    if (lower != nil && ![lower isEqual:self]) {
        [self testIntersectionRect:lower];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}


- (CGFloat)getScaleFactor:(CGAffineTransform)transform{
    CGFloat scale = sqrt(transform.a * transform.a + transform.c * transform.c);
    return scale;
}


- (void)handlePinch:(UIPinchGestureRecognizer*)pinchGes{
    self.scaleFactor = pinchGes.scale;
    NSLog(@"%f",self.scaleFactor);
    [self updateScaleAndTranslation:CGPointZero];
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


- (void)handlePan:(UIPanGestureRecognizer*)panGes{
    CGPoint trans = [panGes translationInView:self.superview];
    if (panGes.state == UIGestureRecognizerStateChanged) {
        Rectangle * lower = [self.delegate needLowerView:self];
        if (lower != nil && ![lower isEqual:self]) {
            [self testIntersectionRect:lower];
        }
    }
    [self updateScaleAndTranslation:trans];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)testIntersectionRect:(Rectangle*)rect{
    CGRect interect = CGRectZero;
    if (CGRectIntersectsRect(self.frame, rect.frame)) {
         interect = CGRectIntersection(self.frame, rect.frame);
        
        if (!self.highLightView) {
            self.highLightView = [[Rectangle alloc] initWithPosition:[self.superview convertPoint:interect.origin toView:self] andColor:[UIColor yellowColor]];
            self.highLightView.frame = CGRectMake(self.highLightView.frame.origin.x, self.highLightView.frame.origin.y, interect.size.width, interect.size.height);
            [self addSubview:self.highLightView];
        }
        CGPoint origin = [self.superview convertPoint:interect.origin toView:self];
        self.highLightView.frame = CGRectMake(origin.x, origin.y, interect.size.width, interect.size.height);
        [self.highLightView setNeedsDisplay];
    }
}


@end
