//
//  MyAppsViewController.m
//  transitorio
//
//  Created by Uauker on 2/3/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import "MyAppsViewController.h"

@interface MyAppsViewController ()

@end

@implementation MyAppsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationItem setTitle:NSLocalizedString(@"Outros Aplicativos", nil)];

    NSError *error = nil;
    NSString *l = [[NSBundle mainBundle] pathForResource:@"MyApps" ofType:@"json"];
    NSString *jsonString = [NSString stringWithContentsOfFile:l encoding:NSUTF8StringEncoding error:&error];
    
    self.apps = [[NSMutableArray alloc] init];
    
    for (NSDictionary *app in [[jsonString objectFromJSONString] objectForKey:@"apps"]) {
        if (![[[NSBundle mainBundle] bundleIdentifier] isEqualToString:[app objectForKey:@"bundle"]]) {
            [self.apps addObject:app];            
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.apps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MyAppCell";
    
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
    	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
    	cell = (UITableViewCell *)[nib objectAtIndex:0];
        
//        UINib* customCellNib = [UINib nibWithNibName:cellIdentifier bundle:nil];
//        [tableView registerNib:customCellNib forCellReuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *app = [self.apps objectAtIndex:[indexPath row]];
    
    UIImageView *imageView = (UIImageView *) [cell viewWithTag:5];
    UILabel *nameApp = (UILabel *) [cell viewWithTag:2];
    UILabel *category = (UILabel *) [cell viewWithTag:3];
    
    imageView.image = [UIImage imageNamed:[app objectForKey:@"bundle"]];
    imageView.layer.cornerRadius = 10.0;
    imageView.layer.masksToBounds = YES;
    
    nameApp.text = [app objectForKey:@"name"];
    
    category.text = [app objectForKey:@"category"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = ([indexPath row] % 2 == 0) ? [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0f] : [UIColor colorWithRed:235.0f/255.0f green:235.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
    
    NSString *url = [[self.apps objectAtIndex:[indexPath row]] objectForKey:@"url"];
    
    NSString *scheme = [[self.apps objectAtIndex:[indexPath row]] objectForKey:@"bundle"];
    scheme = [[scheme componentsSeparatedByString:@"."] lastObject];
    scheme = [NSString stringWithFormat:@"%@://", scheme];
    
    NSString *urlToOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:scheme]] ? scheme : url;
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlToOpen]];
}

@end
