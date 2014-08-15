//
//  DataInitializer.m
//  cityWalker
//
//  Created by bluesWalker on 7/28/14.
//  Copyright (c) 2014 Newcastle University. All rights reserved.
//

#import "DataInitializer.h"
#import "HTTPRequestHandler.h"

#define BUS_STOP_FETCH_URL @"http://data.tfl.gov.uk/tfl/syndication/feeds/bus-stops.csv?app_id=0830d3b7&app_key=e3d4f6e9aa283083a46e888437ef8773"

@implementation DataInitializer

- (id)initWithManagedObjectContext {
    
    if (self = [super init]) {
        _appDelegate = [[UIApplication sharedApplication] delegate];
        _context = [_appDelegate managedObjectContext];
    }
    
    return self;
    
}

- (void)initializeBusStops {
    
    NSString *fetchURL = BUS_STOP_FETCH_URL;
    HTTPRequestHandler *requestHandler = [[HTTPRequestHandler alloc] initWithURL:fetchURL];
    
    
}

- (void)initializeBusRoutes {
    
    
    
}

- (bool)checkDatabase {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"BusStop"];
    //This statement here is actually checking if the database is empty or not
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"busStopCode = %@", @"490000266G"];
    
    NSError *error;
    
    return false;
}

@end
