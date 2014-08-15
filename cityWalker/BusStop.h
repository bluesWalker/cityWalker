//
//  BusStop.h
//  cityWalker
//
//  Created by bluesWalker on 8/14/14.
//  Copyright (c) 2014 Newcastle University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BusRoute;

@interface BusStop : NSManagedObject

@property (nonatomic, retain) NSNumber * heading;
@property (nonatomic, retain) NSNumber * isVirtualStop;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * stopArea;
@property (nonatomic, retain) NSString * stopCode;
@property (nonatomic, retain) NSString * stopCodeLBSL;
@property (nonatomic, retain) NSString * stopName;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *busRoutes;
@end

@interface BusStop (CoreDataGeneratedAccessors)

- (void)addBusRoutesObject:(BusRoute *)value;
- (void)removeBusRoutesObject:(BusRoute *)value;
- (void)addBusRoutes:(NSSet *)values;
- (void)removeBusRoutes:(NSSet *)values;

@end
