//
//  TEALAudienceStreamConfiguration.m
//  TEALAudienceStream Library
//
//  Created by George Webster on 3/2/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import "TEALAudienceStreamConfiguration.h"

@implementation TEALAudienceStreamConfiguration

+ (instancetype) configurationWithAccount:(NSString *)accountName
                                  profile:(NSString *)profileName
                              environment:(NSString *)environmentName {
    
    TEALAudienceStreamConfiguration *configuration = [[TEALAudienceStreamConfiguration alloc] init];
    
    if (!configuration) {
        return nil;
    }
    
    configuration.accountName       = accountName;
    configuration.profileName       = profileName;
    configuration.environmentName   = environmentName;
    configuration.useHTTP           = NO;
    configuration.pollingFrequency  = TEALProfilePollingFrequencyAfterEveryEvent;
    configuration.logLevel          = TEALAudienceStreamLogLevelNone;
   
    configuration.audienceStreamProfile = @"main";
    
    return configuration;
}

@end
