//
//  AFKReachability.h
//  AFKReachability
//
//  Created by Marco Tabini on 10-10-17.
//  Copyright 2010 AFK Studio Partnership. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <SystemConfiguration/SCNetwork.h>
#import <SystemConfiguration/SCNetworkReachability.h>


typedef enum {
	AFKReachabilityResultUnreachable = 0,
	AFKReachabilityResultWiFi = 1,
	AFKReachabilityResult3G = 2
} AFKReachabilityResult;


@interface AFKReachability : NSObject {
	SCNetworkReachabilityRef reachability;
	
	NSObject *target;
	SEL selector;
	NSString *destinationUrl;
	
	BOOL shouldReleaseOnResult;
}


@property (nonatomic,assign) BOOL shouldReleaseOnResult;


+ (void) testReachabilityOfDestination:(NSString *) destinationUrl notifyTarget:(NSObject *) target selector:(SEL) selector;


- (id) initWithTarget:(NSObject *)aTarget selector:(SEL)aSelector destination:(NSString *)aDestinationUrl;
- (void) start;



@end