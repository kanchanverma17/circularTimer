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
    circleTimer *ctimer;
}

- (void)viewDidLoad {
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    ctimer = [[circleTimer alloc]initWithFrame:self.timerFrameVW.frame];
    ctimer.maxTime = 20;
    ctimer.colorForStroke = [UIColor systemTealColor];
    ctimer.colorForBase = [UIColor lightTextColor];
    ctimer.colorForText = [UIColor blackColor];
    ctimer.heightForLabel = 20;
    ctimer.strokeThickness = 3.0;
    ctimer.tag = 101;
    [self.view addSubview:ctimer];
    

    [ctimer fireThisTimer];
}

- (IBAction)restart:(id)sender {
    ctimer.maxTime = 20;
    [ctimer restartThisTimer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
