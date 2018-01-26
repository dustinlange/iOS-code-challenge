//
//  MasterViewController.m
//  ios-code-challenge
//
//  Created by Dustin Lange on 1/20/18.
//  Copyright © 2018 Dustin Lange. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AFYelpAPIClient.h"
#import "AFYelpAPIClient+Search.h"
#import "YLPSearchQuery.h"
#import "YLPSearch.h"
#import "NXTDataSource.h"

@interface MasterViewController ()

@property (nonatomic, strong) NXTDataSource *dataSource;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
    
    YLPSearchQuery *query = [[YLPSearchQuery alloc] initWithLocation:@"5550 West Executive Dr. Tampa, FL 33609"];
    
    __weak typeof(self) weakSelf = self;
    [[AFYelpAPIClient sharedClient] searchWithQuery:query
                                  completionHandler:^(YLPSearch *searchResult, NSError *error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.dataSource setObjects:searchResult.businesses];
        [strongSelf.tableView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = self.objects[indexPath.row];
//        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
//        [controller setDetailItem:object];
//        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Properties
- (NXTDataSource *)dataSource
{
    if(_dataSource == nil) {
        _dataSource = [[NXTDataSource alloc] initWithObjects:nil];
        
        __weak typeof(self) weakSelf = self;
        _dataSource.tableViewDidReceiveData = ^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf.tableView reloadData];
        };
    }
    
    return _dataSource;
}

@end
