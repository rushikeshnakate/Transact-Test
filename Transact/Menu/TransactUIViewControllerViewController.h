//
//  TransactUIViewControllerViewController.h
//  Transact
//
//  Created by Trsoft Developer on 12/09/14.
//  Copyright (c) 2014 TrSoft. All rights reserved.
//


@class TransactViewController;

@interface UIViewController (TransactViewController)

@property (strong, readonly, nonatomic) TransactViewController *transactViewController;

- (void)re_displayController:(UIViewController *)controller frame:(CGRect)frame;
- (void)re_hideController:(UIViewController *)controller;

@end

