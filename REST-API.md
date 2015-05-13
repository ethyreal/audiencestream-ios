# Audience Stream REST API

## Brief

This document specifies the existing REST infrastructure available by AudienceStream.

## Contents

* [Sending AudienceStream Data](#sending-audiencestream-data)
 * [POST Response](#post-response)
* [Retrieving AudienceStream Profile Data](#retrieving-audiencestream-profile-data)
 * [Profile Attributes](#profile-attributes)
* [Retrieving AudienceStream Profile Definitions](#retrieving-audiencestream-profile-definitions)
* [Routing Key](#routing-key)
 * [Queue Names](#queue-names)
 * [Mappings](#mappings)
 
## Sending AudienceStream Data

All AudienceStream data is sent to AudienceStream via ```GET``` to the address formatted as 

``` 
https://datacloud.tealiumiq.com/vdata/i.gif?tealium_account={account}&tealium_profile={profile}&{datasource_key}={datasource_value}
```


where:

* account 
 * e.g. *tealiummobile*
* profile
 * e.g. *demo*
* datasource_key
 * is any datasource key in the UDO
* datasource_value 
 * is any value string value for its corresponding key

Any number of datasource_key / datasource_value pairs can be added to the GET request as the playload for sent data.  
The the only caveat being "tealium_" prefixed will not count as playload data as those are reserved.

Old playload is here, we need to determine if event and post_time are reserved.

```javascript
{
	"loader.cfg" : {}, // No tag data; needs to be present but empty.
	"data" : {
		// The data
		"datasource-key" : "datasource-value",
		"cp.utag_main_v_id" : "<visitor id>" // If available
	},
	"event" : "view", // link or view
	"post_time":1420221541564 // ms since epoch
}
```

From more info see the [vData documentation on bloomfire](https://tealium.bloomfire.com/posts/861269).

### POST Response

When the ```POST``` is complete an ```i.gif``` is returned with headers such as 

```
Access-Control-Allow-Credentials:true
Access-Control-Allow-Origin:http://tags.tiqcdn.com
Cache-Control:no-transform,private,no-cache,no-store,max-age=0,s-maxage=0
Connection:keep-alive
Content-Length:43
Content-Type:image/gif
Date:Mon, 05 Jan 2015 16:08:50 GMT
Expires:Mon, 05 Jan 2015 16:08:50 GMT
P3P:policyref="/w3c/p3p.xml", CP="NOI DSP COR NID CUR ADM DEV OUR BUS"
Pragma:no-cache
Set-Cookie:TAPID=tealiummobile/demo>014aabdc8801000046512cc2abc70c077003e06f0093c|;Path=/;Expires=Wed, 13-Nov-2024 16:08:50 GMT
X-acc:tealiummobile:demo:2:datacloud
X-did:014aabdc8801000046512cc2abc70c077003e06f0093c
X-Region:us-west-1
X-ServerID:uconnect_i-0b241455
X-tid:014aabdc8801000046512cc2abc70c077003e06f0093c
X-ULVer:0.0.278-SNAPSHOT
X-UUID:21a2919c-bf58-4559-adff-fa765dc6a255
```

The ```X-tid``` is the visitor id and should be mapped to ```cp.utag_main_v_id``` for all succeeding POSTs.

## Retrieving AudienceStream Profile Data

To retieve visitor information a ```GET``` request must be sent to:

```http://visitor-service.tealiumiq.com/{account}/{profile}/{visitor id}```

where: 

* account 
 * e.g. *tealiummobile*
* profile
 * e.g. *demo*
* visitor id
 * The visitor id as provided by the ```X-tid``` header in the [POST Response](#post-response).

a JSON formatted response will be returned similar to:

```javascript
{ 
	"metrics" : { 
		"5117" : 6.0 , 
		"22" : 6.0
	} , 
	"dates" : { 
		"last_visit_start_ts" : 1420223771043
	} , 
	"properties" : { 
		"visitor_id" : "014aabdc8801000046512cc2abc70c077003e06f0093c" , 
		"17" : "http://tags.tiqcdn.com/utag/tealiummobile/demo/dev/mobile.html" , 
		"account" : "tealiummobile" , 
		"5123" : "set" , 
		"profile" : "demo"
	} , 
	"flags" : { 
		"5115" : true
	} , 
	"replaces" : [ ] , 
	"creation_ts" : 1420223770000 , 
	"_id" : "014aabdc8801000046512cc2abc70c077003e06f0093c" , 
	"secondary_ids" : { } , 
	"_secondary_ids" : [ ] , 
	"current_visit" : { 
		"metrics" : { 
			"7" : 6.0
		} , 
		"dates" : { 
			"last_event_ts" : 1420225387000
		} , 
		"properties" : { 
			"48" : "Chrome" , 
			"45" : "Mac OS X" , 
			"44" : "Chrome" , 
			"47" : "browser" , 
			"46" : "Mac desktop"
		} , 
		"flags" : { } , 
		"creation_ts" : 1420223770000 , 
		"_id" : "8f792139b13432cc1ab0569622302d71fa41cb9b10f41d6f69095637ae5df7cd" , 
		"_dc_ttl_" : 1800000 , 
		"total_event_count" : 12 , 
		"events_compressed" : false
	} , 
	"new_visitor" : true , 
	"bulk_import_data" : [ ] , 
	"badges" : { 
		"5113" : true // will never be false
	} , 
	"audiences" : { 
		"tealiummobile_demo_101" : "Sample Audience"
	}
}
```

### Profile Attributes

*NOTE: Ids above 5000 are custom.*

* *audiences*
 * **key** : Audiennce Attribute Id
 * **value** : Audience Name.
* *badges*
 * **key** : Badge Attribute Id
 * **value** : always true, it's significance is its presance, not it's value.
* *dates*
 * **key** : Date Attribute Id
 * **value** : timestamp in ms since epoch.
* *flags*
 * **key** : Flag Attribute Id
 * **value** : boolean whether the flag is raised.
* *funnels* **REMOVED**
* *metric_sets* (AKA Tallies) **REMOVED**
* *metrics*
 * **key** : Metric Attribute Id
 * **value** : double value.
* *properties* (AKA Trait)
 * **key** : Trait Attribute Id
 * **value** : String value.
* *property_sets* (AKA List) **REMOVED**
* *sequences* (AKA Timeline) **REMOVED**
* *shard_token* **REMOVED**

## Retrieving AudienceStream Profile Definitions

To find definitions for things such as badges and audiences, send a ```GET``` request to:

```http://visitor-service.tealiumiq.com/datacloudprofiledefinitions/{ account }/{ profile }```

where: 

* account 
 * e.g. *tealiummobile*
* profile
 * e.g. *demo*

A JSON-formatted response will be returned such as:

```javascript
{ 
	"audiences" : [ 
	{ 
		"id" : 
		"tealiummobile_demo_101" , 
		"name" : "Sample Audience"
	}
	] , 
	"badges" : [ 
	{ 
		"id" : 5113 , 
		"name" : "Sample Badge"
	} , { 
		"id" : 32 , 
		"name" : "Unbadged"
	} , { 
		"id" : 31 , 
		"name" : "Frequent visitor"
	} , { 
		"id" : 30 , 
		"name" : "Fan"
	}
	]
}
```

## Routing Key

This is the SI values

### Queue Names

* D = Diagnostic
* C = Data Cloud
* L = Logger (uConnect)
* S = Server2Server
* _ = a space

### Mappings

*  0 = ```____```
*  1 = ```D___```
*  2 = ```_C__```
*  3 = ```DC__```
*  4 = ```__L_```
*  5 = ```D_L_```
*  6 = ```_CL_```
*  7 = ```DCL_```
*  8 = ```___S```
*  9 = ```D__S```
* 10 = ```_C_S```
* 11 = ```DC_S```
* 12 = ```__LS```
* 13 = ```D_LS```
* 14 = ```_CLS```
* 15 = ```DCLS```
