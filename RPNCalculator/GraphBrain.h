//
//  GraphBrain.h
//  RPNCalculator
//
//  Created by Jitesh Maiyuran on 7/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalculatorBrain.h"
#import "GraphView.h"


@interface GraphBrain : CalculatorBrain <provideGraphValue>

@property (nonatomic, strong) NSMutableArray *programStack;

@end
