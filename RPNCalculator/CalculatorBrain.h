//
//  CalculatorBrain.h
//  RPNCalculator
//
//  Created by Jitesh Maiyuran on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double) operand;
- (double)performOperation:(NSString *)operation;
- (void)clear;

@property (nonatomic, readonly) id program;

+ (NSString *)descriptionOfProgram:(id)program;
+ (double)runProgram:(id)program;
+ (NSSet *)variablesUsedInProgram:(id)program;
+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues;
- (void)pushVariable:(NSString *)variable;
- (double)performOperation:(NSString *)operation usingVariableValues:(NSDictionary *)variableValues;
- (void)removeLastObjectOnProgramStack;
@end
