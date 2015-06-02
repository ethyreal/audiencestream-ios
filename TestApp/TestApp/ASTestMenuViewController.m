//
//  ViewController.m
//  ASTester
//
//  Created by George Webster on 3/9/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import "ASTestMenuViewController.h"
#import <TealiumConnectLibrary/TealiumConnect.h>

typedef NS_ENUM(NSUInteger, ASTestMenuItem) {
    ASTestMenuItemSendEventLink = 0,
    ASTestMenuItemSendEventView,
    ASTestMenuItemFetchProfle,
    ASTestMenuItemLogLastProfile,
    ASTestMenuItemNumberOfItems
};

@interface ASTestMenuViewController ()

@end

@implementation ASTestMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ASTestMenuItemNumberOfItems;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASMenuCellIdentifier"];
    
    if (cell) {
        switch (indexPath.row) {
            case ASTestMenuItemSendEventLink:
                cell.textLabel.text = @"Send Track Link Event";
                break;
            case ASTestMenuItemSendEventView:
                cell.textLabel.text = @"Send Track View Event";
                break;

            case ASTestMenuItemFetchProfle:
                cell.textLabel.text = @"Fetch Current Profile";
                break;
            case ASTestMenuItemLogLastProfile:
                cell.textLabel.text = @"Log Last Loaded Profile";
                break;
                
            default:
                break;
        }

    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case ASTestMenuItemSendEventLink:
            [self sendAudienceStreamLinkEvent];
            break;
        case ASTestMenuItemSendEventView:
            [self sendAudienceStreamViewEvent];
            break;
        case ASTestMenuItemFetchProfle:
            [self fetchAudienceStreamProfile];
            break;
        case ASTestMenuItemLogLastProfile:
            [self accessLastLoadedAudienceStreamProfile];
            break;
        default:
            break;
    }
}


- (void) sendAudienceStreamViewEvent {
    
    NSDictionary *data = @{ @"event_name" : @"m_view"};
    
    [TealiumConnect sendViewWithData:data];
}

- (void) sendAudienceStreamLinkEvent {
    
    NSDictionary *data = @{ @"event_name" : @"m_link"};
    
    [TealiumConnect sendEventWithData:data];
}

- (void) fetchAudienceStreamProfile {
    
    [TealiumConnect fetchVisitorProfileWithCompletion:^(TEALVisitorProfile *profile, NSError *error) {
       
        if (error) {
            NSLog(@"test app failed to receive profile with error: %@", [error localizedDescription]);
        } else {
            NSLog(@"test app received profile: %@", profile);
        }
        
    }];
}

- (void) accessLastLoadedAudienceStreamProfile {

    TEALVisitorProfile *profile = [TealiumConnect cachedVisitorProfileCopy];

    if (profile) {
        NSLog(@"last loaded profile: %@", profile);
    } else {
        NSLog(@"a valid profile has not been received yet.");
    }
}

- (void) presentTraceInputView {
    
}

- (void) joinTraceWithToken:(NSString *)token {
    
    [TealiumConnect joinTraceWithToken:token];
}

- (void) leaveTrace {
    [TealiumConnect leaveTrace];
}

@end
