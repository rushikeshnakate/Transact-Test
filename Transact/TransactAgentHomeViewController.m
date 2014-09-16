//
//  TransactAgentHomeViewController.m
//  Transact
//
//  Created by Trsoft Developer on 13/09/14.
//  Copyright (c) 2014 TrSoft. All rights reserved.
//

#import "TransactAgentHomeViewController.h"
#import "TransactSearchPropertyCVCell.h"

@interface TransactAgentHomeViewController ()

@end

@implementation TransactAgentHomeViewController
@synthesize CollectionView;

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
    
    [[self CollectionView]setDataSource:self];
    [[self CollectionView]setDelegate:self];
    
    url = @"http://192.168.2.104/api/Transaction/GetSearchTransactions/?userid=";
    NSString *userId = @"82896a34-b526-4502-9156-57a22fe499af";
    url = [url stringByAppendingString:userId];
    url = [url stringByAppendingString:@"&searchText="];
    url = [url stringByAppendingString:@"&currentPage=_currentPage"];
    
    _currentPage = 1;
    
    arrayofImages = [[NSMutableArray alloc] init];
    arrayofLabels = [[NSMutableArray alloc] init];
    
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

#pragma mark - UICollectionView DataSource and Delegate Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return arrayofLabels.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    NSLog(@"%ld", (long)indexPath.item);
    
    if((indexPath.item + 1) == (24 * _currentPage))
    {
        [self loadMoreData];
    }
    
    //    if (_currentPage == 1)
    //    {
    //        if(indexPath.item == 11)
    //        {
    //            [self loadData];
    //        }
    //    }
    //    if (_currentPage == 2)
    //    {
    //        if(indexPath.item == 11)
    //        {
    //            [self loadData];
    //        }
    //
    //    }
    
    
    
    //    if (indexPath.item < arrayofLabels.count) {
    ////    if(indexPath.item == (arrayofLabels.count - ITEMS_PAGE_SIZE + 1))
    ////    {
    ////        [self fetchMoreData];
    ////    }
    //
    //
    //
    //    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    //
    //    //[[cell myImage]setImage :[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[arrayofImages objectAtIndex:indexPath.item]]]]];
    //
    //    [[cell myLabel]setText:[arrayofLabels objectAtIndex:indexPath.item]];
    //
    //    cell.myLabel.textColor = [UIColor blackColor];
    //    cell.myLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:7.0f];
    //    return cell;
    //    }
    //
    //    else
    //    {
    //        CustomCell *cell = [CollectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    //        [[cell myLabel]setText:[arrayofLabels objectAtIndex:indexPath.item]];
    //
    //
    //        NSLog(@"indexElse = %@", [@(indexPath.item) stringValue]);
    //        return cell;
    //
    //    }
    //NSLog(@"index = %@", [@(indexPath.item) stringValue]);
    /*if (indexPath.item < arrayofLabels.count)
     {
     // pre-fetch the next 'page' of data.
     ////NSLog(@"items.count > %d", self.items.count);
     ////NSLog(@"indexPath > %d", indexPath.item);
     if(indexPath.item == (arrayofLabels.count - ITEMS_PAGE_SIZE + 1))
     {
     [self fetchMoreData];
     }
     
     return [self itemCellForIndexPath:indexPath];
     }
     else
     {
     [self fetchMoreData];
     return [self loadingCellForIndexPath:indexPath];
     }*/
    
    //[self fetchMoreData];
    TransactSearchPropertyCVCell *cell = [CollectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    [[cell myImage]setImage :[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[arrayofImages objectAtIndex:indexPath.item]]]]];
    [[cell myLabel]setText:[arrayofLabels objectAtIndex:indexPath.item]];
    cell.myLabel.textColor = [UIColor blackColor];
    cell.myLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:12.0f];
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UISearchDelegate Methods

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    searchText = [searchText stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    url = @"http://192.168.1.104/api/Transaction/GetSearchTransactions/?userid=";
    NSString *userId = @"82896a34-b526-4502-9156-57a22fe499af";
    url = [url stringByAppendingString:userId];
    
    if (searchText.length < 2)
    {
        url = [url stringByAppendingString:@"&searchText="];
        url = [url stringByAppendingString:@"&currentPage=_currentPage"];
        
        _currentPage = 1;
        
        [self fetchInintialData];
    }
    else
    {
        url = [url stringByAppendingString:@"&searchText="];
        url = [url stringByAppendingString:searchText];
        url = [url stringByAppendingString:@"&currentPage=_currentPage"];
        
        _currentPage = 1;
        
        [self fetchInintialData];
        
    }
}

#pragma mark - fetchInintialData Methods

- (void)fetchInintialData
{
    url = [url stringByReplacingOccurrencesOfString: @ "_currentPage" withString: [@(_currentPage) stringValue]];
    
    [arrayofLabels removeAllObjects];
    [arrayofImages removeAllObjects];
    
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
        NSString *labelString=[greeting valueForKeyPath:@"Address"][i];
        NSString *imageString=[greeting valueForKeyPath:@"imageUrl"][i];
        [arrayofLabels addObject:labelString];
        [arrayofImages addObject:imageString];
        
    }
    [self.CollectionView reloadData];
}

-(void) loadMoreData
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
    
    // Perform the updates
    //[self.CollectionView performBatchUpdates:^{
    
    //Insert the new data to your current data
    for(int i =0; i < newJson.count; i++)
    {
        [arrayofLabels addObject:[newJson valueForKeyPath:@"Address"][i]];
        [arrayofImages addObject:[newJson valueForKeyPath:@"imageUrl"][i]];
    }
    
    //Inser the new cells
    [self.CollectionView insertItemsAtIndexPaths:indexes];
    
    //} completion:nil];
    //
}

//- (IBAction)transFolder:(UIButton *)sender;
//{
//    TransFolderController *controller =  [self.storyboard instantiateViewControllerWithIdentifier:@"TransFolderController"];

//    [self presentViewController:controller animated:YES completion:nil ];
//}
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