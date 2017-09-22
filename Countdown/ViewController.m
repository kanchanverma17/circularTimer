//
//  ViewController.m
//  Countdown
//
//  Created by MAC on 11/09/17.
//  Copyright © 2017 MAC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    int countValue;
    NSTimer *timer;
    CGFloat endLimit;
    CGFloat commonDiff;
    CGFloat commonDiffAngle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    countValue = 120;
    endLimit = M_PI_2 + M_PI;
    CGFloat radius = self.timerFrameVW.frame.size.width/2;
    commonDiff = (2*M_PI*radius)/countValue;
    commonDiffAngle = commonDiff/radius;
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
 timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(drawAcircle) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer fire];
}

-(void)drawAcircle
{
    if(countValue>0)
    {
        CAShapeLayer *circle = [CAShapeLayer layer];
        CGFloat wth = self.timerFrameVW.bounds.size.width;
        CGFloat ht = self.timerFrameVW.bounds.size.height;
        CGPoint centerofloader =CGPointMake(self.timerFrameVW.bounds.origin.x+wth/2, self.timerFrameVW.bounds.origin.y+ht/2);
        CGFloat endLimit2=endLimit+commonDiffAngle;
        
        circle.frame = self.timerFrameVW.bounds;
        dispatch_async(dispatch_get_main_queue(),^{
                        [UIView transitionWithView:self.timerFrameVW duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                             circle.frame = self.timerFrameVW.bounds;
                            circle.path = [UIBezierPath bezierPathWithArcCenter:centerofloader radius:self.timerFrameVW.frame.size.width/2 startAngle:endLimit endAngle:endLimit2 clockwise:YES].CGPath;
                            circle.fillColor = [UIColor clearColor].CGColor;
                            circle.strokeColor = [UIColor blueColor].CGColor;
                            circle.lineWidth = 4;
                            [self.timerFrameVW.layer addSublayer:circle];
                            endLimit=endLimit2;
                            int newTime = countValue -1;
                            countValue = newTime;
                            NSDateComponents *comps = [[NSDateComponents alloc] init];
                            comps.minute = newTime/60;
                            comps.second = newTime % 60;
                            
                            NSCalendar *calendar = [NSCalendar currentCalendar];
                            NSDate *periodDate = [calendar dateFromComponents:comps];
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                            [dateFormatter setDateFormat:@"mm:ss"];
                            NSLog(@"periodDuration: %@",[dateFormatter stringFromDate:periodDate]);
                            NSString *str = [dateFormatter stringFromDate:periodDate];
                            [self.remainTimeLbl setText:str];
                            CABasicAnimation* strokeAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"]; // create animation that changes the strokeEnd property
                            strokeAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; // give it a nice timing function
                            strokeAnim.duration = 1.4; // duration of the animation
                            strokeAnim.fromValue = @(0.0); // provide the start value for the animation, wrapped in an NSNumber literal.
                            strokeAnim.toValue = @(1.0); // provide the end value for the animation, wrapped in an NSNumber literal.
                           // circle.frame = self.timerFrameVW.frame;
                            [circle addAnimation:strokeAnim forKey:@"strokeAnim"];
                            [circle setNeedsDisplay];
                            [self.timerFrameVW layoutIfNeeded];
                            
            } completion:
             
             ^(BOOL finished) {
                 return ;
             }];
            
        });
        

    }
    else
    {
        [timer invalidate];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
