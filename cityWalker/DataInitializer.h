//
//  DataInitializer.h
//  cityWalker
//
//  Created by bluesWalker on 7/28/14.
//  Copyright (c) 2014 Newcastle University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface DataInitializer : NSObject

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) NSManagedObjectContext *context;

- (id)initWithManagedObjectContext;
- (void)initializeBusStops;
- (void)initializeBusRoutes;
- (bool)checkDatabase;

@end
