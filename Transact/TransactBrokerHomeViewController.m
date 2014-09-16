//
//  TransactBrokerHomeViewController.m
//  Transact
//
//  Created by Trsoft Developer on 02/09/14.
//  Copyright (c) 2014 TrSoft. All rights reserved.
//

#import "TransactBrokerHomeViewController.h"
#import "TransactListingGraph.h"
#import "PropertyListViewController.h"

@interface TransactBrokerHomeViewController ()
{
    NSString *url;
}

@end

@implementation TransactBrokerHomeViewController

@synthesize TransactListingGraph;
@synthesize StringMonth;
@synthesize StringGraphtype;

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
    [Scroller setScrollEnabled: YES];
    [Scroller setContentSize:CGSizeMake(768, 2000)];
    
    //    GraphOne = [[[GraphOne alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, nextY)] autorelease];
    //The setup code (in viewDidLoad in your view controller)
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.TransactListingGraph addGestureRecognizer:singleFingerTap];
    
    
    url = @"http://192.168.1.104/api/GraphReport/GetListingGraph/?companyid=";
    NSString *CompanyID = @"64";
    url = [url stringByAppendingString:CompanyID];
    url = [url stringByAppendingString:@"&roleid=2"];
    
    [self fetchInintialData];
    
    
    
    
    
}

- (IBAction)showMenu:(id)sender {
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.transactViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.transactViewController presentMenuViewController];
}


-(NSNumber*)GettingMaximumValuetransaction:(NSArray*)array
{
    
    
    NSNumber *max=[array valueForKeyPath:@"@max.doubleValue"];
    NSLog(@"Highest number: %@",max);
    barHeight = max;
    return barHeight;
    NSLog(@"Highest number: %@",max);
}

- (void)fetchInintialData
{
    NSURL *yourUrl = [NSURL URLWithString:url];
    NSError *error = nil;
    
    NSURLResponse *response;
    NSData *localData = nil;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:yourUrl];
    
    [request setHTTPMethod:@"GET"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    localData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    
    NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:localData
                                                             options:kNilOptions
                                                               error:NULL];
    NSLog(@"%@",greeting);
    keyCountofReturnedData = [greeting count];
    NSLog(@"%i", keyCountofReturnedData);
    stringArray = [[NSMutableArray alloc]initWithCapacity:keyCountofReturnedData+1];
    data = [[NSMutableArray alloc]initWithCapacity:keyCountofReturnedData];
    for (int i = 0; i<keyCountofReturnedData; i++)
    {
        
        [stringArray addObject:[greeting valueForKeyPath:@"Month"][i]];
        NSLog(@"%@ and the index position is %d",stringArray[i],i);
        [data addObject:[greeting valueForKeyPath:@"TotalPrice"][i]];
        NSLog(@"%@ and the index position is %d",data[i],i);
    }
    
    
    
    barHeight =  [self GettingMaximumValuetransaction:data];
    
    
    
}


//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    float touchedX = location.x;
    float touchedY = location.y;
    
    
    
    for (int i=0; i<(keyCountofReturnedData-1); i++) {
        NSNumber *barStartXObj = [startXArray objectAtIndex:i];
        float barStartX = [barStartXObj floatValue];
        
        NSNumber *barHeightObj = [barHeightArray objectAtIndex:i];
        float barHeight = [barHeightObj floatValue];
        NSNumber *barYObj = [startYArray objectAtIndex:i];
        float barY = [barYObj floatValue];
        switch (i) {
            case 0:
                if((touchedX) >= barStartX && touchedX <= (barStartX + kBarWidth))
                {
                    if(touchedY >= barY && (touchedY) <= (barY + barHeight))
                    {
                        PropertyListViewController *propertyListViewController ;
                        propertyListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PropertyListViewController"];
                        //These Are the properties for setting the value of Month and Graphtype For PropertyListControls
                        //propertyListViewController.MonthSendFrommainView = @"Jan";
                        //propertyListViewController.GraphSendFrommainView = @"Listing";
                        //propertyListViewController.myValue = 5;
                        [self.navigationController pushViewController:propertyListViewController animated:NO ];                        NSLog(@"%f and %f", barHeight, touchedY);
                        
                    }
                    
                }
                
                break;
                
                
            case 1:
                if((touchedX) >= barStartX && touchedX <= (barStartX + kBarWidth))
                {
                    if(touchedY >= barY && (touchedY) <= (barY + barHeight))
                    {
                        PropertyListViewController *propertyListViewController ;
                        propertyListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PropertyListViewController"];
                        //These Are the properties for setting the value of Month and Graphtype For PropertyListControls
                        //propertyListViewController.MonthSendFrommainView = @"Jan";
                        //propertyListViewController.GraphSendFrommainView = @"Listing";
                        //propertyListViewController.myValue = 5;
                        [self.navigationController pushViewController:propertyListViewController animated:NO ];                        NSLog(@"%f and %f", barHeight, touchedY);
                    }
                    
                }
                break;
                
                
            case 2:
                if((touchedX) >= barStartX && touchedX <= (barStartX + kBarWidth))
                {
                    if(touchedY >= barY && (touchedY) <= (barY + barHeight))
                    {
                        PropertyListViewController *propertyListViewController ;
                        propertyListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PropertyListViewController"];
                        //These Are the properties for setting the value of Month and Graphtype For PropertyListControls
                        //propertyListViewController.MonthSendFrommainView = @"Jan";
                        //propertyListViewController.GraphSendFrommainView = @"Listing";
                        //propertyListViewController.myValue = 5;
                        [self.navigationController pushViewController:propertyListViewController animated:NO ];                        NSLog(@"%f and %f", barHeight, touchedY);
                    }
                    
                }
                
                break;
                
                
            case 3:
                if((touchedX) >= barStartX && touchedX <= (barStartX + kBarWidth))
                {
                    if(touchedY >= barY && (touchedY) <= (barY + barHeight))
                    {
                        PropertyListViewController *propertyListViewController ;
                        propertyListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PropertyListViewController"];
                        //These Are the properties for setting the value of Month and Graphtype For PropertyListControls
                        //propertyListViewController.MonthSendFrommainView = @"Jan";
                        //propertyListViewController.GraphSendFrommainView = @"Listing";
                        //propertyListViewController.myValue = 5;
                        [self.navigationController pushViewController:propertyListViewController animated:NO ];                        NSLog(@"%f and %f", barHeight, touchedY);
                    }
                    
                }
                
                break;
                
                
            case 4:
                if((touchedX) >= barStartX && touchedX <= (barStartX + kBarWidth))
                {
                    if(touchedY >= barY && (touchedY) <= (barY + barHeight))
                    {
                        PropertyListViewController *propertyListViewController ;
                        propertyListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PropertyListViewController"];
                        //These Are the properties for setting the value of Month and Graphtype For PropertyListControls
                        //propertyListViewController.MonthSendFrommainView = @"Jan";
                        //propertyListViewController.GraphSendFrommainView = @"Listing";
                        //propertyListViewController.myValue = 5;
                        [self.navigationController pushViewController:propertyListViewController animated:NO ];                        NSLog(@"%f and %f", barHeight, touchedY);
                    }
                    
                }
                
                break;
                
            case 5:
                if((touchedX) >= barStartX && touchedX <= (barStartX + kBarWidth))
                {
                    if(touchedY >= barY && (touchedY) <= (barY + barHeight))
                    {
                        PropertyListViewController *propertyListViewController ;
                        propertyListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PropertyListViewController"];
                        //These Are the properties for setting the value of Month and Graphtype For PropertyListControls
                        //propertyListViewController.MonthSendFrommainView = @"Jan";
                        //propertyListViewController.GraphSendFrommainView = @"Listing";
                        //propertyListViewController.myValue = 5;
                        [self.navigationController pushViewController:propertyListViewController animated:NO ];                        NSLog(@"%f and %f", barHeight, touchedY);
                        
                    }
                    
                }
                break;
            case 6:
                if((touchedX) >= barStartX && touchedX <= (barStartX + kBarWidth))
                {
                    if(touchedY >= barY && (touchedY) <= (barY + barHeight))
                    {
                        PropertyListViewController *propertyListViewController ;
                        propertyListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PropertyListViewController"];
                        //These Are the properties for setting the value of Month and Graphtype For PropertyListControls
                        //propertyListViewController.MonthSendFrommainView = @"Jan";
                        //propertyListViewController.GraphSendFrommainView = @"Listing";
                        //propertyListViewController.myValue = 5;
                        [self.navigationController pushViewController:propertyListViewController animated:NO ];                        NSLog(@"%f and %f", barHeight, touchedY);
                        
                    }
                    
                }
                
                
                
                break;
            case 7:
                if((touchedX) >= barStartX && touchedX <= (barStartX + kBarWidth))
                {
                    if(touchedY >= barY && (touchedY) <= (barY + barHeight))
                    {
                        PropertyListViewController *propertyListViewController ;
                        propertyListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PropertyListViewController"];
                        //These Are the properties for setting the value of Month and Graphtype For PropertyListControls
                        //propertyListViewController.MonthSendFrommainView = @"Jan";
                        //propertyListViewController.GraphSendFrommainView = @"Listing";
                        //propertyListViewController.myValue = 5;
                        [self.navigationController pushViewController:propertyListViewController animated:NO ];                        NSLog(@"%f and %f", barHeight, touchedY);
                        
                    }
                    
                }
                break;
            case 8:
                if((touchedX) >= barStartX && touchedX <= (barStartX + kBarWidth))
                {
                    if(touchedY >= barY && (touchedY) <= (barY + barHeight))
                    {
                        PropertyListViewController *propertyListViewController ;
                        propertyListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PropertyListViewController"];
                        //These Are the properties for setting the value of Month and Graphtype For PropertyListControls
                        //propertyListViewController.MonthSendFrommainView = @"Jan";
                        //propertyListViewController.GraphSendFrommainView = @"Listing";
                        //propertyListViewController.myValue = 5;
                        [self.navigationController pushViewController:propertyListViewController animated:NO ];                        NSLog(@"%f and %f", barHeight, touchedY);
                        
                    }
                    
                }
                break;
            case 9:
                if((touchedX) >= barStartX && touchedX <= (barStartX + kBarWidth))
                {
                    if(touchedY >= barY && (touchedY) <= (barY + barHeight))
                    {
                        PropertyListViewController *propertyListViewController ;
                        propertyListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PropertyListViewController"];
                        //These Are the properties for setting the value of Month and Graphtype For PropertyListControls
                        //propertyListViewController.MonthSendFrommainView = @"Jan";
                        //propertyListViewController.GraphSendFrommainView = @"Listing";
                        //propertyListViewController.myValue = 5;
                        [self.navigationController pushViewController:propertyListViewController animated:NO ];                        NSLog(@"%f and %f", barHeight, touchedY);
                    }
                    
                }
                break;
            case 10:
                if((touchedX) >= barStartX && touchedX <= (barStartX + kBarWidth))
                {
                    if(touchedY >= barY && (touchedY) <= (barY + barHeight))
                    {
                        PropertyListViewController *propertyListViewController ;
                        propertyListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PropertyListViewController"];
                        //These Are the properties for setting the value of Month and Graphtype For PropertyListControls
                        //propertyListViewController.MonthSendFrommainView = @"Jan";
                        //propertyListViewController.GraphSendFrommainView = @"Listing";
                        //propertyListViewController.myValue = 5;
                        [self.navigationController pushViewController:propertyListViewController animated:NO ];                        NSLog(@"%f and %f", barHeight, touchedY);
                        
                    }
                    
                }
                break;
            case 11:
                if((touchedX) >= barStartX && touchedX <= (barStartX + kBarWidth))
                {
                    if(touchedY >= (barY) && (touchedY) <= (barY + barHeight))
                    {
                        PropertyListViewController *propertyListViewController ;
                        propertyListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PropertyListViewController"];
                        //These Are the properties for setting the value of Month and Graphtype For PropertyListControls
                        //propertyListViewController.MonthSendFrommainView = @"Jan";
                        //propertyListViewController.GraphSendFrommainView = @"Listing";
                        //propertyListViewController.myValue = 5;
                        [self.navigationController pushViewController:propertyListViewController animated:NO ];                        NSLog(@"%f and %f", barHeight, touchedY);
                        
                    }
                    
                }
                break;
            default:
                break;
        }
        
        
    }
    
    
    
    
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

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    UITouch* touchPoint = [touches anyObject];
    NSLog(@"%@", touchPoint);
    //fromPoint = [touchPoint locationInView:self];
    //toPoint = [touchPoint locationInView:self];
    
    //[self setNeedsDisplay];
}

//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch* touch = [touches anyObject];
//    toPoint=[touch locationInView:self];
//    [self setNeedsDisplay];
//}
//
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch* touch = [touches anyObject];
//    toPoint = [touch locationInView:self];
//    [self setNeedsDisplay];
//}


@end
