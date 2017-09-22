# circularTimer

This project is a demo of circular countdown timer based on beizer path showing remainder time in mm:ss format.

To implement this kind of timer in your project include circleTimer.h and circleTimer.m class in your project.
The superview of this class is UIVIew.
So in order to implementthis class , create its instance :-

     circleTimer *ctimer = [[circleTimer alloc]initWithFrame:self.timerFrameVW.frame];

feed it with the frame of target UIView which is supposed to contain this timer.
Later feed it with more properties you want to customise with :-

     ctimer.maxTime = 120;
     ctimer.colorForStroke = [UIColor greenColor];
     ctimer.colorForBase = [UIColor lightGrayColor];
     ctimer.colorForText = [UIColor blackColor];
     ctimer.heightForLabel = 20;
     ctimer.strokeThickness = 3.0;
     [self.view addSubview:ctimer];
    
 and then finally call [ctimer fireThisTimer]; whenever you want to start the countdown.
