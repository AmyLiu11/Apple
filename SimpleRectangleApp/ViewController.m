//
//  ViewController.m
//  SimpleRectangleApp
//
//  Created by Xiaofen Liu on 2/24/15.
//  Copyright (c) 2015 Xiaofen Liu. All rights reserved.
//

#import "ViewController.h"
#import "RectangleDefines.h"


@interface ViewController ()
@property (strong, nonatomic)Rectangle * recOne;
@property (strong, nonatomic)Rectangle * recTwo;
@property (strong, nonatomic)Rectangle * recIntection;
@property (strong, nonatomic)Rectangle * topRect;
@property (strong, nonatomic)UIButton * resetBtn;
@property (assign, nonatomic)CGRect intersectionArea;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    self.resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.resetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.resetBtn setBackgroundImage:[UIImage imageNamed:@"flee_button_send.png"] forState:UIControlStateNormal];
    self.resetBtn.frame = CGRectMake(self.view.frame.origin.x + (width -  ResetBtnDefaultWidth)/2, self.view.frame.origin.y + height - ResetBtnDefaultHeight - 10, ResetBtnDefaultWidth, ResetBtnDefaultHeight);
    [self.resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.resetBtn setTitle:@"Reset" forState:UIControlStateNormal];
    [self.resetBtn addTarget:self action:@selector(resetRectangles) forControlEvents:UIControlEventTouchUpInside];
    

    self.recOne = [[Rectangle alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + (width -  RecDefaultWidth)/2, self.view.frame.origin.y + RectangleVerticalPadding , RecDefaultWidth, RecDefaultHeight) andColor:RGBACOLOR(153, 255, 204, 1.0)];
    
    self.recOne.tag = 1;
    self.recOne.delegate = self;
     self.recTwo = [[Rectangle alloc] initWithFrame:CGRectMake(self.recOne.frame.origin.x, self.recOne.frame.origin.y + RectangleVerticalGap , RecDefaultWidth, RecDefaultHeight) andColor:RGBACOLOR(255, 255, 153, 1.0)];

    self.recTwo.delegate = self;
    self.recTwo.tag = 2;
    [self.view addSubview:self.recTwo];
    [self.view addSubview:self.recOne];
    [self.view addSubview:self.resetBtn];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    MYIntroductionPanel *panel = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"rsz_rectangle.jpg"] title:@"Simple Rectangle App" description:@"Welcome to Simple Rectangle App! In this app, you will play with two rectangles to change their positions and sizes by gestures. Let me teach you some basic gestures! "];
    
    MYIntroductionPanel *panel1 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"RCHGesturePan.png"] title:@"Pan Gesture" description:@"First, if you want to drag the rectangles, you can simply use pan gestures!"];
    
    MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"RCHGesturePinch.png"] title:@"Pinch Gesture" description:@"Also, you can use pinch gesture to resize the rectangles. Have fun playing around with it!"];
    
    MYIntroductionView *introductionView = [[MYIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) headerText:@"App User Guide" panels:@[panel,panel1, panel2] languageDirection:MYLanguageDirectionLeftToRight];
    [introductionView setBackgroundImage:[UIImage imageNamed:@"SampleBackground"]];
    
    introductionView.delegate = self;
    
    [introductionView showInView:self.view];
}


- (void)resetRectangles{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;

    self.recOne.frame = CGRectMake(self.view.frame.origin.x + (width -  RecDefaultWidth)/2, self.view.frame.origin.y + RectangleVerticalPadding , RecDefaultWidth, RecDefaultHeight);
    self.recTwo.frame = CGRectMake(self.recOne.frame.origin.x, self.recOne.frame.origin.y + RectangleVerticalGap , RecDefaultWidth, RecDefaultHeight);
    [self removeAndHideHighlight];
    [self.view setNeedsLayout];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)testIntersectionRect:(Rectangle*)rec{

    Rectangle * temp = nil;
    Rectangle * lowerRect = nil;
    if ([[self.view.subviews lastObject] isKindOfClass:[Rectangle class]]) {
         temp = (Rectangle*)[self.view.subviews lastObject];
    }
    if (!self.topRect  || (self.topRect && ![self.topRect isEqual:temp])) {
        self.topRect = temp;
    }
    
    lowerRect = self.topRect.tag == 1?self.recTwo : self.recOne;
    
//    CGRect interect = CGRectZero;
    self.intersectionArea = CGRectZero;
    NSLog(@"topRect x: %f, y:%f, sizex: %f, sizey:%f",self.topRect.frame.origin.x,self.topRect.frame.origin.y,self.topRect.frame.size.width, self.topRect.frame.size.height);
    NSLog(@"lowerRect x: %f, y:%f, sizex: %f, sizey:%f",lowerRect.frame.origin.x,lowerRect.frame.origin.y,lowerRect.frame.size.width, lowerRect.frame.size.height);
    if ([self testIntersectionInRect:lowerRect.frame andRect:self.topRect.frame]) {
//            interect = CGRectIntersection(self.recTwo.frame, self.recOne.frame);
//        
//             CGRect transRect =  [self.view convertRect:interect toView:self.topRect];
            CGRect transRect = [self.view convertRect:self.intersectionArea toView:self.topRect];
            if (!self.recIntection) {
                self.recIntection = [[Rectangle alloc] initWithFrame:transRect andColor:RGBACOLOR(224, 224, 224, 1.0)];
                self.recIntection.userInteractionEnabled  = NO;
            }
            
            if (self.recIntection.hidden == YES) {
                self.recIntection.hidden = NO;
            }
        
            if (![self.recIntection isDescendantOfView:self.topRect]) {
                [self.topRect addSubview:self.recIntection];
            }
            self.recIntection.frame = transRect;
        }else{
            [self removeAndHideHighlight];
        }
}

- (BOOL)testIntersectionInRect:(CGRect)rect1 andRect:(CGRect)rect2{
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
        self.intersectionArea = CGRectMake(interRect_x, interRect_y, interRect_w, interRect_h);
        NSLog(@"intersect x: %f, y:%f, w:%f, h:%f", self.intersectionArea.origin.x ,self.intersectionArea.origin.y, self.intersectionArea.size.width, self.intersectionArea.size.height);
        res = YES;
    }else{
        res = NO;
    }
    return res;
}



- (void)cancelInteractionDisplay:(Rectangle*)rec{
     if (!CGRectIntersectsRect(self.recOne.frame, self.recTwo.frame)) {
         [self removeAndHideHighlight];
     }
     CGRect interect = CGRectIntersection(self.recTwo.frame, self.recOne.frame);
     CGRect transRect =  [self.view convertRect:interect toView:self.topRect];
    if (!CGRectEqualToRect(transRect, self.recIntection.frame)) {
        self.recIntection.frame = transRect;
        [self.recIntection setNeedsDisplay];
    }
     [self.topRect setNeedsDisplay];
}

- (void)removeAndHideHighlight{
    if ([self.recIntection isDescendantOfView:self.topRect]) {
        [self.recIntection removeFromSuperview];
    }
    self.recIntection.hidden = YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
     
}



@end
