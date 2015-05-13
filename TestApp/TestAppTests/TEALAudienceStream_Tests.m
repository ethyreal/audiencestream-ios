//
//  TEALAudienceStream_Tests.m
//  ASTester
//
//  Created by George Webster on 3/18/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import <TEALAudienceStream/TEALAudienceStream.h>
#import <TEALAudienceStream/TEALSettings.h>

#import "TEALAudienceStream+PrivateHeader.h"


@interface TEALAudienceStream_Tests : XCTestCase

@property (strong) TEALAudienceStream *audienceStream;
@property TEALAudienceStreamConfiguration *configuration;
@end

@implementation TEALAudienceStream_Tests

- (void) setUp {
    [super setUp];
    
    self.audienceStream = [[TEALAudienceStream alloc] initPrivate];

    self.configuration = [TEALAudienceStreamConfiguration configurationWithAccount:@"tealiummobile"
                                                                           profile:@"demo"
                                                                       environment:@"dev"];

    __block BOOL isReady = NO;

    [self.audienceStream setupConfiguration:self.configuration
                                 completion:^(BOOL success, NSError *error) {
                                     isReady = YES;
                                 }];
    while (CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true) && !isReady){}

}

- (void) tearDown {

    [TEALAudienceStream disable];
    self.audienceStream = nil;
    
    [super tearDown];
}

#pragma mark - Helpers

- (void) enableWithSettings:(TEALSettings *)settings {
    
    self.audienceStream.enabled = YES;
    
    __block BOOL isReady = NO;
    
    [self.audienceStream fetchSettings:settings completion:^(BOOL success, NSError *error) {
        
        isReady = YES;
    }];
    
    while (CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true) && !isReady){};
}

#pragma mark - Test Configuration / Settings updates

- (void) testSettingsStorage {
    
    TEALSettings *settings = [self.audienceStream.settingsStore settingsFromConfiguration:self.configuration
                                                                                visitorID:@""];

    [self enableWithSettings:settings];
    
    XCTAssertTrue([self.audienceStream.settingsStore.currentSettings isEqual:settings], @"saved settings should be same object passed in");
}

- (void) testInvalidAccount {
    
    TEALAudienceStreamConfiguration *config = [TEALAudienceStreamConfiguration configurationWithAccount:@"invalid_tealiummobile"
                                                                                                profile:@"demo"
                                                                                            environment:@"dev"];
    
    TEALSettings *settings = [self.audienceStream.settingsStore settingsFromConfiguration:config visitorID:@""];
    
    [self enableWithSettings:settings];
    
    XCTAssertTrue(self.audienceStream.settingsStore.currentSettings.status == TEALSettingsStatusInvalid, @"Stored status should be invalid");
    
    XCTAssertFalse(self.audienceStream.enabled, @"Library should be disabled on invalid settings status");
}

- (void) testNoMobilePublishSettings {
    
    TEALAudienceStreamConfiguration *config = [TEALAudienceStreamConfiguration configurationWithAccount:@"tealiummobile"
                                                                                                profile:@"ios-demo"
                                                                                            environment:@"dev"];
    
    TEALSettings *settings = [self.audienceStream.settingsStore settingsFromConfiguration:config visitorID:@""];
    
    [self enableWithSettings:settings];
    
    XCTAssertTrue(self.audienceStream.settingsStore.currentSettings.status == TEALSettingsStatusInvalid, @"Stored status should be invalid");
    
    XCTAssertFalse(self.audienceStream.enabled, @"Library should be disabled on invalid settings status");
}

#pragma mark - Trace

- (void) testTrace {
    
    TEALSettings *settings = [self.audienceStream.settingsStore settingsFromConfiguration:self.configuration visitorID:@""];
    
    [self enableWithSettings:settings];

    NSString *token = @"A1B2C3";
    
    settings = self.audienceStream.settingsStore.currentSettings;
    
    XCTAssertTrue(settings.traceID == nil, @"TraceID datasource should default to nil");
    
    [self.audienceStream joinTraceWithToken:token];
    
    XCTAssertTrue(settings.traceID != nil, @"TraceID datasource:%@ now have a value.", settings.traceID);
    
    XCTAssertTrue([settings.traceID isEqualToString:token], @"TraceID datasource value: %@ should be same as token passed in: %@", settings.traceID, token);
    
    [self.audienceStream leaveTrace];

    XCTAssertTrue(settings.traceID == nil, @"TraceID datasource :%@ should now be nil", settings.traceID);
    
}


#pragma mark - Dispatch

- (void) testDispatch {
    
    TEALSettings *settings = [self.audienceStream.settingsStore settingsFromConfiguration:self.configuration visitorID:@""];
    
    [self enableWithSettings:settings];

    TEALDispatchBlock completion = ^(TEALDispatchStatus status, TEALDispatch *dispatch, NSError *error) {
        
        XCTAssertEqual(status, TEALDispatchStatusSent, @"Dispatch: %@, should have been sent", dispatch);
    };
    
    [self.audienceStream.dispatchManager addDispatchForEvent:TEALEventTypeLink
                                                    withData:@{@"test_key":@"test_value"}
                                             completionBlock:completion];

    self.audienceStream.settingsStore.currentSettings.dispatchSize = 5;

    completion = ^(TEALDispatchStatus status, TEALDispatch *dispatch, NSError *error) {
        
        XCTAssertEqual(status, TEALDispatchStatusQueued, @"Dispatch: %@, should have been queued", dispatch);
    };
    
    for (NSInteger xi = 0; xi < 5; xi ++) {
        [self.audienceStream.dispatchManager addDispatchForEvent:TEALEventTypeLink
                                                        withData:@{@"test_key":@"test_value"}
                                                 completionBlock:completion];
    }
}



@end
