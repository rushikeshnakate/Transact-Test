//
//  TransactMenuViewController.m
//  Transact
//
//  Created by Trsoft Developer on 12/09/14.
//  Copyright (c) 2014 TrSoft. All rights reserved.
//

#import "TransactMenuViewController.h"
#import "TransactBrokerHomeViewController.h"
#import "TransactAgentHomeViewController.h"
#import "TransactUIViewControllerViewController.h"
#import "TransactNavigationViewController.h"
#import "TransactLoginViewController.h"

@interface TransactMenuViewController ()

@end

@implementation TransactMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TransactNavigationViewController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
        if (indexPath.section == 0 && indexPath.row == 0) {
            TransactBrokerHomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"brokerHomeController"];
            navigationController.viewControllers = @[homeViewController];
        }
        else if(indexPath.section == 0 && indexPath.row == 1)
        {
            TransactAgentHomeViewController *thirdViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"agentHomeController"];
            navigationController.viewControllers = @[thirdViewController];
        }
        else if(indexPath.section == 0 && indexPath.row == 3)
        {
            NSUserDefaults *userProperties = [NSUserDefaults standardUserDefaults];
            if([userProperties integerForKey:@"UserCompanyId"] != 0 && [userProperties objectForKey:@"UserCompanyId"] != nil)
            {
                //
            }
            
            if(![[userProperties stringForKey: @"UserEmail"] isEqualToString:@""] && [userProperties objectForKey:@"UserEmail"] != nil)
            {
                //
            }
            
            if(![[userProperties stringForKey:@"UserFName"] isEqualToString:@""] && [userProperties objectForKey:@"UserFName"] != nil)
            {
                //
            }
            
            if(![[userProperties stringForKey:@"UserLName"] isEqualToString:@""] && [userProperties objectForKey:@"UserLName"] != nil)
            {
                //
            }
            
            if(![[userProperties stringForKey:@"UserId"] isEqualToString:@""] && [userProperties objectForKey:@"UserId"] != nil)
            {
                //
            }
            
            if([userProperties integerForKey:@"UserRole"] != 0 && [userProperties objectForKey:@"UserRole"] != nil)
            {
                //
            }

            TransactLoginViewController *thirdViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginController"];
            navigationController.viewControllers = @[thirdViewController];
        }
        
    //    else {
    //        DEMOSecondViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"secondController"];
    //        navigationController.viewControllers = @[secondViewController];
    //    }
    
    self.transactViewController.contentViewController = navigationController;
    [self.transactViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSArray *titles = @[@"Home", @"Search Transactions", @"My Account", @"Logout"];
    NSArray *icons = @[@"Home_Icon.png", @"SearchTrans_icon.png", @"MyAccount_Icon.png", @"Logout_Icon.png"];
    
    UILabel *menuName = [[UILabel alloc] initWithFrame:CGRectMake(0,105,100,20)];
    menuName.text = titles[indexPath.row];
    menuName.textAlignment = NSTextAlignmentCenter;
    menuName.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    
    UIImage *icon = [UIImage imageNamed:icons[indexPath.row]];
    UIImageView *singleMenu = [[UIImageView alloc] initWithFrame:CGRectMake(34, 10, 100, 100)];
    [singleMenu addSubview:menuName];
    singleMenu.image = icon;
    
    [cell.contentView addSubview:singleMenu];
    
    return cell;
}

@end

