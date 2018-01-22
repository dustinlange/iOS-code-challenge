//
//  NXTBindingDataForObjectDelegate.h
//  ios-code-challenge
//
//  Created by Dustin Lange on 1/20/18.
//  Copyright © 2018 Dustin Lange. All rights reserved.
//

@import Foundation;

@protocol NXTBindingDataForObjectDelegate <NSObject>
    
- (void)bindingDataForObject:(id)object;
    
@optional
- (void)willDisplayCellForObject:(id)object;
    
@end
