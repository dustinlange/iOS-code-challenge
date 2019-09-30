//
//  YLPBusiness.h
//  ios-code-challenge
//
//  Created by Dustin Lange on 1/21/18.
//  Copyright © 2018 Dustin Lange. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface YLPBusiness : NSObject

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

/**
 *  Yelp id of this business.
 */
@property (nonatomic, readonly, copy) NSString *identifier;

/**
 *  Name of this business.
 */
@property (nonatomic, readonly, copy) NSString *name;

/**
 *  Categories of this business.
 */
@property (nonatomic, readonly, copy) NSString *categories;

/**
 *  Rating of this business.
 */
@property (nonatomic, readonly) double rating;

/**
 *  Number of reviews of this business.
 */
@property (nonatomic, readonly) NSUInteger reviewCount;

/**
 *  Distance from this business.
 */
@property (nonatomic, readonly) double distance;

/**
 *  Image url of this business.
 */
@property (nonatomic, readonly, copy) NSString *imageUrlString;

/**
 * Price level of this business.
 */
@property (nonatomic, readonly, copy) NSString *price;

@end

NS_ASSUME_NONNULL_END
