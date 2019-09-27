//
//  NXTBusinessTableViewCell+YLPBusiness.m
//  ios-code-challenge
//
//  Created by Dustin Lange on 1/21/18.
//  Copyright © 2018 Dustin Lange. All rights reserved.
//

#import "NXTBusinessTableViewCell+YLPBusiness.h"
#import "YLPBusiness.h"

@implementation NXTBusinessTableViewCell (YLPBusiness) 

- (void)configureCell:(YLPBusiness *)business
{
    // Business Name
    self.nameLabel.text = business.name;
    // Categories
    self.categoryLabel.text = business.categories;
    // Rating
    self.ratingLabel.text = [NSString stringWithFormat:@"Rating: %0.1f", business.rating];
    // Number of reviews
    self.reviewCountLabel.text = [NSString stringWithFormat:@"Number of reviews: %lu", business.reviewCount];
    // Distance
    self.distanceLabel.text = [NSString stringWithFormat:@"Distance: %0.2f", business.distance];
    // Thumbnail - Image View
    self.businessImageView.clipsToBounds = YES;
    self.businessImageView.contentMode = UIViewContentModeCenter;
    self.businessImageView.contentMode = UIViewContentModeScaleAspectFit;
    // Set image
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: business.imageUrlString]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.businessImageView.image = [UIImage imageWithData: data];
        });
    });
}

#pragma mark - NXTBindingDataForObjectDelegate
- (void)bindingDataForObject:(id)object
{
    [self configureCell:(YLPBusiness *)object];
}

@end
