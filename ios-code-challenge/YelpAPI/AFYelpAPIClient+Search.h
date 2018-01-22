//
//  AFYelpAPIClient+Search.h
//  ios-code-challenge
//
//  Created by Dustin Lange on 1/21/18.
//  Copyright © 2018 Dustin Lange. All rights reserved.
//

#import "AFYelpAPIClient.h"

@class YLPSearch;
@class YLPSearchQuery;

NS_ASSUME_NONNULL_BEGIN

typedef void(^YLPSearchCompletionHandler)(YLPSearch *_Nullable search, NSError *_Nullable error);

@interface AFYelpAPIClient (Search)

- (void)searchWithQuery:(YLPSearchQuery *)query
      completionHandler:(YLPSearchCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
