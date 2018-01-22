//
//  AFYelpAPIClient+Search.m
//  ios-code-challenge
//
//  Created by Dustin Lange on 1/21/18.
//  Copyright © 2018 Dustin Lange. All rights reserved.
//

#import "AFYelpAPIClient+Search.h"
#import "YLPSearchQuery.h"
#import "YLPSearch.h"

@implementation AFYelpAPIClient (Search)

- (void)searchWithQuery:(YLPSearchQuery *)query
      completionHandler:(YLPSearchCompletionHandler)completionHandler
{
    [self GET:@"businesses/search"
    parameters:[query parameters]
    progress:nil
    success:^(NSURLSessionDataTask *task, id responseObject)
    {
        YLPSearch *searchResult = [[YLPSearch alloc] initWithAttributes:responseObject];
        completionHandler(searchResult, nil);
    }
    failure:^(NSURLSessionDataTask *task, id responseObject)
    {
        completionHandler(nil, responseObject);
    }];
}

@end
