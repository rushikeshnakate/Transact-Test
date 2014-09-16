//
//  TransactViewController.h
//  Transact
//
//  Created by Trsoft Developer on 12/09/14.
//  Copyright (c) 2014 TrSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransactUIViewControllerViewController.h"

typedef NS_ENUM(NSInteger, TransactViewControllerDirection) {
    TransactViewControllerDirectionLeft,
    TransactViewControllerDirectionRight,
    TransactViewControllerDirectionTop,
    TransactViewControllerDirectionBottom
};

typedef NS_ENUM(NSInteger, TransactViewControllerLiveBackgroundStyle) {
    TransactViewControllerLiveBackgroundStyleLight,
    TransactViewControllerLiveBackgroundStyleDark
};

@protocol TransactViewControllerDelegate;

@interface TransactViewController : UIViewController

@property (strong, readonly, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (assign, readwrite, nonatomic) BOOL panGestureEnabled;
@property (assign, readwrite, nonatomic) TransactViewControllerDirection direction;

@property (assign, readwrite, nonatomic) UIInterfaceOrientation currentOrientation;

/**
 * The backgroundFadeAmount is how much the backgound view fades when the menu
 * view is presented.
 *
 * 1.0 is completely black. 0.0 means the background does not dim at all.
 * The default value is 0.3.
 */
@property (assign, readwrite, nonatomic) CGFloat backgroundFadeAmount;
@property (strong, readwrite, nonatomic) UIColor *blurTintColor; // Used only when live blur is off
@property (assign, readwrite, nonatomic) CGFloat blurRadius; // Used only when live blur is off
@property (assign, readwrite, nonatomic) CGFloat blurSaturationDeltaFactor; // Used only when live blur is off
@property (assign, readwrite, nonatomic) NSTimeInterval animationDuration;
@property (assign, readwrite, nonatomic) BOOL limitMenuViewSize;
@property (assign, readwrite, nonatomic) CGSize menuViewSize;
@property (assign, readwrite, nonatomic) BOOL liveBlur; // iOS 7 only
@property (assign, readwrite, nonatomic) TransactViewControllerLiveBackgroundStyle liveBlurBackgroundStyle; // iOS 7 only

@property (weak, readwrite, nonatomic) id<TransactViewControllerDelegate> delegate;
@property (strong, readwrite, nonatomic) UIViewController *contentViewController;
@property (strong, readwrite, nonatomic) UIViewController *menuViewController;

- (id)initWithContentViewController:(UIViewController *)contentViewController menuViewController:(UIViewController *)menuViewController;
- (void)presentMenuViewController;
- (void)hideMenuViewController;
- (void)resizeMenuViewControllerToSize:(CGSize)size;
- (void)hideMenuViewControllerWithCompletionHandler:(void(^)(void))completionHandler;
- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer;

@end

@protocol TransactViewControllerDelegate <NSObject>

@optional
- (void)transactViewController:(TransactViewController *)transactViewController willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
- (void)transactViewController:(TransactViewController *)transactViewController didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer;
- (void)transactViewController:(TransactViewController *)transactViewController willShowMenuViewController:(UIViewController *)menuViewController;
- (void)transactViewController:(TransactViewController *)transactViewController didShowMenuViewController:(UIViewController *)menuViewController;
- (void)transactViewController:(TransactViewController *)transactViewController willHideMenuViewController:(UIViewController *)menuViewController;
- (void)transactViewController:(TransactViewController *)transactViewController didHideMenuViewController:(UIViewController *)menuViewController;

@end
