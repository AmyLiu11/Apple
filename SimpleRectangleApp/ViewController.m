//
//  ViewController.m
//  SimpleRectangleApp
//
//  Created by Xiaofen Liu on 2/24/15.
//  Copyright (c) 2015 Xiaofen Liu. All rights reserved.
//

#import "ViewController.h"

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]

@interface ViewController ()
@property (strong, nonatomic)Rectangle * recOne;
@property (strong, nonatomic)Rectangle * recTwo;
@property (strong, nonatomic)UIButton * resetBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.genBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [self.genBtn addTarget:self action:@selector(generateRectangle) forControlEvents:UIControlEventTouchUpInside];
    self.recOne = [[Rectangle alloc] initWithPosition:CGPointMake(0, 50) andColor:[UIColor redColor]];
    self.recOne.tag = 1;
    self.recOne.delegate = self;
    self.recTwo = [[Rectangle alloc] initWithPosition:CGPointMake(100, 100) andColor:[UIColor blueColor]];
    self.recTwo.delegate = self;
    self.recTwo.tag = 2;
    [self.view addSubview:self.recTwo];
    [self.view addSubview:self.recOne];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Rectangle*)needLowerView:(Rectangle*)rec{
    if (self.view.subviews.count > 0) {
        for(  UIView* view in self.view.subviews){
            if ([view isKindOfClass:[Rectangle class]]) {
                Rectangle * rect = (Rectangle*)view;
                if (rect.tag != rec.tag) {
                    return rect;
                }
            }
        }
    }
    return nil;
}



@end
