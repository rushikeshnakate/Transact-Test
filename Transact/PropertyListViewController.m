//
//  PropertyListViewController.m
//  Transact
//
//  Created by trsoft_dev1 on 16/09/14.
//  Copyright (c) 2014 TrSoft. All rights reserved.
//

#import "PropertyListViewController.h"
#import "PropertyViewCell.h"

@interface PropertyListViewController ()
{
    NSString *url;
}

@end

@implementation PropertyListViewController

@synthesize TableView;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.separatorColor = [UIColor colorWithRed:180/255.0 green:18/255.0  blue:0/255.0  alpha:0.5];
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
    
    PropertyImage = [[NSMutableArray alloc] init];
    PropertyAddress = [[NSMutableArray alloc] init];
    PropertyType = [[NSMutableArray alloc] init];
    
    
    url = @"http://192.168.1.104/api/Transaction/GetSearchTransactions/?userid=";
    NSString *userId = @"82896a34-b526-4502-9156-57a22fe499af";
    url = [url stringByAppendingString:userId];
    url = [url stringByAppendingString:@"&searchText="];
    url = [url stringByAppendingString:@"&currentPage=_currentPage"];
    
    _currentPage = 1;
    
    [self fetchInitialData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return PropertyAddress.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifer = @"TableCell";
    PropertyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer forIndexPath:indexPath];
    NSLog(@"indexElse = %@", [@(indexPath.item + 1) stringValue]);
    NSLog(@"currentpage = %@", [@(6 * _currentPage) stringValue]);
    
    // Configure the cell...
    
    //int row = [indexPath row];
    if((indexPath.item + 1) == (24 * _currentPage))
    {
        [self fetchMoreData];
    }
    cell.PropertyAddressCell.text = PropertyAddress[indexPath.row];
    cell.PropertyAddressCell.textColor = [UIColor brownColor];
    cell.PropertyTypeCell.text = PropertyType[indexPath.row];
    cell.PropertyTypeCell.textColor = [UIColor redColor];
   // [[cell PropertyImageCell]setImage :[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[PropertyImage objectAtIndex:indexPath.item]]]]];
    
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"ShowDetails"])
    {
       // DetailsViewController *detailsviewcontroller = [segue destinationViewController];
       
       // NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        
        //int row = (int)[myIndexPath row];
       // detailsviewcontroller.detailsModal = @[PropertyAddress[myIndexPath.row], PropertyType[myIndexPath.row], PropertyImage[myIndexPath.row]];
        
        
    }
}

#pragma mark - fetchInintialData Methods

- (void)fetchInitialData
{
    url = [url stringByReplacingOccurrencesOfString: @ "_currentPage" withString: [@(_currentPage) stringValue]];
    
    [PropertyAddress removeAllObjects];
    [PropertyType removeAllObjects];
    [PropertyImage removeAllObjects];
    
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
    
    for(int i =0; i < greeting.count; i++)
    {
        NSString *propertyAddressString=[greeting valueForKeyPath:@"Address"][i];
        NSString *propertyTypeString=[greeting valueForKeyPath:@"Address"][i];
        NSString *propertyImageString=[greeting valueForKeyPath:@"imageUrl"][i];
        [PropertyAddress addObject:propertyAddressString];
        [PropertyType addObject:propertyTypeString];
        [PropertyImage addObject:propertyImageString];
        
    }
}

#pragma mark - fetchMoreData Methods

- (void)fetchMoreData
{
    _currentPage = _currentPage + 1;
    
    if (_currentPage >= 2 && _currentPage <= 9) {
        url = [url substringToIndex:[url length]-1];
    }
    
    if (_currentPage >= 9) {
        url = [url substringToIndex:[url length]-2];
    }
    
    url = [url stringByAppendingString:[@(_currentPage) stringValue]];
    
    NSURL *yourUrl = [NSURL URLWithString:url];
    
    NSError *error = nil;
    
    NSURLResponse *response;
    NSData *localData = nil;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:yourUrl];
    
    [request setHTTPMethod:@"GET"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    localData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSDictionary *newJson = [NSJSONSerialization JSONObjectWithData:localData options:NSJSONReadingMutableContainers error:nil];
    
    // Variable used to say at which position you want to add the cells
    // If you want to start adding before the previous content, like new Tweets on twitter
    NSInteger index =  24;
    
    // If you want to start adding after the previous content, like reading older tweets on twitter
    //index = self.json.count;
    
    // Create the indexes with a loop
    NSMutableArray *indexes = [NSMutableArray array];
    
    for (NSInteger i = ((_currentPage - 1) * index); i < (_currentPage * index); i++)
    {
        [indexes addObject:[NSIndexPath indexPathForItem:i inSection:0]];
    }
    
    for(int i =0; i < newJson.count; i++)
    {
        NSString *propertyAddressString=[newJson valueForKeyPath:@"Address"][i];
        NSString *propertyTypeString=[newJson valueForKeyPath:@"Address"][i];
        NSString *propertyImageString=[newJson valueForKeyPath:@"imageUrl"][i];
        [PropertyAddress addObject:propertyAddressString];
        [PropertyType addObject:propertyTypeString];
        [PropertyImage addObject:propertyImageString];
        
    }
    
    // Perform the updates
    //[self.CollectionView performBatchUpdates:^{
    
    //Insert the new data to your current data
    NSLog(@"fetchMoreDataindex = %@", [@(index) stringValue]);
    
    
    _currentPage = _currentPage + 1;
    NSLog(@"pagefetchMoreDatacurrent = %@", [@(index * _currentPage) stringValue]);
    //Inser the new cells
    [self.tableView insertRowsAtIndexPaths:indexes
                          withRowAnimation:UITableViewRowAnimationAutomatic ];
    
    
    //} completion:nil];
    //
    
    
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
