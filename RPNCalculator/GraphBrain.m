//
//  GraphBrain.m
//  RPNCalculator
//
//  Created by Jitesh Maiyuran on 7/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphBrain.h"
@interface GraphBrain()

@end

@implementation GraphBrain

@synthesize programStack = _programStack;

- (float)getGraphValueForX:(float)x withSender:(GraphView *)sender
{
    NSDictionary *dictionaryForXValue = [[NSDictionary alloc] initWithObjectsAndKeys:([NSNumber numberWithFloat:x]), @"x", nil];
    return [GraphBrain runProgram:self.programStack usingVariableValues:dictionaryForXValue];
}


@end
