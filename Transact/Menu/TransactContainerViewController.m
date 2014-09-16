//
//  TransactContainerViewController.m
//  Transact
//
//  Created by Trsoft Developer on 12/09/14.
//  Copyright (c) 2014 TrSoft. All rights reserved.
//

#import "TransactContainerViewController.h"
#import "TransactUIImageViewController.h"
#import "TransactUIViewViewController.h"
#import "TransactUIViewControllerViewController.h"
#import "TransactViewController.h"
#import "TransactCommonFunctions.h"

@interface TransactContainerViewController ()

@property (strong, readwrite, nonatomic) UIImageView *backgroundImageView;
@property (strong, readwrite, nonatomic) NSMutableArray *backgroundViews;
@property (strong, readwrite, nonatomic) UIView *containerView;
@property (assign, readwrite, nonatomic) CGPoint containerOrigin;

@end

@interface TransactViewController ()

@property (assign, readwrite, nonatomic) BOOL visible;
@property (assign, readwrite, nonatomic) CGSize calculatedMenuViewSize;

@end

@implementation TransactContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backgroundViews = [NSMutableArray array];
    for (NSInteger i = 0; i < 4; i++) {
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectNull];
        backgroundView.backgroundColor = [UIColor blackColor];
        backgroundView.alpha = 0.0f;
        [self.view addSubview:backgroundView];
        [self.backgroundViews addObject:backgroundView];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
        [backgroundView addGestureRecognizer:tapRecognizer];
    }
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, self.view.frame.size.height)];
    self.containerView.clipsToBounds = YES;
    [self.view addSubview:self.containerView];
    
    if (self.transactViewController.liveBlur) {
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:self.view.bounds];
        toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        toolbar.barStyle = (UIBarStyle)self.transactViewController.liveBlurBackgroundStyle;
        [self.containerView addSubview:toolbar];
    } else {
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        [self.containerView addSubview:self.backgroundImageView];
    }
    
    if (self.transactViewController.menuViewController) {
        [self addChildViewController:self.transactViewController.menuViewController];
        self.transactViewController.menuViewController.view.frame = self.containerView.bounds;
        [self.containerView addSubview:self.transactViewController.menuViewController.view];
        [self.transactViewController.menuViewController didMoveToParentViewController:self];
    }
    
    [self.view addGestureRecognizer:self.transactViewController.panGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    if(!self.transactViewController.visible) {
        self.backgroundImageView.image = self.screenshotImage;
        self.backgroundImageView.frame = self.view.bounds;
        self.transactViewController.menuViewController.view.frame = self.containerView.bounds;
        
        if (self.transactViewController.direction == TransactViewControllerDirectionLeft) {
            [self setContainerFrame:CGRectMake(- self.transactViewController.calculatedMenuViewSize.width, 0, self.transactViewController.calculatedMenuViewSize.width, self.transactViewController.calculatedMenuViewSize.height)];
        }
        
        if (self.transactViewController.direction == TransactViewControllerDirectionRight) {
            [self setContainerFrame:CGRectMake(self.view.frame.size.width, 0, self.transactViewController.calculatedMenuViewSize.width, self.transactViewController.calculatedMenuViewSize.height)];
        }
        
        if (self.transactViewController.direction == TransactViewControllerDirectionTop) {
            [self setContainerFrame:CGRectMake(0, -self.transactViewController.calculatedMenuViewSize.height, self.transactViewController.calculatedMenuViewSize.width, self.transactViewController.calculatedMenuViewSize.height)];
        }
        
        if (self.transactViewController.direction == TransactViewControllerDirectionBottom) {
            [self setContainerFrame:CGRectMake(0, self.view.frame.size.height, self.transactViewController.calculatedMenuViewSize.width, self.transactViewController.calculatedMenuViewSize.height)];
        }
        
        if (self.animateApperance)
            [self show];
    }
}

- (void)setContainerFrame:(CGRect)frame
{
    UIView *leftBackgroundView = self.backgroundViews[0];
    UIView *topBackgroundView = self.backgroundViews[1];
    UIView *bottomBackgroundView = self.backgroundViews[2];
    UIView *rightBackgroundView = self.backgroundViews[3];
    
    leftBackgroundView.frame = CGRectMake(0, 0, frame.origin.x, self.view.frame.size.height);
    rightBackgroundView.frame = CGRectMake(frame.size.width + frame.origin.x, 0, self.view.frame.size.width - frame.size.width - frame.origin.x, self.view.frame.size.height);
    
    topBackgroundView.frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.origin.y);
    bottomBackgroundView.frame = CGRectMake(frame.origin.x, frame.size.height + frame.origin.y, frame.size.width, self.view.frame.size.height);
    
    self.containerView.frame = frame;
    self.backgroundImageView.frame = CGRectMake(- frame.origin.x, - frame.origin.y, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)setBackgroundViewsAlpha:(CGFloat)alpha
{
    for (UIView *view in self.backgroundViews) {
        view.alpha = alpha;
    }
}

- (void)resizeToSize:(CGSize)size
{
    
    if (self.transactViewController.direction == TransactViewControllerDirectionLeft) {
        [UIView animateWithDuration:self.transactViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(0, 0, size.width, size.height)];
            [self setBackgroundViewsAlpha:self.transactViewController.backgroundFadeAmount];
        } completion:nil];
    }
    
    if (self.transactViewController.direction == TransactViewControllerDirectionRight) {
        [UIView animateWithDuration:self.transactViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(self.view.frame.size.width - size.width, 0, size.width, size.height)];
            [self setBackgroundViewsAlpha:self.transactViewController.backgroundFadeAmount];
        } completion:nil];
    }
    
    if (self.transactViewController.direction == TransactViewControllerDirectionTop) {
        [UIView animateWithDuration:self.transactViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(0, 0, size.width, size.height)];
            [self setBackgroundViewsAlpha:self.transactViewController.backgroundFadeAmount];
        } completion:nil];
    }
    
    if (self.transactViewController.direction == TransactViewControllerDirectionBottom) {
        [UIView animateWithDuration:self.transactViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(0, self.view.frame.size.height - size.height, size.width, size.height)];
            [self setBackgroundViewsAlpha:self.transactViewController.backgroundFadeAmount];
        } completion:nil];
    }
}

- (void)show
{
    void (^completionHandler)(BOOL finished) = ^(BOOL finished) {
        if ([self.transactViewController.delegate conformsToProtocol:@protocol(TransactViewControllerDelegate)] && [self.transactViewController.delegate respondsToSelector:@selector(transactViewController:didShowMenuViewController:)]) {
            [self.transactViewController.delegate transactViewController:self.transactViewController didShowMenuViewController:self.transactViewController.menuViewController];
        }
    };
    
    if (self.transactViewController.direction == TransactViewControllerDirectionLeft) {
        [UIView animateWithDuration:self.transactViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(0, 0, self.transactViewController.calculatedMenuViewSize.width, self.transactViewController.calculatedMenuViewSize.height)];
            [self setBackgroundViewsAlpha:self.transactViewController.backgroundFadeAmount];
        } completion:completionHandler];
    }
    
    if (self.transactViewController.direction == TransactViewControllerDirectionRight) {
        [UIView animateWithDuration:self.transactViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(self.view.frame.size.width - self.transactViewController.calculatedMenuViewSize.width, 0, self.transactViewController.calculatedMenuViewSize.width, self.transactViewController.calculatedMenuViewSize.height)];
            [self setBackgroundViewsAlpha:self.transactViewController.backgroundFadeAmount];
        } completion:completionHandler];
    }
    
    if (self.transactViewController.direction == TransactViewControllerDirectionTop) {
        [UIView animateWithDuration:self.transactViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(0, 0, self.transactViewController.calculatedMenuViewSize.width, self.transactViewController.calculatedMenuViewSize.height)];
            [self setBackgroundViewsAlpha:self.transactViewController.backgroundFadeAmount];
        } completion:completionHandler];
    }
    
    if (self.transactViewController.direction == TransactViewControllerDirectionBottom) {
        [UIView animateWithDuration:self.transactViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(0, self.view.frame.size.height - self.transactViewController.calculatedMenuViewSize.height, self.transactViewController.calculatedMenuViewSize.width, self.transactViewController.calculatedMenuViewSize.height)];
            [self setBackgroundViewsAlpha:self.transactViewController.backgroundFadeAmount];
        } completion:completionHandler];
    }
}


- (void)hide
{
	[self hideWithCompletionHandler:nil];
}

- (void)hideWithCompletionHandler:(void(^)(void))completionHandler
{
    void (^completionHandlerBlock)(void) = ^{
        if ([self.transactViewController.delegate conformsToProtocol:@protocol(TransactViewControllerDelegate)] && [self.transactViewController.delegate respondsToSelector:@selector(transactViewController:didHideMenuViewController:)]) {
            [self.transactViewController.delegate transactViewController:self.transactViewController didHideMenuViewController:self.transactViewController.menuViewController];
        }
        if (completionHandler)
            completionHandler();
    };
    
    if ([self.transactViewController.delegate conformsToProtocol:@protocol(TransactViewControllerDelegate)] && [self.transactViewController.delegate respondsToSelector:@selector(transactViewController:willHideMenuViewController:)]) {
        [self.transactViewController.delegate transactViewController:self.transactViewController willHideMenuViewController:self.transactViewController.menuViewController];
    }
    
    if (self.transactViewController.direction == TransactViewControllerDirectionLeft) {
        [UIView animateWithDuration:self.transactViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(- self.transactViewController.calculatedMenuViewSize.width, 0, self.transactViewController.calculatedMenuViewSize.width, self.transactViewController.calculatedMenuViewSize.height)];
            [self setBackgroundViewsAlpha:0];
        } completion:^(BOOL finished) {
            self.transactViewController.visible = NO;
            [self.transactViewController re_hideController:self];
            completionHandlerBlock();
        }];
    }
    
    if (self.transactViewController.direction == TransactViewControllerDirectionRight) {
        [UIView animateWithDuration:self.transactViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(self.view.frame.size.width, 0, self.transactViewController.calculatedMenuViewSize.width, self.transactViewController.calculatedMenuViewSize.height)];
            [self setBackgroundViewsAlpha:0];
        } completion:^(BOOL finished) {
            self.transactViewController.visible = NO;
            [self.transactViewController re_hideController:self];
            completionHandlerBlock();
        }];
    }
    
    if (self.transactViewController.direction == TransactViewControllerDirectionTop) {
        [UIView animateWithDuration:self.transactViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(0, -self.transactViewController.calculatedMenuViewSize.height, self.transactViewController.calculatedMenuViewSize.width, self.transactViewController.calculatedMenuViewSize.height)];
            [self setBackgroundViewsAlpha:0];
        } completion:^(BOOL finished) {
            self.transactViewController.visible = NO;
            [self.transactViewController re_hideController:self];
            completionHandlerBlock();
        }];
    }
    
    if (self.transactViewController.direction == TransactViewControllerDirectionBottom) {
        [UIView animateWithDuration:self.transactViewController.animationDuration animations:^{
            [self setContainerFrame:CGRectMake(0, self.view.frame.size.height, self.transactViewController.calculatedMenuViewSize.width, self.transactViewController.calculatedMenuViewSize.height)];
            [self setBackgroundViewsAlpha:0];
        } completion:^(BOOL finished) {
            self.transactViewController.visible = NO;
            [self.transactViewController re_hideController:self];
            completionHandlerBlock();
        }];
    }
}

- (void)refreshBackgroundImage
{
    self.backgroundImageView.image = self.screenshotImage;
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)tapGestureRecognized:(UITapGestureRecognizer *)recognizer
{
    [self hide];
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer
{
    if ([self.transactViewController.delegate conformsToProtocol:@protocol(TransactViewControllerDelegate)] && [self.transactViewController.delegate respondsToSelector:@selector(transactViewController:didRecognizePanGesture:)])
        [self.transactViewController.delegate transactViewController:self.transactViewController didRecognizePanGesture:recognizer];
    
    if (!self.transactViewController.panGestureEnabled)
        return;
    
    CGPoint point = [recognizer translationInView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.containerOrigin = self.containerView.frame.origin;
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGRect frame = self.containerView.frame;
        if (self.transactViewController.direction == TransactViewControllerDirectionLeft) {
            frame.origin.x = self.containerOrigin.x + point.x;
            if (frame.origin.x > 0) {
                frame.origin.x = 0;
                
                if (!self.transactViewController.limitMenuViewSize) {
                    frame.size.width = self.transactViewController.calculatedMenuViewSize.width + self.containerOrigin.x + point.x;
                    if (frame.size.width > self.view.frame.size.width)
                        frame.size.width = self.view.frame.size.width;
                }
            }
        }
        
        if (self.transactViewController.direction == TransactViewControllerDirectionRight) {
            frame.origin.x = self.containerOrigin.x + point.x;
            if (frame.origin.x < self.view.frame.size.width - self.transactViewController.calculatedMenuViewSize.width) {
                frame.origin.x = self.view.frame.size.width - self.transactViewController.calculatedMenuViewSize.width;
                
                if (!self.transactViewController.limitMenuViewSize) {
                    frame.origin.x = self.containerOrigin.x + point.x;
                    if (frame.origin.x < 0)
                        frame.origin.x = 0;
                    frame.size.width = self.view.frame.size.width - frame.origin.x;
                }
            }
        }
        
        if (self.transactViewController.direction == TransactViewControllerDirectionTop) {
            frame.origin.y = self.containerOrigin.y + point.y;
            if (frame.origin.y > 0) {
                frame.origin.y = 0;
                
                if (!self.transactViewController.limitMenuViewSize) {
                    frame.size.height = self.transactViewController.calculatedMenuViewSize.height + self.containerOrigin.y + point.y;
                    if (frame.size.height > self.view.frame.size.height)
                        frame.size.height = self.view.frame.size.height;
                }
            }
        }
        
        if (self.transactViewController.direction == TransactViewControllerDirectionBottom) {
            frame.origin.y = self.containerOrigin.y + point.y;
            if (frame.origin.y < self.view.frame.size.height - self.transactViewController.calculatedMenuViewSize.height) {
                frame.origin.y = self.view.frame.size.height - self.transactViewController.calculatedMenuViewSize.height;
                
                if (!self.transactViewController.limitMenuViewSize) {
                    frame.origin.y = self.containerOrigin.y + point.y;
                    if (frame.origin.y < 0)
                        frame.origin.y = 0;
                    frame.size.height = self.view.frame.size.height - frame.origin.y;
                }
            }
        }
        
        [self setContainerFrame:frame];
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (self.transactViewController.direction == TransactViewControllerDirectionLeft) {
            if ([recognizer velocityInView:self.view].x < 0) {
                [self hide];
            } else {
                [self show];
            }
        }
        
        if (self.transactViewController.direction == TransactViewControllerDirectionRight) {
            if ([recognizer velocityInView:self.view].x < 0) {
                [self show];
            } else {
                [self hide];
            }
        }
        
        if (self.transactViewController.direction == TransactViewControllerDirectionTop) {
            if ([recognizer velocityInView:self.view].y < 0) {
                [self hide];
            } else {
                [self show];
            }
        }
        
        if (self.transactViewController.direction == TransactViewControllerDirectionBottom) {
            if ([recognizer velocityInView:self.view].y < 0) {
                [self show];
            } else {
                [self hide];
            }
        }
    }
}

- (void)fixLayoutWithDuration:(NSTimeInterval)duration
{
    if (self.transactViewController.direction == TransactViewControllerDirectionLeft) {
        [self setContainerFrame:CGRectMake(0, 0, self.transactViewController.calculatedMenuViewSize.width, self.transactViewController.calculatedMenuViewSize.height)];
        [self setBackgroundViewsAlpha:self.transactViewController.backgroundFadeAmount];
    }
    
    if (self.transactViewController.direction == TransactViewControllerDirectionRight) {
        [self setContainerFrame:CGRectMake(self.view.frame.size.width - self.transactViewController.calculatedMenuViewSize.width, 0, self.transactViewController.calculatedMenuViewSize.width, self.transactViewController.calculatedMenuViewSize.height)];
        [self setBackgroundViewsAlpha:self.transactViewController.backgroundFadeAmount];
    }
    
    if (self.transactViewController.direction == TransactViewControllerDirectionTop) {
        [self setContainerFrame:CGRectMake(0, 0, self.transactViewController.calculatedMenuViewSize.width, self.transactViewController.calculatedMenuViewSize.height)];
        [self setBackgroundViewsAlpha:self.transactViewController.backgroundFadeAmount];
    }
    
    if (self.transactViewController.direction == TransactViewControllerDirectionBottom) {
        [self setContainerFrame:CGRectMake(0, self.view.frame.size.height - self.transactViewController.calculatedMenuViewSize.height, self.transactViewController.calculatedMenuViewSize.width, self.transactViewController.calculatedMenuViewSize.height)];
        [self setBackgroundViewsAlpha:self.transactViewController.backgroundFadeAmount];
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self fixLayoutWithDuration:duration];
}

@end
