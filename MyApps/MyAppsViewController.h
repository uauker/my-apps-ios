//
//  MyAppsViewController.h
//  transitorio
//
//  Created by Uauker on 2/3/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"
#import <QuartzCore/QuartzCore.h>

@interface MyAppsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *apps;

@end
