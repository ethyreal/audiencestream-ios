//
//  TealAudienceStreamDispatchManager_Tests.m
//  ASTester
//
//  Created by George Webster on 3/18/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import <TEALAudienceStream/TEALAudienceStream.h>
#import "TEALAudienceStream+PrivateHeader.h"

#import <TEALAudienceStream/TEALAudienceStreamDispatchManager.h>

@interface TEALAudienceStreamDispatchManager_Tests : XCTestCase <TEALAudienceStreamDispatchManagerConfiguration, TEALAudienceStreamDispatchManagerDelegate>

@property (strong) TEALAudienceStreamDispatchManager *dispatchManager;

@property BOOL shouldDispatch;
@property NSUInteger batchSize;
@property NSUInteger offlineQueueCapacity;

@property (strong) TEALURLSessionManager *urlSessionManager;

@end

@implementation TEALAudienceStreamDispatchManager_Tests

- (void)setUp {
    [super setUp];

    self.urlSessionManager = [[TEALURLSessionManager alloc] initWithConfiguration:nil];
    
    self.dispatchManager = [[TEALAudienceStreamDispatchManager alloc] initWithConfiguration:self
                                                                                   delegate:self];

}

- (void)tearDown {

    self.dispatchManager = nil;

    
    self.shouldDispatch = NO;

    [super tearDown];
}


#pragma mark - <TEALAudienceStreamDispatchManagerDelegate> Methods

- (NSDictionary *) datasourcesForEventType:(TEALEventType)eventType {

    return [NSDictionary new];
}

- (NSString *) dispatchURLString {
    
    return @"http://something.com";
}

- (BOOL) shouldAttemptDispatch {
    return self.shouldDispatch;
}

- (NSUInteger) dispatchBatchSize {
    return self.batchSize;
}

- (NSUInteger) offlineDispatchQueueCapacity {
    return self.offlineDispatchQueueCapacity;
}


@end
