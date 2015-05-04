//
//  TEALLog.m
//  TEALAudienceStream Library
//
//  Created by George Webster on 3/5/15.
//  Copyright (c) 2015 Tealium. All rights reserved.
//

#import "TEALLogger.h"

static TEALAudienceStreamLogLevel _audienceStreamLogLevel;

@implementation TEALLogger

+ (void) setLogLevel:(TEALAudienceStreamLogLevel)logLevel {

    _audienceStreamLogLevel = logLevel;
}

+ (void) logTargetLevel:(TEALAudienceStreamLogLevel)targetLevel message:(NSString *)format, ... {

    BOOL shouldLog = NO;
    switch (targetLevel) {
        case TEALAudienceStreamLogLevelNormal:
            shouldLog = (_audienceStreamLogLevel >= TEALAudienceStreamLogLevelNormal);
            break;
        case TEALAudienceStreamLogLevelVerbose:
            shouldLog = (_audienceStreamLogLevel >= TEALAudienceStreamLogLevelVerbose);
            break;
        case TEALAudienceStreamLogLevelExtremeVerbosity:
            shouldLog = (_audienceStreamLogLevel >= TEALAudienceStreamLogLevelExtremeVerbosity);
            break;
        case TEALAudienceStreamLogLevelNone:
            shouldLog = NO;
            break;
    }
    
    if (shouldLog && format) {

        NSString *message = nil;
        va_list args;
        va_start(args, format);
        message = [[NSString alloc] initWithFormat:format
                                         arguments:args];
        va_end(args);

        NSLog(@"%@", message);
    }
}

@end
