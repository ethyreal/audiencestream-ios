//
//  TEALAudienceStream.h
//  TEALAudienceStream Library
//
//  Created by George Webster on 1/8/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//
//  Version 0.5

#import <Foundation/Foundation.h>
#import "TEALProfile.h"
#import "TEALAudienceStreamConfiguration.h"
#import <TealiumUtilities/TEALBlocks.h>
#import "TEALEvent.h"


@interface TEALAudienceStream : NSObject

# pragma mark - Setup / Configuration

+ (void) enableWithConfiguration:(TEALAudienceStreamConfiguration *)configuration;

+ (void) enableWithConfiguration:(TEALAudienceStreamConfiguration *)configuration
                      completion:(TEALBooleanCompletionBlock)completion;

+ (void) disable;

# pragma mark - Send AudienceStream Data

+ (void) sendEvent:(TEALEventType)eventType
          withData:(NSDictionary *)customData;

# pragma mark - Get AudienceStream Data

+ (void) fetchProfileWithCompletion:(void (^)(TEALProfile *profile, NSError *error))completion;

+ (TEALProfile *) cachedProfileCopy;

+ (NSString *) visitorID;

#pragma mark - Trace

+ (void) joinTraceWithToken:(NSString *)token;

+ (void) leaveTrace;

@end
