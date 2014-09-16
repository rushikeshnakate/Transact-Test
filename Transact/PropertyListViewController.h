//
//  PropertyListViewController.h
//  Transact
//
//  Created by trsoft_dev1 on 16/09/14.
//  Copyright (c) 2014 TrSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PropertyListViewController : UITableViewController
{
    NSInteger _currentPage;
    __strong NSMutableArray *PropertyImage;
    __strong NSMutableArray *PropertyAddress;
    __strong NSMutableArray *PropertyType;
}

@property (nonatomic, weak) IBOutlet UITableView *TableView;


@end



