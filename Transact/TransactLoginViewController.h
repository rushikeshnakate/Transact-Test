//
//  TransactLoginViewController.h
//  Transact
//
//  Created by Trsoft Developer on 02/09/14.
//  Copyright (c) 2014 TrSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransactBrokerHomeViewController.h"
#import "TransactViewController.h"

@interface TransactLoginViewController : UIViewController

@property (assign, readwrite, nonatomic) NSUserDefaults* UserProperties;

@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIView *loginView;

- (IBAction)btnLoginClicked:(id)sender;

@end
