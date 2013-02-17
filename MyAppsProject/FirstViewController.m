//
//  FirstViewController.m
//  MyAppsProject
//
//  Created by Uauker on 2/17/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchMoreApp:(id)sender {
    MyAppsViewController *apps = [[MyAppsViewController alloc] init];
    [[self navigationController] pushViewController:apps animated:YES];
}

@end
