//
//  CoordinatesConvertor.h
//  cityWalker
//
//  Created by bluesWalker on 7/24/14.
//  Copyright (c) 2014 Newcastle University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoordinatesConvertor : NSObject

- (Coordinate *)toWGS84FromEasting:(double)easting Northing:(double)northing;

@end
