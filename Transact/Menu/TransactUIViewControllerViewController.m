//
//  TransactUIViewControllerViewController.m
//  Transact
//
//  Created by Trsoft Developer on 12/09/14.
//  Copyright (c) 2014 TrSoft. All rights reserved.
//

#import "TransactUIViewControllerViewController.h"
#import "TransactViewController.h"

@implementation UIViewController (TransactViewController)

- (void)re_displayController:(UIViewController *)controller frame:(CGRect)frame
{
    [self addChildViewController:controller];
    controller.view.frame = frame;
    [self.view addSubview:controller.view];
    [controller didMoveToParentViewController:self];
}

- (void)re_hideController:(UIViewController *)controller
{
    [controller willMoveToParentViewController:nil];
    [controller.view removeFromSuperview];
    [controller removeFromParentViewController];
}

- (TransactViewController *)transactViewController
{
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[TransactViewController class]]) {
            return (TransactViewController *)iter;
        } else if (iter.parentViewController && iter.parentViewController != iter) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;
}

@end
