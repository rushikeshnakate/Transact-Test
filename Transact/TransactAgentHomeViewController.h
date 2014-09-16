//
//  TransactAgentHomeViewController.h
//  Transact
//
//  Created by Trsoft Developer on 13/09/14.
//  Copyright (c) 2014 TrSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransactViewController.h"

@interface TransactAgentHomeViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>{
    NSInteger _currentPage;
    __strong NSMutableArray *arrayofImages;
    __strong NSMutableArray *arrayofLabels;
    NSString *url;
}

@property (nonatomic, weak) IBOutlet UICollectionView *CollectionView;

- (IBAction)showMenu:(id)sender;

@end
