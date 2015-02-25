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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.genBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [self.genBtn addTarget:self action:@selector(generateRectangle) forControlEvents:UIControlEventTouchUpInside];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    self.recOne = [[Rectangle alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + (width -  RecDefaultWidth)/2, self.view.frame.origin.y + RectangleVerticalPadding , RecDefaultWidth, RecDefaultHeight) andColor:RGBACOLOR(153, 255, 204, 1.0)];
    
    self.recOne.tag = 1;
    self.recOne.delegate = self;
     self.recTwo = [[Rectangle alloc] initWithFrame:CGRectMake(self.recOne.frame.origin.x, self.recOne.frame.origin.y + RectangleVerticalGap , RecDefaultWidth, RecDefaultHeight) andColor:RGBACOLOR(255, 255, 153, 1.0)];

    self.recTwo.delegate = self;
    self.recTwo.tag = 2;
    [self.view addSubview:self.recTwo];
    [self.view addSubview:self.recOne];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)testIntersectionRect:(Rectangle*)rec{

    Rectangle * temp = nil;
    if ([[self.view.subviews lastObject] isKindOfClass:[Rectangle class]]) {
         temp = (Rectangle*)[self.view.subviews lastObject];
    }
    if (!self.topRect  || (self.topRect && ![self.topRect isEqual:temp])) {
        self.topRect = temp;
    }
    
    CGRect interect = CGRectZero;
    if (CGRectIntersectsRect(self.recOne.frame, self.recTwo.frame)) {
            interect = CGRectIntersection(self.recTwo.frame, self.recOne.frame);
//            NSLog(@"higherView width : %f height: %f", self.frame.size.width, self.frame.size.height);
//            NSLog(@"lowerView width : %f height: %f", rect.frame.size.width, rect.frame.size.height);
//            NSLog(@"highLightView width : %f height: %f", interect.size.width, interect.size.height);
        
             CGRect transRect =  [self.view convertRect:interect toView:self.topRect];
            if (!self.recIntection) {
                self.recIntection = [[Rectangle alloc] initWithFrame:transRect andColor:RGBACOLOR(224, 224, 224, 1.0)];
                self.recIntection.userInteractionEnabled  = NO;
            }
            
            if (self.recIntection.hidden == YES) {
                self.recIntection.hidden = NO;
            }
            [self.topRect addSubview:self.recIntection];
            self.recIntection.frame = transRect;
            [self.recIntection setNeedsDisplay];
        }else{
            if ([self.recIntection isDescendantOfView:self.topRect]) {
                [self.recIntection removeFromSuperview];
            }
            self.recIntection.hidden = YES;
        }
       [self.topRect setNeedsDisplay];
}

- (void)cancelInteractionDisplay:(Rectangle*)rec{
     if (!CGRectIntersectsRect(self.recOne.frame, self.recTwo.frame)) {
         if ([self.recIntection isDescendantOfView:self.topRect]) {
             [self.recIntection removeFromSuperview];
         }
         self.recIntection.hidden = YES;
     }
     [self.topRect setNeedsDisplay];
}



@end
