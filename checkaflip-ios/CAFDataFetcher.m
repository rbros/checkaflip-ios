//
//  CAFDataFetcher.m
//  checkaflip-ios
//
//  Created by caf on 12/1/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "CAFDataFetcher.h"
#import "CAFEbayDataFetcher.h"
#import "CAFEbaySearchResult.h"
#import "CAFCraigslistSearchResult.h"

NSString* cafurl = @"http://checkaflip.com/";

@implementation CAFDataFetcher
{
    NSString* _currentKey;
    BOOL _currentNew;
    CAFEbaySearchResult* _ebaysr;
    CAFCraigslistSearchResult* _clsr;
    CLLocationManager* lm;
}

- (id) init
{
    self = [super self];
    if (self) {

        lm = [[CLLocationManager alloc] init];
        lm.distanceFilter = kCLDistanceFilterNone;
        lm.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        [lm startUpdatingLocation];
        
        NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
        [prefs addObserver:self forKeyPath:@"cl_manual_city"
                   options:NSKeyValueObservingOptionNew context:nil];

        if ([prefs boolForKey:@"cl_manual_city"])
            [lm stopUpdatingLocation];
    }
    return self;
}

- (void) observeValueForKeyPath:(NSString*) keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"cl_manual_city"])
        [lm startUpdatingLocation];
    else
        [lm stopUpdatingLocation];
}

- (void) search:(NSString*) key :(BOOL) n
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SEARCH_START" object:self];

    _currentKey = key;
    _currentNew = n;

    NSString* quotedkey = [key stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    // set list loading icon.
    NSOperationQueue* opq = [[NSOperationQueue alloc] init];
    [opq addOperationWithBlock:^{

        _ebaysr = [CAFDataFetcher searchEbay:quotedkey:n];

        NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
        BOOL manual = [prefs boolForKey:@"cl_manual_city"];
    
        NSString* city = @"wichita";
        if (manual)
            city = [prefs objectForKey:@"cl_city_name"];
        else {
            // get location by gps.
            city = self.getCityFromLocation;
        }

        _clsr = [CAFDataFetcher searchCraigslist:quotedkey:n:city:[_ebaysr getCompletedValue]];

        [[NSNotificationCenter defaultCenter] postNotificationName:@"SEARCH_COMPLETE" object:nil];
    }];
}

+ (CAFEbaySearchResult*)searchEbay:(NSString*) key:(BOOL)new
{
    
    NSString* usedornew = @"false";
    if (new)
        usedornew = @"true";

    NSString* server = [NSString stringWithFormat:@"%@searchEbay/?q=%@&new=%@&json=true", cafurl, key, usedornew];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:server] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    [request setHTTPMethod:@"GET"];
    
    NSError* error;
    NSURLResponse* response = nil;
    
    NSData* json = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error)
        return nil;
    
    return [[CAFEbaySearchResult alloc] initWithJSONData:json];
}

+ (CAFCraigslistSearchResult*)searchCraigslist:(NSString*) key:(BOOL)new :(NSString*)city:(NSString*)ebayAvg
{
    
    NSString* usedornew = @"false";
    if (new)
        usedornew = @"true";
    
    NSString* l = [NSString stringWithFormat:@"%@", nil];
    NSString* server = [NSString stringWithFormat:@"%@searchCraigslist/?q=%@&new=%@&city=%@&json=true", cafurl, key, usedornew, city];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:server]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    [request setHTTPMethod:@"GET"];
    
    NSError* error;
    NSURLResponse* response = nil;
    
    NSData* json = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error)
        return nil;

    return [[CAFCraigslistSearchResult alloc] initWithJSONData:json:ebayAvg];
}

- (NSString*) getCityFromLocation
{
    NSString* city = nil;
    
    NSString* lat = @"33.748995";
    NSString* lon = @"-84.387982";
    
    lat = [NSString stringWithFormat:@"%f", lm.location.coordinate.latitude];
    lon = [NSString stringWithFormat:@"%f", lm.location.coordinate.longitude];
    
    NSString* server = [NSString stringWithFormat:@"%@getcity/?lat=%@&lon=%@", cafurl, lat, lon];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:server]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    [request setHTTPMethod:@"GET"];
    
    NSError* error;
    NSURLResponse* response = nil;
    
    NSData* html = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString* data = [NSString stringWithUTF8String:[html bytes]];
    
    NSScanner* scanner = [NSScanner scannerWithString:data];
    [scanner scanUpToString:@"value=\"" intoString:nil];
    [scanner scanUpToString:@"\">" intoString:&city];
    
    city = [city substringFromIndex:7];

    // Logic could be improved. Possibly pull this value from
    // prefs on error.
    if (!city || [city length] == 0)
        city = @"wichita";

    return city;
}

- (NSString*) getCurrentSearchKey
{
    return _currentKey;
}

- (void) setCurrentSearchKey:(NSString *)key
{
    _currentKey = key;
}

- (void) setNew:(BOOL)n
{
    _currentNew = n;
}

- (BOOL) getNew
{
    return _currentNew;
}

- (CAFEbaySearchResult*) getEbaySearchResult
{
    return _ebaysr;
}

- (CAFCraigslistSearchResult*) getCraigslistSearchResult
{
    return _clsr;
}

@end
