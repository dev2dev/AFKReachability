//
//  ReachabilityView.h
//  AFKReachability
//
//  Created by Marco Tabini on 10-10-19.
//  Copyright 2010 AFK Studio Partnership. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFKReachability.h"


@interface ReachabilityView : UIView {
	UILabel *label;
	AFKReachability *reachability;
}

@end
