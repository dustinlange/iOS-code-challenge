//
//  YLPSearchQuery.h
//  ios-code-challenge
//
//  Created by Dustin Lange on 1/21/18.
//  Copyright © 2018 Dustin Lange. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface YLPSearchQuery : NSObject

- (instancetype)initWithLocation:(NSString *)location;
- (NSDictionary *)parameters;

/**
 *  Optional. Search term (e.g. "food", "restaurants"). If term isn’t included we
 *  search everything. The term keyword also accepts business names such as "Starbucks".
 */
@property (nonatomic, copy, nullable) NSString *term;

/**
 *  Optional. Categories to filter the search results with.
 *  The category filter can be a list of comma delimited categories. For example,
 *  "bars,french" will filter by Bars OR French. The category identifier should be
 *  used (for example "discgolf", not "Disc Golf").
 */
@property (nonatomic, copy, null_resettable) NSArray<NSString *> *categoryFilter;

/**
 *  Optional. Search radius in meters. If the value is too large, a AREA_TOO_LARGE
 *  error may be returned. The max value is 40000 meters (25 miles).
 */
@property (nonatomic, assign) double radiusFilter;

/**
 * Optional. Suggestion to the search algorithm that the results be sorted by one of the these modes:
 * best_match, rating, review_count or distance. The default is best_match. Note that specifying the
 * sort_by is a suggestion (not strictly enforced) to Yelp's search, which considers multiple input
 * parameters to return the most relevant results. For example, the rating sort is not strictly sorted by
 * the rating value, but by an adjusted rating value that takes into account the number of ratings,
 * similar to a Bayesian average. This is to prevent skewing results to businesses with a single review.
 */
@property (nonatomic, assign, nullable) NSString *sortBy;

/**
 * Amount to offset list of businesses being returned.
 */
@property (nonatomic, assign) NSUInteger offset;

@end

NS_ASSUME_NONNULL_END
