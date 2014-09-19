//
//  GraphView.h
//  RPNCalculator
//
//  Created by Jitesh Maiyuran on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GraphView;
@protocol provideGraphValue

- (float) getGraphValueForX:(float)x withSender:(GraphView *)sender;

@end

@interface GraphView : UIView

@property (nonatomic) CGFloat scale;
@property (nonatomic, weak) IBOutlet id <provideGraphValue> xValueProvider;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;
- (void)pan:(UIPanGestureRecognizer *)gesture;

@end
