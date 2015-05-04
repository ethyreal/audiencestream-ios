//
//  TEALNetworkHelpers.m
//  AudienceStream Library
//
//  Created by George Webster on 12/29/14.
//  Copyright (c) 2014 Tealium Inc. All rights reserved.
//

#import "TEALNetworkHelpers.h"

@implementation TEALNetworkHelpers


#pragma mark - URL helpers

+ (NSString *) urlParamStringFromDictionary:(NSDictionary *)data {

    NSMutableArray *paramArray = [NSMutableArray array];
    
    [data enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        NSString *escapedValue = [self percentEscapeURLParameter:obj];
        NSString *paramStr = [NSString stringWithFormat:@"%@=%@", key, escapedValue];
        [paramArray addObject:paramStr];
    }];
    
    return [paramArray componentsJoinedByString:@"&"];
}

+ (NSString *) appendUrlParamString:(NSString *)urlString withDictionary:(NSDictionary *)data {
    
    NSString *stringToAppend = [TEALNetworkHelpers urlParamStringFromDictionary:data];
    
    return [urlString stringByAppendingFormat:@"&%@", stringToAppend];
}

+ (NSString *) percentEscapeURLParameter:(NSString *)string {
    
    return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                     (CFStringRef)string,
                                                                     NULL,
                                                                     (CFStringRef)@":/?@!$&'()*+,;=",
                                                                     kCFStringEncodingUTF8));
}

+ (NSURLRequest *) requestWithURLString:(NSString *)urlString {
    
    if (!urlString) {
        return nil;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    return [TEALNetworkHelpers requestWithURL:url];
}

+ (NSURLRequest *) requestWithURL:(NSURL *)url {

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPShouldHandleCookies = NO;
    
    return request;
}

+ (NSURLRequest *) requestWithURLString:(NSString *)urlString
                                 method:(NSString *)methodString
                                   body:(NSData *)bodyData {
    
    if (!urlString) {
        return nil;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];

    NSMutableURLRequest *request = [NSMutableURLRequest new];

    request.URL         = url;
    request.HTTPMethod  = methodString;
    request.HTTPBody    = bodyData;
    
    request.HTTPShouldHandleCookies = NO;
    
    return request;
}

+ (NSString *) eventStringFromType:(TEALEventType)eventType {
    
    NSString *eventString = nil;
    
    switch (eventType) {
        case TEALEventTypeLink:
            eventString = TEALEventTypeLinkStringValue;
            break;
        case TEALEventTypeView:
            eventString = TEALEventTypeViewStringValue;
        default:
            break;
    }
    return eventString;
}

@end
