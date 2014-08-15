//
//  HTTPRequestHandler.h
//  cityWalker
//
//  Created by bluesWalker on 7/28/14.
//  Copyright (c) 2014 Newcastle University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPRequestHandler : NSObject

@property (strong, nonatomic) NSURL *url;

- (id)initWithURL:(NSString *) urlString;
- (NSString *)requestData;

@end
