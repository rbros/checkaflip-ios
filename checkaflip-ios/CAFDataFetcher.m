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
    _currentKey = key;
    _currentNew = n;

    _ebaysr = [CAFDataFetcher searchEbay:key:n];

    NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
    BOOL manual = [prefs boolForKey:@"cl_manual_city"];
    
    NSString* city = @"wichita";
    if (manual)
        city = [prefs objectForKey:@"cl_city_name"];
    else {
        // get location by gps.
        city = self.getCityFromLocation;
    }

    _clsr = [CAFDataFetcher searchCraigslist:key:n:city];
}

+ (CAFEbaySearchResult*)searchEbay:(NSString*) key:(BOOL)new
{
    NSString* server = [NSString stringWithFormat:@"%@searchEbay/?q=%@&new=false&json=true", cafurl, key];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:server]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    [request setHTTPMethod:@"GET"];
    
    NSError* error;
    NSURLResponse* response = nil;
    
    NSData* json = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error)
        return nil;
    
    return [[CAFEbaySearchResult alloc] initWithJSONData:json];
}

+ (CAFCraigslistSearchResult*)searchCraigslist:(NSString*) key:(BOOL)new :(NSString*)city
{
    NSString* server = [NSString stringWithFormat:@"http://checkaflip.com/searchCraigslist/?q=%@&new=false&city=%@&json=true", key, city];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:server]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    [request setHTTPMethod:@"GET"];
    
    NSError* error;
    NSURLResponse* response = nil;
    
    NSData* json = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error)
        return nil;

    return [[CAFCraigslistSearchResult alloc] initWithJSONData:json];
}

- (NSString*) getCityFromLocation
{
    NSString* city = nil;
    
    NSString* lat = @"33.748995";
    NSString* lon = @"-84.387982";
    
    lat = [NSString stringWithFormat:@"%f", lm.location.coordinate.latitude];
    lon = [NSString stringWithFormat:@"%f", lm.location.coordinate.longitude];
    
    NSString* server = [NSString stringWithFormat:@"http://checkaflip.com/getcity/?lat=%@&lon=%@", lat, lon];
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
