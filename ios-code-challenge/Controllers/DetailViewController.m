//
//  DetailViewController.m
//  ios-code-challenge
//
//  Created by Dustin Lange on 1/20/18.
//  Copyright © 2018 Dustin Lange. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic, strong) UIBarButtonItem *favoriteBarButtonItem;
@property (nonatomic, assign, getter=isFavorite) BOOL favorite;

@end

@implementation DetailViewController

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    self.navigationItem.rightBarButtonItems = @[self.favoriteBarButtonItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateFavoriteBarButtonState
{
    self.favoriteBarButtonItem.image = (self.isFavorite ? [UIImage imageNamed:@"Star-Filled"] : [UIImage imageNamed:@"Star-Outline"]);
}

#pragma mark - Managing the detail item
- (void)setDetailItem:(NSDate *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

#pragma mark - Button Events
- (void)onFavoritBarButtonSelected:(id)sender
{
    _favorite = !self.isFavorite;
    [self updateFavoriteBarButtonState];
}

#pragma mark - Properties
- (UIBarButtonItem *)favoriteBarButtonItem
{
    if(_favoriteBarButtonItem == nil) {
        _favoriteBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Star-Outline"]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(onFavoritBarButtonSelected:)];
    }
    
    return _favoriteBarButtonItem;
}

@end
