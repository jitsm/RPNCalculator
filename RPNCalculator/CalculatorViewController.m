//
//  CalculatorViewController.m
//  RPNCalculator
//
//  Created by Jitesh Maiyuran on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"
#import "GraphViewController.h"
#import "SplitViewBarButtonItemPresenter.h"
@interface CalculatorViewController()<UISplitViewControllerDelegate>

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic, strong) NSMutableDictionary *testVariableValues;
@property (nonatomic) BOOL programHasVariables;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize allOperations;
@synthesize variableDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize testVariableValues = _testVariableValues;
@synthesize programHasVariables;

-(id<SplitViewBarButtonItemPresenter>)splitViewBarButtonItemPresenter
{
    id detailVC = [self.splitViewController.viewControllers lastObject];
    if(![detailVC conformsToProtocol:@protocol(SplitViewBarButtonItemPresenter)])
        detailVC = nil;
    
    return detailVC;
}
- (BOOL)splitViewController:(UISplitViewController *)svc 
   shouldHideViewController:(UIViewController *)vc 
              inOrientation:(UIInterfaceOrientation)orientation
{
    return [self splitViewBarButtonItemPresenter] ? UIInterfaceOrientationIsPortrait(orientation) : NO;
}

- (void)splitViewController:(UISplitViewController *)svc 
     willHideViewController:(UIViewController *)aViewController 
          withBarButtonItem:(UIBarButtonItem *)barButtonItem 
       forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = @"RPN Calculator";
    [self splitViewBarButtonItemPresenter].splitViewBarButtonItem = barButtonItem;
    
}

- (void)splitViewController:(UISplitViewController *)svc 
     willShowViewController:(UIViewController *)aViewController 
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self splitViewBarButtonItemPresenter].splitViewBarButtonItem = barButtonItem;
}
- (void)awakeFromNib
{
    self.splitViewController.delegate = self;
}
- (NSDictionary *)testVariableValues
{
    if(!_testVariableValues)_testVariableValues = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithDouble:2], @"x", nil];
    return _testVariableValues;
}
- (CalculatorBrain *)brain
{
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (GraphViewController *)splitViewGraphViewController
{
    id gvc = [self.splitViewController.viewControllers lastObject];
    if(![gvc isKindOfClass:[GraphViewController class]])
        gvc = nil;
    
    return gvc;
        
        
}
- (IBAction)graphPressed 
{
    if(self.splitViewController)
    {
        [self splitViewGraphViewController].graphBrain.programStack = self.brain.program;
    }

}
- (IBAction)undoPressed 
{
    if(self.userIsInTheMiddleOfEnteringANumber)
    {
        self.display.text = [self.display.text substringToIndex:([self.display.text length] - 1)]; 

    }
        
    else
    {
        self.allOperations.text = [self.allOperations.text substringToIndex:([self.allOperations.text length] - 2)];
        [self.brain removeLastObjectOnProgramStack];
        self.display.text = @"";
    }
   
}

- (IBAction)digitPressed:(UIButton *)sender 
{
    if(userIsInTheMiddleOfEnteringANumber)
    {
        if(!([sender.currentTitle isEqualToString:@"."] && [self.display.text rangeOfString:@"."].location != NSNotFound)) 
            self.display.text = [self.display.text stringByAppendingString:sender.currentTitle];
    }
        
    else
    {
        self.display.text = sender.currentTitle;
        userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)clearPressed 
{
    self.display.text = @"0";
    self.allOperations.text = @"";
    [self.brain clear];
    self.programHasVariables = NO;
}

- (IBAction)addToOperationDisplay:(NSString *)string
{
    self.allOperations.text = [self.allOperations.text stringByAppendingFormat:@" "];
    self.allOperations.text = [self.allOperations.text stringByAppendingFormat:string];
}
- (IBAction)enterPressed 
{
    if([[self.testVariableValues allKeys] containsObject:self.display.text])
    {
        [self.brain pushVariable:self.display.text];
    }
    else
        [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    [self addToOperationDisplay:[CalculatorBrain descriptionOfProgram:self.brain.program]];
}

- (IBAction)operationPressed:(id)sender 
{
    if(self.userIsInTheMiddleOfEnteringANumber)
    {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result;
    if(programHasVariables)
        result = [self.brain performOperation:operation usingVariableValues:self.testVariableValues];
    else
        result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}
- (IBAction)variablePressed:(UIButton *)sender 
{
    self.display.text = sender.currentTitle;

    self.programHasVariables = YES;
    userIsInTheMiddleOfEnteringANumber = YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"displayGraph"])
    {
        GraphViewController *graphVC = segue.destinationViewController;
        graphVC.graphBrain.programStack = self.brain.program;
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
