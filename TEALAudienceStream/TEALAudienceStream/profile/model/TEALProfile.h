//
//  TEALProfile.h
//  TEALAudienceStream
//
//  Created by George Webster on 1/5/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TEALProfileCurrentVisit.h"

@interface TEALProfile : NSObject <NSCoding, NSCopying>

@property (copy, readonly) NSString *visitorID;

@property (readonly, nonatomic) BOOL isValid;

@property (readonly, nonatomic) NSDictionary *rawProfile;

@property (readonly, nonatomic) NSArray *audiences;
@property (readonly, nonatomic) NSArray *badges;
@property (readonly, nonatomic) NSArray *dates;
@property (readonly, nonatomic) NSArray *flags;
@property (readonly, nonatomic) NSArray *metrics;
@property (readonly, nonatomic) NSArray *properties;

@property (readonly, nonatomic) TEALProfileCurrentVisit *currentVisit;

- (instancetype) initWithVisitorID:(NSString *)visitorID;

@end
