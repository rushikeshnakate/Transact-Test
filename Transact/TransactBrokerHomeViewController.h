//
//  TransactBrokerHomeViewController.h
//  Transact
//
//  Created by Trsoft Developer on 02/09/14.
//  Copyright (c) 2014 TrSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransactViewController.h"

@interface TransactBrokerHomeViewController : UIViewController
{
    IBOutlet UIScrollView *Scroller;
    

}





@property(strong,nonatomic)NSString *StringMonth;
@property(strong,nonatomic)NSString *StringGraphtype;


@property(weak,nonatomic) IBOutlet UIView *TransactListingGraph;
@property(weak,nonatomic)IBOutlet UILabel *ListingVolumeLabel;
- (IBAction)showMenu:(id)sender;

@end
