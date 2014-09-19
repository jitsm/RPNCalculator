//
//  GraphView.m
//  RPNCalculator
//
//  Created by Jitesh Maiyuran on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphView.h"
#import "AxesDrawer.h"


@interface GraphView()

@property (nonatomic)CGPoint origin;

@end

@implementation GraphView

@synthesize origin = _origin;
@synthesize scale = _scale;
@synthesize xValueProvider = _xValueProvider;

- (void)setScale:(CGFloat)scale
{
    if(scale != _scale)
    {
        _scale = scale;
        [self setNeedsDisplay];
    }
}

- (CGFloat)scale
{
    if(!_scale)
        return 1.0;
    else
        return _scale;
}

- (void)setOrigin:(CGPoint)origin
{
    if(!((origin.x == _origin.x) && (origin.y == _origin.y)))
    {
         _origin = origin;
        [self setNeedsDisplay];
    }
   
}

- (CGPoint)origin
{
    if((!_origin.x) && (!_origin.y))
    {
        CGPoint center;
        center.x = self.bounds.origin.x + self.bounds.size.width / 2;
        center.y = self.bounds.origin.x + self.bounds.size.height / 2;
        return center;
    }
    else
        return _origin;

    
}

- (void)setup
{
    self.contentMode = UIViewContentModeRedraw;
}
- (void)awakeFromNib
{
    [self setup];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if((gesture.state == UIGestureRecognizerStateChanged) || (gesture.state == UIGestureRecognizerStateEnded))
        self.scale *= gesture.scale;
    gesture.scale = 1;
        
}

- (void)pan:(UIPanGestureRecognizer *)gesture
{
    if((gesture.state == UIGestureRecognizerStateChanged) || (gesture.state == UIGestureRecognizerStateEnded))
    {

        
        CGPoint translation = [gesture translationInView:self];
        
        CGPoint newOrigin = self.origin;
        newOrigin.x = newOrigin.x + translation.x;
        newOrigin.y = newOrigin.y + translation.y;
        self.origin = newOrigin;

        [gesture setTranslation:CGPointZero inView:self];
        
    }
}

- (void)drawRect:(CGRect)rect
{
    [AxesDrawer drawAxesInRect:self.bounds originAtPoint:self.origin scale:self.scale]; 
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    for(int i = self.bounds.origin.x; i <= self.bounds.origin.x + self.bounds.size.width; i++)
    {
        CGFloat pixelsFromOrigin = i - self.origin.x;

        CGFloat modelXValue = pixelsFromOrigin / self.scale;//self.scale is also how many units is each pixel
        CGFloat modelYValue = [self.xValueProvider getGraphValueForX:modelXValue withSender:self];

        CGFloat yValueInView = self.origin.y - modelYValue * self.scale;
        
        
        if(i == 0)
            CGContextMoveToPoint(context, (i * 1.0), yValueInView);
        else
            CGContextAddLineToPoint(context, (i * 1.0), yValueInView);
                
        
    }
    [[UIColor greenColor] setStroke];
    
    CGContextDrawPath(context, kCGPathStroke);
    
    
    
}


@end
