//
//  GraphViewController.h
//  RPNCalculator
//
//  Created by Jitesh Maiyuran on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphBrain.h"
#import "SplitViewBarButtonItemPresenter.h"
@interface GraphViewController : UIViewController <SplitViewBarButtonItemPresenter>

@property (nonatomic, strong) GraphBrain *graphBrain;

-(NSString *)description;
@end
