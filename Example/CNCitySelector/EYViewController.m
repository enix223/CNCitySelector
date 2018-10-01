//
//  EYViewController.m
//  CNCitySelector
//
//  Created by Enix Yu on 10/01/2018.
//  Copyright (c) 2018 Enix Yu. All rights reserved.
//

#import "EYViewController.h"

@interface EYViewController () <CNCitySelectDelegate>

@end

@implementation EYViewController

- (void)viewDidLoad
{
    self.datasource = [GB2260 shardInstance];
    self.delegate = self;
    
    [super viewDidLoad];
    
    self.title = @"选择城市";
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)didSelectRegion:(CNRegion *)region {
    NSLog(@"Select city: %@", region.name);
    
    NSString *title = [NSString stringWithFormat:@"选择城市: %@", region.name];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
    
    [self.datasource addRecentCity:region];
}

@end
