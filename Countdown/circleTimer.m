//
//  circleTimer.m
//  Countdown
//
//  Created by MAC on 22/09/17.
//  Copyright © 2017 MAC. All rights reserved.
//

#import "circleTimer.h"

@implementation circleTimer
{
    int countValue;
    NSTimer *timer;
    CGFloat endLimit;
    CGFloat commonDiff;
    CGFloat commonDiffAngle;
    UILabel *remainTimeLbl;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)fireThisTimer
{
    countValue = self.maxTime;
    endLimit = M_PI_2 + M_PI;
    CGFloat radius = self.frame.size.width/2;
    commonDiff = (2*M_PI*radius)/countValue;
    commonDiffAngle = commonDiff/radius;
    [self createTimeLabel];
    [self createBase];
    timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(drawAcircle) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer fire];
}

-(void)restartThisTimer
{
    countValue = self.maxTime;
    [self createBase];
    timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(drawAcircle) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer fire];
}

-(void)createTimeLabel
{
    remainTimeLbl = [[UILabel alloc]initWithFrame:CGRectMake(3,self.frame.size.height/2-(self.heightForLabel/2) , self.frame.size.width-6, self.heightForLabel)];
    [self addSubview:remainTimeLbl];
    remainTimeLbl.textAlignment = NSTextAlignmentCenter;
}

-(void)createBase
{
    if ([self isSublayer]) {
        return;
    }
    CAShapeLayer *circle = [CAShapeLayer layer];
    CGFloat wth = self.bounds.size.width;
    CGFloat ht = self.bounds.size.height;
    CGPoint centerofloader =CGPointMake(self.bounds.origin.x+wth/2, self.bounds.origin.y+ht/2);
    circle.frame = self.bounds;
    circle.lineWidth = self.strokeThickness-1;
    circle.path = [UIBezierPath bezierPathWithArcCenter:centerofloader radius:self.frame.size.width/2 startAngle:-M_PI_2 endAngle:2*M_PI+M_PI_2 clockwise:YES].CGPath;
   
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = self.colorForBase.CGColor;
    circle.name = @"path";
    [self.layer addSublayer:circle];
}

-(BOOL)isSublayer {
    NSArray *lyr = [self.layer sublayers];
    for (CAShapeLayer *layer in lyr) {
        if (layer.name == @"path") {
            CABasicAnimation *ani = [layer animationForKey:@"strokeAnim"];
            ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            ani.duration = 1.4;
            ani.fromValue = @(1.0);
            ani.toValue = @(0.0);
            [layer removeFromSuperlayer];
            return YES;
        }
    }
    return NO;
}

-(void)drawAcircle
{
    if(countValue>0)
    {
        CAShapeLayer *circle = [CAShapeLayer layer];
        CGFloat wth = self.bounds.size.width;
        CGFloat ht = self.bounds.size.height;
        CGPoint centerofloader =CGPointMake(self.bounds.origin.x+wth/2, self.bounds.origin.y+ht/2);
        CGFloat endLimit2=endLimit+commonDiffAngle;
        
        circle.frame = self.bounds;
        dispatch_async(dispatch_get_main_queue(),^{
            [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                circle.frame = self.bounds;
                circle.path = [UIBezierPath bezierPathWithArcCenter:centerofloader radius:self.frame.size.width/2 startAngle:endLimit endAngle:endLimit2 clockwise:YES].CGPath;
                circle.fillColor = [UIColor clearColor].CGColor;
                circle.strokeColor = self.colorForStroke.CGColor;
                circle.lineWidth = self.strokeThickness;
                
                [self.layer addSublayer:circle];
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
                NSString *str = [dateFormatter stringFromDate:periodDate];
                [remainTimeLbl setText:str];
                [remainTimeLbl setTextColor:self.colorForText];
                CABasicAnimation* strokeAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
                strokeAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                strokeAnim.duration = 1.4;
                strokeAnim.fromValue = @(0.0);
                strokeAnim.toValue = @(1.0);
                [circle addAnimation:strokeAnim forKey:@"strokeAnim"];
                [circle setNeedsDisplay];
                [self layoutIfNeeded];
                
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
@end
