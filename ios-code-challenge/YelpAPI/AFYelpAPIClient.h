//
//  AFYelpAPIClient.h
//  ios-code-challenge
//
//  Created by Dustin Lange on 1/20/18.
//  Copyright © 2018 Dustin Lange. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFYelpAPIClient : AFHTTPSessionManager

+ (AFYelpAPIClient *)sharedClient;

@end
