//
//  Coordinate.m
//  cityWalker
//
//  Created by bluesWalker on 7/24/14.
//  Copyright (c) 2014 Newcastle University. All rights reserved.
//

#import "Coordinate.h"

@implementation Coordinate

- (id)initWithLatitude:(double)latitude Longitude:(double)longitude {
    if (self = [super init]) {
        _latitude = latitude;
        _longitude = longitude;
    }
    return self;
}

@end
