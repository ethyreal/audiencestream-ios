# audiencestream-ios

An [AudienceStream](http://tealium.com/products/audiencestream/) library for iOS.

- [Requirements](#requirements)
- [Quick Start](#quick-start)
    - [1. Clone/Copy Library](#1-clonecopy-library)
    - [2. Add to Project](#2-add-to-project)
    - [3. Link Frameworks](#3-link-frameworks)
    - [4. Add Linker Flags](#4-add-linker-flags)
    - [5. Import Headers](#5-import-headers)
	- [6. Enable with Configuration](#6-enable-with-configuration)
    - [7. Send Events to AudienceStream](#7-send-events-to-audiencestream)
    - [8. Access the enriched profile from AudienceStream](#8-access-the-enriched-profile-from-audienceatream)

###Requirements###

- [XCode (6.0+ recommended)](https://developer.apple.com/xcode/downloads/)
- Minimum target iOS Version 7.0+

###Quick Start###
This is a walk through of setting up a simple project to use the AudienceStream(http://tealium.com/products/audiencestream/) iOS library.
	
####1. Clone/Copy Library####
Copy or clone the library repo onto your dev machine by clicking on the *Clone to Desktop* or *Download ZIP* buttons on the main repo page.

####2. Add Tealium Framworks To Project 

From the *audiencestream-ios/Release* folder, drag & drop the *TealiumUtilities* and *TEALAudienceStream* frameworks into your XCode project's Navigation window.

####3. Link Frameworks
[Link the following Apple framework](https://developer.apple.com/library/ios/recipes/xcode_help-project_editor/Articles/AddingaLibrarytoaTarget.html) to your project:

- SystemConfiguration

####4. Add Linker Flags
Add the "-ObjC" linker flag to your project's Target-Build Settings.

####5. Import Headers

##### Objective-C
For Objective-C import the library at the top of any file you wish to access the library in:
  
```objective-c
#import <TEALAudienceStream/TEALAudienceStream.h>
```
##### Swift

In swift you'll need to Update your project's Objective-C bridging header or create one with the following entries:

```objective-c
#import <TEALAudienceStream/TEALAudienceStream.h>
#import <TEALAudienceStream/TEALAudienceStreamConfiguration.h>
#import <TEALAudienceStream/TEALProfile.h>
#import <TEALAudienceStream/TEALEvent.h>
```

####6. Enable with Configuration

Then enable the library with a ```TEALAudienceStreamConfiguration``` instance in your appDelegate class:

##### Objective-C

```objective-c
- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    TEALAudienceStreamConfiguration *config = [TEALAudienceStreamConfiguration configurationWithAccount:@"tealiummobile"
                                                                                                profile:@"demo"
                                                                                            environment:@"dev"];

    config.logLevel = TEALAudienceStreamLogLevelVerbose;

    [TEALAudienceStream enableWithConfiguration:config];
    
    return YES;
}
```

##### Swift

```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    let configuration = TEALAudienceStreamConfiguration(account: "tealiummobile", profile: "demo", environment: "dev")
    
    configuration.logLevel = TEALAudienceStreamLogLevel.Verbose
    
    TEALAudienceStream.enableWithConfiguration(configuration)

    return true
}
```

####7. Send Events to AudienceStream

Send Events to AudienceStream using the ```sendEvent:withData``` method:

##### Objective-C

```objective-c
- (void) sendLifecycleEventWithName:(NSString *)eventName {

    NSDictionary *data = @{@"event_name" : eventName};
    
    [TEALAudienceStream sendEvent:TEALEventTypeLink
                         withData:data];

}
```
##### Swift

```swift
func sendLifecycleEventWithName(name: String) {
    
    let data: [String: String] = ["event_name" : name]
    
    TEALAudienceStream.sendEvent(TEALEventType.Link, withData: data)
}
```

####8. Access the enriched profile from AudienceStream

