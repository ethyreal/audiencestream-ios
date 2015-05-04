//
//  AppDelegate.m
//  ASTester
//
//  Created by George Webster on 3/9/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import "AppDelegate.h"

#import "TEALAudienceStream.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    TEALAudienceStreamConfiguration *config = [TEALAudienceStreamConfiguration configurationWithAccount:@"tealiummobile"
                                                                                                profile:@"demo"
                                                                                            environment:@"dev"];
    
    config.logLevel = TEALAudienceStreamLogLevelExtremeVerbosity;
    config.pollingFrequency = TEALProfilePollingFrequencyOnRequest;
    
    [TEALAudienceStream enableWithConfiguration:config];
    
    [self sendLifecycleEventWithName:@"m_launch"];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

    [self sendLifecycleEventWithName:@"m_sleep"];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

    [self sendLifecycleEventWithName:@"m_wake"];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

- (void) sendLifecycleEventWithName:(NSString *)eventName {

    NSDictionary *data = @{@"event_name" : eventName};
    
    [TEALAudienceStream sendEvent:TEALEventTypeLink
                         withData:data];

}

@end
