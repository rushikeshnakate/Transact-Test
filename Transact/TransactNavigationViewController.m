//
//  TransactNavigationViewController.m
//  Transact
//
//  Created by Trsoft Developer on 12/09/14.
//  Copyright (c) 2014 TrSoft. All rights reserved.
//

#import "TransactNavigationViewController.h"

@interface TransactNavigationViewController ()

@end

@implementation TransactNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
    
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.transactViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.transactViewController panGestureRecognized:sender];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
