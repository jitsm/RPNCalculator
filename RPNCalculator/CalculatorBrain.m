//
//  CalculatorBrain.m
//  RPNCalculator
//
//  Created by Jitesh Maiyuran on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (void)clear
{
    [self.programStack removeAllObjects];
}

- (id)program
{
    return [self.programStack copy];
}


+ (NSString *)descriptionOfProgram:(id)program
{
    return @"";
    NSArray *programStack;
    if([program isKindOfClass:[NSArray class]])
        programStack = [program copy];
    else if([programStack count] == 1)
        return [programStack objectAtIndex:0];
    
    else
        return @"";
}

- (NSArray *)programStack
{
    if(!_programStack)
    {
        _programStack = [[NSMutableArray alloc] init];
    }
    return _programStack;
}
- (double)popOperand
{
    NSNumber *operandObject = [self.programStack lastObject];
    if(operandObject) [self.programStack removeLastObject];
    return [operandObject doubleValue];
}
- (void)pushOperand:(double) operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return [[self class] runProgram:self.program];
    
}
- (double)performOperation:(NSString *)operation usingVariableValues:(NSDictionary *)variableValues
{
    [self.programStack addObject:operation];
    return [[self class] runProgram:self.program usingVariableValues:variableValues];
}

+ (double)popOperandOffProgramStack:(NSMutableArray *)stack
{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]])
    {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]])
    {
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]) 
        {
            result = [self popOperandOffProgramStack:stack] +
            [self popOperandOffProgramStack:stack];
        } 
        else if ([@"*" isEqualToString:operation]) 
        {
            result = [self popOperandOffProgramStack:stack] *
            [self popOperandOffProgramStack:stack];
        } 
        else if ([operation isEqualToString:@"-"]) 
        {
            double subtrahend = [self popOperandOffProgramStack:stack];
            result = [self popOperandOffProgramStack:stack] - subtrahend;
        } 
        else if ([operation isEqualToString:@"/"]) 
        {
            double divisor = [self popOperandOffProgramStack:stack];
            if (divisor) result = [self popOperandOffProgramStack:stack] / divisor;
        }
        else if([operation isEqualToString:@"sin"])
        {
            result = sin([self popOperandOffProgramStack:stack]);
        }
        else if([operation isEqualToString:@"cos"])
        {
            result = cos([self popOperandOffProgramStack:stack]);
        }
        else if([operation isEqualToString:@"pi"])
        {
            result = M_PI;
        }
        else if([operation isEqualToString:@"sqrt"])
        {
            result = sqrt([self popOperandOffProgramStack:stack]);
        }
    }
    
    return result;
}

- (void)pushVariable:(NSString *)variable
{
    [self.programStack addObject:variable];
}
+ (double)runProgram:(id)program
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self popOperandOffProgramStack:stack];
}

+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues
{
    
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) 
    {
        stack = [program mutableCopy];
    }
    for(int i = 0; i < [stack count]; i++)
    {
        id stackObject = [stack objectAtIndex:i];
        if([stackObject isKindOfClass:[NSString class]])
        {
           
            if([[variableValues allKeys] containsObject:stackObject])
            {
                [stack replaceObjectAtIndex:i withObject:[variableValues objectForKey:stackObject]];
            }
                
        }
            
    }
    return [self popOperandOffProgramStack:stack];
}
+ (NSSet *)variablesUsedInProgram:(id)program
{
    NSMutableArray *stack;
    if([program isKindOfClass:[NSMutableArray class]])
    {
        stack = [program mutableCopy];
    }
    NSMutableSet *variables;
    for(id stackObject in stack )
    {
        if([stackObject isKindOfClass:[NSString class]] && ![variables containsObject:stackObject])
            [variables addObject:stackObject];
    }
    return variables;
}

- (void)removeLastObjectOnProgramStack
{
    if([self.programStack count] > 0)
        [self.programStack removeLastObject];
    
}

@end
