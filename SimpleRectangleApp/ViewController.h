//
//  ViewController.h
//  SimpleRectangleApp
//
//  Created by Xiaofen Liu on 2/24/15.
//  Copyright (c) 2015 Xiaofen Liu. All rights reserved.
//

//view controller to display intro view and main screen of the app
#import <UIKit/UIKit.h>
#import "Rectangle.h"
#import "MYIntroductionPanel.h"
#import "MYIntroductionView.h"

@interface ViewController : UIViewController<rectangleIntersectionProtocol,MYIntroductionDelegate>

@end

