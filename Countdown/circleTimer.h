//
//  circleTimer.h
//  Countdown
//
//  Created by MAC on 22/09/17.
//  Copyright © 2017 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface circleTimer : UIView


@property int maxTime;
@property (strong,nonatomic) UIColor *colorForBase;
@property (strong,nonatomic) UIColor *colorForStroke;
@property (strong,nonatomic) UIColor *colorForText;
@property  CGFloat heightForLabel;
@property  CGFloat strokeThickness;
-(void)fireThisTimer;
-(void)restartThisTimer;
@end
