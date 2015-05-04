//
//  TEALLog.h
//  DigitalVelocity
//
//  Created by George Webster on 3/5/15.
//  Copyright (c) 2015 Tealium. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TEALAudienceStreamConfiguration.h"

#define TEAL_LogNormal(s,...) [TEALLogger logTargetLevel:TEALAudienceStreamLogLevelNormal message:(s),##__VA_ARGS__];
#define TEAL_LogVerbose(s,...) [TEALLogger logTargetLevel:TEALAudienceStreamLogLevelVerbose message:(s),##__VA_ARGS__];
#define TEAL_LogExtreamVerbosity(s,...) [TEALLogger logTargetLevel:TEALAudienceStreamLogLevelExtremeVerbosity message:(s),##__VA_ARGS__];


@interface TEALLogger : NSObject

+ (void) setLogLevel:(TEALAudienceStreamLogLevel)logLevel;

+ (void) logTargetLevel:(TEALAudienceStreamLogLevel)targetLevel message:(NSString *)format, ...;

@end
