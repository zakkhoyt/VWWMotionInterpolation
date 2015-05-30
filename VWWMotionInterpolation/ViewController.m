//
//  ViewController.m
//  VWWMotionInterpolation
//
//  Created by Zakk Hoyt on 5/29/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "ViewController.h"
@import CoreMotion;

@interface ViewController ()
@property (nonatomic, strong) CMMotionManager *motion;

@property (nonatomic, strong) UIView *bubble;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bubble = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.bubble.backgroundColor = [UIColor blueColor];
    self.bubble.layer.cornerRadius = 10;
    self.bubble.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bubble.layer.shadowOpacity = 0.8;

    self.bubble.center = self.view.center;
    [self.view addSubview:self.bubble];

    
    
    
    CGFloat halfWidth = (self.view.bounds.size.width) / 2.0;
    UIInterpolatingMotionEffect *xEffect = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    xEffect.minimumRelativeValue = @(-halfWidth);
    xEffect.maximumRelativeValue = @(halfWidth);
    [self.bubble addMotionEffect:xEffect];
    
    
    CGFloat halfHeight = (self.view.bounds.size.height) / 2.0;
    UIInterpolatingMotionEffect *yEffect = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    yEffect.minimumRelativeValue = @(-halfHeight);
    yEffect.maximumRelativeValue = @(halfHeight);
    [self.bubble addMotionEffect:yEffect];

    
    UIInterpolatingMotionEffect *shadowEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"layer.shadowOffset" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    shadowEffect.minimumRelativeValue = [NSValue valueWithCGSize:CGSizeMake(-100, 50)];
    shadowEffect.maximumRelativeValue = [NSValue valueWithCGSize:CGSizeMake(100, 50)];
    [self.bubble addMotionEffect:shadowEffect];

}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    CGRect targetRectangle = CGRectMake(point.x, point.y, 10, 10);
    [[UIMenuController sharedMenuController] setTargetRect:targetRectangle inView:self.view];
    
    UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"Custom Action" action:@selector(customAction:)];
    
    [[UIMenuController sharedMenuController] setMenuItems:@[menuItem]];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}

- (void)copy:(id)sender {
    NSLog(@"Copy");
}

-(void)customAction:(id)sender{
    
}

@end
