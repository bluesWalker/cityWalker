//
//  HTTPRequestHandler.m
//  cityWalker
//
//  Created by bluesWalker on 7/28/14.
//  Copyright (c) 2014 Newcastle University. All rights reserved.
//

#import "HTTPRequestHandler.h"

#define REQUEST_TIMEOUT_INTERVAL 10

@implementation HTTPRequestHandler

- (id)initWithURL:(NSString *) urlString {
    
    if (self = [super init]) {
        _url = [NSURL URLWithString:urlString];
    }
    return self;
}

- (NSString *)requestData {
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:_url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:REQUEST_TIMEOUT_INTERVAL];
    
    NSData *recievedData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *dataString = [[NSString alloc] initWithData:recievedData encoding:NSUTF8StringEncoding];
    
    return dataString;
}


@end
