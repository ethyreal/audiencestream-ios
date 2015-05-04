//
//  TEALProfileStore.m
//  AudienceStream Library
//
//  Created by George Webster on 2/18/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import "TEALProfileStore.h"

#import "TEALProfile.h"
#import "TEALProfile+PrivateHeader.h"
#import "TEALNetworkHelpers.h"
#import "TEALURLSessionManager.h"

#import "TEALError.h"
#import "TEALLogger.h"

@interface TEALProfileStore ()

@property (strong, nonatomic) TEALProfile *currentProfile;

@property (strong, nonatomic) NSURL *profileURL;
@property (strong, nonatomic) NSURL *profileDefinitionURL;

@property (weak, nonatomic) TEALURLSessionManager *urlSessionManager;

@end

@implementation TEALProfileStore

- (instancetype) initWithURLSessionManager:(TEALURLSessionManager *)urlSessionManager
                                profileURL:(NSURL *)profileURL
                             definitionURL:(NSURL *)definitionURL
                                 visitorID:(NSString *)visitorID {

    self = [self init];
    
    if (self) {
        _profileURL             = profileURL;
        _profileDefinitionURL   = definitionURL;
        _urlSessionManager      = urlSessionManager;
        _currentProfile         = [[TEALProfile alloc] initWithVisitorID:visitorID];
    }
    
    return self;
}

- (void) fetchProfileWithCompletion:(TEALProfileCompletionBlock)completion {

    if (!self.urlSessionManager || !self.profileURL) {
        NSError *error = [TEALError errorWithCode:TEALErrorCodeMalformed
                                      description:@"Profile request unsuccessful"
                                           reason:@"properties urlSessionManager: TEALURLSessionManager and/or profileURL: NSURL are missing"
                                       suggestion:@"ensure the urlSessionManager and/or profileURL properties has been set with a valid object"];
        
        completion( nil, error );
        
        return;
    }
    
    
    NSURLRequest *request = [TEALNetworkHelpers requestWithURL:self.profileURL];
    
    if (!request) {
        
        NSError *error = [TEALError errorWithCode:TEALErrorCodeMalformed
                                      description:@"Profile request unsuccessful"
                                           reason:[NSString stringWithFormat:@"Failed to generate valid request from URL: %@", self.profileURL]
                                       suggestion:@"Check the Account/Profile/Enviroment values in your configuration"];
        completion( nil, error ) ;
        return;
    }
    
    if (![self.urlSessionManager.reachability isReachable]) {
        
        TEAL_LogVerbose(@"offline: %@", request);
        NSError *error = [TEALError errorWithCode:TEALErrorCodeFailure
                                      description:@"Profile Request Failed"
                                           reason:@"Network Connection Unavailable"
                                       suggestion:@""];
        completion( nil, error );
        
        return;
    }
    
    [self.urlSessionManager performRequest:request
                     withJSONCompletion:^(NSHTTPURLResponse *response, NSDictionary *data, NSError *connectionError) {

                         if (connectionError) {
                             
                             TEAL_LogVerbose(@"Profile Fetch Failed with response: %@, error: %@", response, [connectionError localizedDescription]);
                         }
                         [self.currentProfile storeRawProfile:data];

                         completion( self.currentProfile, connectionError);
                     }];
}


- (void) fetchProfileDefinitionsWithCompletion:(TEALDictionaryCompletionBlock)completion {

    if (!self.urlSessionManager || !self.profileDefinitionURL) {
        NSError *error = [TEALError errorWithCode:TEALErrorCodeMalformed
                                      description:@"Profile request unsuccessful"
                                           reason:@"properties urlSessionManager: TEALURLSessionManager and/or profileDefinitionURL: NSURL are missing"
                                       suggestion:@"ensure the urlSessionManager and/or profileDefinitionURL properties has been set with a valid object"];
        
        completion( nil, error );
        
        return;
    }
    
    NSURLRequest *request = [TEALNetworkHelpers requestWithURL:self.profileDefinitionURL];
    
    if (!request) {
        
        NSError *error = [TEALError errorWithCode:TEALErrorCodeMalformed
                                      description:@"Profile request unsuccessful"
                                           reason:[NSString stringWithFormat:@"Failed to generate valid request from URL: %@", self.profileDefinitionURL]
                                       suggestion:@"Check the Account/Profile/Enviroment values in your configuration"];

        completion( nil, error) ;
        return;
    }

    [self.urlSessionManager performRequest:request
                     withJSONCompletion:^(NSHTTPURLResponse *response, NSDictionary *data, NSError *connectionError) {

                         if (connectionError) {
                             
                             TEAL_LogVerbose(@"Profile Definitions Fetch Failed with response: %@, error: %@", response, [connectionError localizedDescription]);
                         }
                         completion( data, connectionError);
                     }];
}


@end
