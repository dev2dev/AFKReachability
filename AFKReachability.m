//
//  AFKReachability.m
//  AFKReachability
//
//  Created by Marco Tabini on 10-10-17.
//  Copyright 2010 AFK Studio Partnership. All rights reserved.
//

#import "AFKReachability.h"


@interface AFKReachability()

- (void) notifyDelegateWithReachability:(AFKReachabilityResult)result;

@end



void reachabilityCallback (SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void *info) {
	AFKReachabilityResult result = AFKReachabilityResultUnreachable;
	
	if (flags & kSCNetworkReachabilityFlagsReachable) {
		if (flags & kSCNetworkReachabilityFlagsIsWWAN) {
			result |= AFKReachabilityResult3G;
		} else {
			result |= AFKReachabilityResultWiFi;
		}
	}

	[((AFKReachability *) info) notifyDelegateWithReachability:result];
}


@implementation AFKReachability

@synthesize shouldReleaseOnResult;


+ (void) testReachabilityOfDestination:(NSString *) destinationUrl notifyTarget:(NSObject *) target selector:(SEL) selector {
	AFKReachability *reachability = [[AFKReachability alloc] initWithTarget:target selector:selector destination:destinationUrl];
	
	reachability.shouldReleaseOnResult = YES;
	[reachability start];
	
	// Note this leaks on purpose
}


- (id) initWithTarget:(NSObject *) aTarget selector:(SEL) aSelector destination:(NSString *) aDestinationUrl {
	if ((self = [super init])) {
		target = [aTarget retain];
		selector = aSelector;
		destinationUrl = [[NSString stringWithString:aDestinationUrl] retain];
	}
	
	return self;
}


- (void) notifyDelegateWithReachability:(AFKReachabilityResult) result {
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature signatureWithObjCTypes:[[NSString stringWithFormat:@"%s%s%s%s", @encode(void), @encode(id), @encode(id), @encode(AFKReachabilityResult)] UTF8String]]];
	
	[invocation setTarget:target];
	[invocation setSelector:selector];
	[invocation setArgument:&result atIndex:2];
	
	[invocation invoke];
	
	if (shouldReleaseOnResult) {
		[self release];
	}
}


- (void) start {
	reachability = SCNetworkReachabilityCreateWithName (NULL, [destinationUrl cStringUsingEncoding:NSUTF8StringEncoding]);
	
	SCNetworkReachabilityContext context = {
		0,
		self,
		NULL,
		NULL,
		NULL
	};
	
	SCNetworkReachabilitySetCallback(reachability, reachabilityCallback, &context);
	SCNetworkReachabilityScheduleWithRunLoop(reachability, CFRunLoopGetMain(), kCFRunLoopDefaultMode);
}


- (void) dealloc {	
	if (reachability) {
		SCNetworkReachabilityUnscheduleFromRunLoop(reachability, CFRunLoopGetMain(), kCFRunLoopDefaultMode);
		CFRelease(reachability);
	}

	[target release];
	[destinationUrl release];
	
	[super dealloc];
}


@end
