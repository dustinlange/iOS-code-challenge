//
//  NXTCellForObjectDelegate.h
//  ios-code-challenge
//
//  Created by Dustin Lange on 1/20/18.
//  Copyright © 2018 Dustin Lange. All rights reserved.
//

@import Foundation;

#import "NXTBindingDataForObjectDelegate.h"

@protocol NXTBindingDataForObjectDelgate;

@protocol NXTCellForObjectDelegate <NSObject>
    
- (id<NXTBindingDataForObjectDelegate>)cellForObjectForTableView:(UITableView *)tableView;
- (CGFloat)estimatedCellHeightForObjectForTableView:(UITableView *)tableView;
    
@end
