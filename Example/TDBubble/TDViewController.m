//
//  TDViewController.m
//  TDBubble
//
//  Created by Tun on 05/22/2017.
//  Copyright (c) 2017 Tun. All rights reserved.
//

#import "TDViewController.h"

@interface TDViewController ()

@end

@implementation TDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [NSTimer scheduledTimerWithTimeInterval:.1
                                     target:self
                                   selector:@selector(createBubble)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)createBubble {
    
    NSArray *arr = @[[UIColor redColor],[UIColor blueColor],[UIColor greenColor],[UIColor yellowColor],[UIColor grayColor]];
    NSUInteger randomIndex = arc4random() % [arr count];
    UIColor *color = arr[randomIndex];
    [self.bubble createBubbleWithColor:color];
    
}

@end
