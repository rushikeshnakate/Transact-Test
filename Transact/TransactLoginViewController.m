//
//  TransactLoginViewController.m
//  Transact
//
//  Created by Trsoft Developer on 02/09/14.
//  Copyright (c) 2014 TrSoft. All rights reserved.
//

#import "TransactLoginViewController.h"
#import "TransactNavigationViewController.h"
#import "TransactAgentHomeViewController.h"

@interface TransactLoginViewController ()

@end

@implementation TransactLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)btnLoginClicked:(id)sender {
    NSLog(@"clicked");
    
    if([[self.txtUserName text] isEqualToString:@""] || [[self.txtPassword text] isEqualToString:@""])
    {
        UILabel *emptyCredentials = [[UILabel alloc] initWithFrame:CGRectMake(82,250,250,20)];
        emptyCredentials.text = @"Please enter username and password.";
        emptyCredentials.textAlignment = NSTextAlignmentCenter;
        emptyCredentials.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        emptyCredentials.textColor = [UIColor redColor];
        [self.loginView addSubview:emptyCredentials];
    }
    else
    {
    
    NSURL *apiURL = [NSURL URLWithString:@"http://192.168.2.104/api/Users/GetCheckLoginStrings"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:apiURL];
    //NSString *postData = @"{\"loginId\": \"aruia\", \"password\": \"144618\"}";
    NSString *postData = [NSString stringWithFormat:@"{\"loginId\": '%@', \"password\": '%@'}", [self.txtUserName text], [self.txtPassword text]];
        
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accepts"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    //    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //    self.connection = connection;
    //    //[connection release];
    //    [connection start];
    
    //NSError *error = nil;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *er)
     {
         //         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
         //         NSLog(@"responsed");
         //         NSLog(@"%d", [dict count]);
         
         NSDictionary *userDetails = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
         
         //NSLog(@"cId > %d",[userDetails objectForKey:@"UserCompanyId"] );
         
         if([userDetails objectForKey:@"UserCompanyId"] != nil && [[userDetails objectForKey:@"UserCompanyId"] integerValue] != 0)
         {
             
         NSUserDefaults *UserProperties = [NSUserDefaults standardUserDefaults];
         [UserProperties setObject:[userDetails objectForKey:@"UserCompanyId"] forKey:@"UserCompanyId"];
         [UserProperties setObject:[userDetails objectForKey:@"UserEmail"] forKey:@"UserEmail"];
         [UserProperties setObject:[userDetails objectForKey:@"UserFName"] forKey:@"UserFName"];
         [UserProperties setObject:[userDetails objectForKey:@"UserLName"] forKey:@"UserLName"];
         [UserProperties setObject:[userDetails objectForKey:@"UserId"] forKey:@"UserId"];
         [UserProperties setObject:[userDetails objectForKey:@"UserRole"] forKey:@"UserRole"];
         
        
             TransactNavigationViewController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
             NSLog(@"isLoggedin");
             int userRole = [UserProperties integerForKey:@"UserRole"];
             if(userRole == 2)
             {
                 TransactBrokerHomeViewController *HomePage = [self.storyboard instantiateViewControllerWithIdentifier:@"brokerHomeController"];
                 
                 navigationController.viewControllers =@[HomePage];
                 self.transactViewController.contentViewController = navigationController;
                 //[self presentViewController:HomePage animated:YES completion:nil];
             }
             else if(userRole == 5)
             {
                 TransactAgentHomeViewController *HomePage = [self.storyboard instantiateViewControllerWithIdentifier:@"agentHomeController"];
                 
                 navigationController.viewControllers =@[HomePage];
                 self.transactViewController.contentViewController = navigationController;
                 //[self presentViewController:HomePage animated:YES completion:nil];
             }
         }
         else
         {
             UILabel *invalid = [[UILabel alloc] initWithFrame:CGRectMake(82,250,220,20)];
             invalid.text = @"Invalid username or password.";
             invalid.textAlignment = NSTextAlignmentCenter;
             invalid.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
             invalid.textColor = [UIColor redColor];
             [self.loginView addSubview:invalid];
         }
     }
     ];
    }

 
}

//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
//    NSLog(@"data");
//    NSLog(@"%d", [dict count]);
//}
//
//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
//
//    NSLog(@"%@" , error);
//}
//
//-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
//    NSLog(@"finished");
//}
@end
