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
//    [super viewDidLoad];
//    countValue = 120;
//    endLimit = M_PI_2 + M_PI;
//    CGFloat radius = self.timerFrameVW.frame.size.width/2;
//    commonDiff = (2*M_PI*radius)/countValue;
//    commonDiffAngle = commonDiff/radius;
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    
    circleTimer *ctimer = [[circleTimer alloc]initWithFrame:self.timerFrameVW.frame];
    ctimer.maxTime = 120;
    ctimer.colorForStroke = [UIColor greenColor];
    ctimer.colorForBase = [UIColor lightGrayColor];
    ctimer.colorForText = [UIColor blackColor];
    ctimer.heightForLabel = 20;
    ctimer.strokeThickness = 3.0;
    [self.view addSubview:ctimer];

    [ctimer fireThisTimer];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
