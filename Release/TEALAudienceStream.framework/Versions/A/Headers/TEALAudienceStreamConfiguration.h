//
//  TEALAudienceStreamConfiguration.h
//  TEALAudienceStream Library
//
//  Created by George Webster on 3/2/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Configuration Types

typedef NS_ENUM(NSUInteger, TEALProfilePollingFrequency) {
    TEALProfilePollingFrequencyOnRequest = 1,
    TEALProfilePollingFrequencyAfterEveryEvent
};

typedef NS_ENUM(NSUInteger, TEALAudienceStreamLogLevel) {
    TEALAudienceStreamLogLevelNone = 1,
    TEALAudienceStreamLogLevelNormal,
    TEALAudienceStreamLogLevelVerbose,
    TEALAudienceStreamLogLevelExtremeVerbosity
};


@interface TEALAudienceStreamConfiguration : NSObject

@property (copy, nonatomic) NSString *accountName;
@property (copy, nonatomic) NSString *profileName;
@property (copy, nonatomic) NSString *environmentName;

@property (nonatomic) BOOL useHTTP;
@property (nonatomic) TEALProfilePollingFrequency pollingFrequency;
@property (nonatomic) TEALAudienceStreamLogLevel logLevel;

@property (copy, nonatomic) NSString *audienceStreamProfile;

+ (instancetype) configurationWithAccount:(NSString *)accountName
                                  profile:(NSString *)profileName
                              environment:(NSString *)environmentName;


@end
