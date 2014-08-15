//
//  BusRoute.h
//  cityWalker
//
//  Created by bluesWalker on 8/14/14.
//  Copyright (c) 2014 Newcastle University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BusStop;

@interface BusRoute : NSManagedObject

@property (nonatomic, retain) NSNumber * direction;
@property (nonatomic, retain) NSString * serviceNo;
@property (nonatomic, retain) NSOrderedSet *busStops;
@end

@interface BusRoute (CoreDataGeneratedAccessors)

- (void)insertObject:(BusStop *)value inBusStopsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromBusStopsAtIndex:(NSUInteger)idx;
- (void)insertBusStops:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeBusStopsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInBusStopsAtIndex:(NSUInteger)idx withObject:(BusStop *)value;
- (void)replaceBusStopsAtIndexes:(NSIndexSet *)indexes withBusStops:(NSArray *)values;
- (void)addBusStopsObject:(BusStop *)value;
- (void)removeBusStopsObject:(BusStop *)value;
- (void)addBusStops:(NSOrderedSet *)values;
- (void)removeBusStops:(NSOrderedSet *)values;
@end
