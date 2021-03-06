//
//  TEALSettingsStore_Tests.m
//  ASTester
//
//  Created by George Webster on 3/18/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import <TEALAudienceStream/TEALSettings.h>
#import <TEALAudienceStream/TEALSettingsStore.h>
#import <TEALAudienceStream/TEALOperationManager.h>
#import <TEALAudienceStream/TEALURLSessionManager.h>
#import <TEALAudienceStream/TEALAudienceStreamConfiguration.h>


@interface TEALSettingsStore_Tests : XCTestCase <TEALSettingsStoreConfiguration>

@property (strong, nonatomic) TEALSettingsStore *settingsStore;
@property (strong, nonatomic) TEALOperationManager *operationManager;
@property (strong, nonatomic) TEALURLSessionManager *urlSessionManager;

@property (strong, nonatomic) TEALConnectConfiguration *configuration;

@end

@implementation TEALSettingsStore_Tests

- (void)setUp {
    [super setUp];
    
    self.operationManager = [TEALOperationManager new];
    
    self.urlSessionManager = [[TEALURLSessionManager alloc] initWithConfiguration:nil];
    
    self.urlSessionManager.completionQueue = self.operationManager.underlyingQueue;

    self.settingsStore = [[TEALSettingsStore alloc] initWithConfiguration:self];

    self.configuration = [TEALConnectConfiguration configurationWithAccount:@"tealiummobile"
                                                                           profile:@"demo"
                                                                       environment:@"dev"];

}

- (void)tearDown {

    self.operationManager = nil;
    self.urlSessionManager = nil;
    self.settingsStore = nil;

    self.configuration = nil;
    
    [super tearDown];
}


- (void) testConfigurationPollingFrequency {
    
    TEALProfilePollingFrequency targetFrequency = TEALProfilePollingFrequencyAfterEveryEvent;
    
    // default
    XCTAssertEqual(targetFrequency, self.configuration.pollingFrequency, @"TEALAudienceStreamConfiguration should default to %lu", (unsigned long)targetFrequency);
    
    targetFrequency = TEALProfilePollingFrequencyOnRequest;

    self.configuration.pollingFrequency = targetFrequency;

    TEALSettings *settings = [self.settingsStore settingsFromConfiguration:self.configuration visitorID:@""];
    
    
    XCTAssertEqual(targetFrequency, settings.pollingFrequency, @"Settigns Polling Frequency: %lu should be : %lu", (unsigned long)settings.pollingFrequency, (unsigned long)targetFrequency);
    

    targetFrequency = TEALProfilePollingFrequencyAfterEveryEvent;

    self.configuration.pollingFrequency = targetFrequency;
    
    settings = [self.settingsStore settingsFromConfiguration:self.configuration visitorID:@""];

    XCTAssertEqual(targetFrequency, settings.pollingFrequency, @"Settigns Polling Frequency: %lu should be : %lu", (unsigned long)settings.pollingFrequency, (unsigned long)targetFrequency);

}

- (void) testSettingsStorage {
    
    TEALSettings *startSettings = [self.settingsStore settingsFromConfiguration:self.configuration visitorID:@""];
    
    __block BOOL isReady = NO;
    
    [self.settingsStore fetchRemoteSettingsWithSetting:startSettings completion:^(TEALSettings *endSettings, NSError *error) {

        XCTAssertTrue([startSettings isEqual:endSettings], @"settings passed to completion should be same object passed in");

        isReady = YES;
    }];
    while (CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true) && !isReady){};
}

#pragma mark - TEALSettingsStoreConfiguration

- (NSString *) mobilePublishSettingsURLStringForSettings:(TEALSettings *)settings {
    return nil;
}

- (NSDictionary *) mobilePublishSettingsURLParams {
    return nil;
}


@end
