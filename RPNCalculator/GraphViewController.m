//
//  GraphViewController.m
//  RPNCalculator
//
//  Created by Jitesh Maiyuran on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphViewController.h"
#import "GraphView.h"
#import "SplitViewBarButtonItemPresenter.h"

@interface GraphViewController()

@property (nonatomic, weak) IBOutlet GraphView *graphView;
@property (nonatomic, weak) IBOutlet UIToolbar  *toolbar;


@end

@implementation GraphViewController

@synthesize graphBrain = _graphBrain;
@synthesize toolbar = _toolbar;
@synthesize graphView = _graphView;
@synthesize splitViewBarButtonItem = _splitViewBarButtonItem;

- (void)setGraphView:(GraphView *)graphView
{
    _graphView = graphView;
    
    [self.graphView addGestureRecognizer:[[UIPinchGestureRecognizer alloc]initWithTarget:self.graphView action:@selector(pinch:)]];
    [self.graphView addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self.graphView action:@selector(pan:)]];
    self.graphView.xValueProvider = self.graphBrain;
}

- (void)setSplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem
{
    NSMutableArray *toolbarItems = [self.toolbar.items mutableCopy];
    if(_splitViewBarButtonItem) [toolbarItems removeObject:_splitViewBarButtonItem];
    if(splitViewBarButtonItem) [toolbarItems insertObject:splitViewBarButtonItem atIndex:0];
    self.toolbar.items = toolbarItems;
    _splitViewBarButtonItem = splitViewBarButtonItem;
}

-(GraphBrain *)graphBrain
{
    if(!_graphBrain) _graphBrain = [[GraphBrain alloc] init];
    return _graphBrain;
}
-(NSString *)description
{
    return @"this VC has been instantiated";
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
