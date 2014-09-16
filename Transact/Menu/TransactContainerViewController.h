//
//  TransactContainerViewController.h
//  Transact
//
//  Created by Trsoft Developer on 12/09/14.
//  Copyright (c) 2014 TrSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TransactViewController;

@interface TransactContainerViewController : UIViewController

@property (strong, readwrite, nonatomic) UIImage *screenshotImage;
@property (weak, readwrite, nonatomic) TransactViewController *transactViewController;
@property (assign, readwrite, nonatomic) BOOL animateApperance;
@property (strong, readonly, nonatomic) UIView *containerView;

- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer;
- (void)hide;
- (void)resizeToSize:(CGSize)size;
- (void)hideWithCompletionHandler:(void(^)(void))completionHandler;
- (void)refreshBackgroundImage;

@end

