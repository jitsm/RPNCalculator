//
//  CalculatorViewController.h
//  RPNCalculator
//
//  Created by Jitesh Maiyuran on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *allOperations;
@property (weak, nonatomic) IBOutlet UILabel *variableDisplay;

@end
