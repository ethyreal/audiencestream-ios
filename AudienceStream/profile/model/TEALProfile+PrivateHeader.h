//
//  TEALProfile+PrivateHeader.h
//  AudienceStream Library
//
//  Created by George Webster on 2/10/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import "TEALProfile.h"
#import "TEALProfileCurrentVisit.h"

@interface TEALProfile (PrivateHeader)

- (void) storeRawProfile:(NSDictionary *)rawProfile;

@end

@interface TEALProfileCurrentVisit (PrivateHeader)

- (void) storeRawCurrentVisit:(NSDictionary *)rawProfile;

@end
