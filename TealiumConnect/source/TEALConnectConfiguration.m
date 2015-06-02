//
//  TEALConnectConfiguration.m
//  Tealium Connect Library
//
//  Created by George Webster on 3/2/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import "TEALConnectConfiguration.h"

@implementation TEALConnectConfiguration

+ (instancetype) configurationWithAccount:(NSString *)accountName
                                  profile:(NSString *)profileName
                              environment:(NSString *)environmentName {
    
    TEALConnectConfiguration *configuration = [[TEALConnectConfiguration alloc] init];
    
    if (!configuration) {
        return nil;
    }
    
    configuration.accountName       = accountName;
    configuration.profileName       = profileName;
    configuration.environmentName   = environmentName;
    configuration.useHTTP           = NO;
    configuration.pollingFrequency  = TEALProfilePollingFrequencyAfterEveryEvent;
    configuration.logLevel          = TEALConnectLogLevelNone;
   
    configuration.audienceStreamProfile = @"main";
    
    return configuration;
}

@end
