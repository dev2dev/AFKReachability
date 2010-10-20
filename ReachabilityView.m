//
//  ReachabilityView.m
//  AFKReachability
//
//  Created by Marco Tabini on 10-10-19.
//  Copyright 2010 AFK Studio Partnership. All rights reserved.
//

#import "ReachabilityView.h"


@implementation ReachabilityView


- (void) reachabilityResult:(AFKReachabilityResult) result {
	switch (result) {
		case AFKReachabilityResult3G:
			label.text = @"3G Enabled";
			break;
			
		case AFKReachabilityResultWiFi:
			label.text = @"Wi-Fi Enabled";
			break;
			
		case AFKReachabilityResultUnreachable:
			label.text = @"No reachability";
			break;
	}
}


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		label = [[UILabel alloc] initWithFrame:self.bounds];
		label.textAlignment = UITextAlignmentCenter;
		
		[self addSubview:label];
		
		reachability = [[AFKReachability alloc] initWithTarget:self selector:@selector(reachabilityResult:) destination:@"www.phparch.com"];
		[reachability start];
    }
    return self;
}


- (void)dealloc {
	[reachability release];
	[label release];
    [super dealloc];
}


@end
