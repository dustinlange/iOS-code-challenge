//
//  YLPBusiness.m
//  ios-code-challenge
//
//  Created by Dustin Lange on 1/21/18.
//  Copyright © 2018 Dustin Lange. All rights reserved.
//

#import "YLPBusiness.h"

@implementation YLPBusiness

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    if(self = [super init]) {
        _identifier = attributes[@"id"];
        _name = attributes[@"name"];
        _categories = [self.class categoriesFromAttributes:attributes];
        _rating = [attributes[@"rating"] doubleValue];
        _reviewCount = [attributes[@"review_count"] integerValue];
        _distance = [attributes[@"distance"] doubleValue];
        _imageUrlString = attributes[@"image_url"];
    }
    
    return self;
}

+ (NSString *)categoriesFromAttributes:(NSDictionary*)attributes {
    NSArray *jsonCategories = attributes[@"categories"];
    NSMutableArray *businessCategories = [[NSMutableArray alloc] init];
    for (NSDictionary *category in jsonCategories) {
        [businessCategories addObject:[category objectForKey:@"title"]];
    }
    return [businessCategories componentsJoinedByString:@","];
}

@end
