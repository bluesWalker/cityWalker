//
//  Coordinate.h
//  cityWalker
//
//  Created by bluesWalker on 7/24/14.
//  Copyright (c) 2014 Newcastle University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coordinate : NSObject

@property (readonly) double  latitude;
@property (readonly) double longitude;

- (id)initWithLatitude:(double)latitude Longitude:(double)longitude;

@end
