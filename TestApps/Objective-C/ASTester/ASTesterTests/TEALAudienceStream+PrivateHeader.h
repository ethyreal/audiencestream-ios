//
//  TEALAudienceStream+PrivateHeader.h
//  ASTester
//
//  Created by George Webster on 3/18/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import "TEALAudienceStream.h"
#import "TEALSettingsStore.h"
#import "TEALAudienceStreamDispatchManager.h"
#import "TEALURLSessionManager.h"
#import "TEALProfileStore.h"

@interface TEALAudienceStream (Private)

@property (strong, nonatomic) TEALSettingsStore *settingsStore;
@property (strong, nonatomic) TEALOperationManager *operationManager;
@property (strong, nonatomic) TEALProfileStore *profileStore;
@property (strong, nonatomic) TEALAudienceStreamDispatchManager *dispatchManager;
@property (strong, nonatomic) TEALURLSessionManager *urlSessionManager;

@property (nonatomic) BOOL enabled;

- (instancetype) initPrivate;

- (void) setupConfiguration:(TEALAudienceStreamConfiguration *)configuration
                 completion:(TEALBooleanCompletionBlock)setupCompletion;

- (void) fetchSettings:(TEALSettings *)settings
            completion:(TEALBooleanCompletionBlock)setupCompletion;

- (void) enable;

- (void) joinTraceWithToken:(NSString *)token;
- (void) leaveTrace;

@end
