//
//  TinderServer.h
//  Tinder
//
//  Created by Deng on 2019/8/2.
//  Copyright © 2019 Deng. All rights reserved.
//

#import <GCDWebServer/GCDWebServer.h>
#import "GCDWebUploader.h"
#import <GCDWebServer/GCDWebServerPrivate.h>
NS_ASSUME_NONNULL_BEGIN
@class TinderConnection;
@protocol TinderServerDelegate <GCDWebUploaderDelegate>
@optional

- (void)connection:(TinderConnection *)connection receivedBytes:(NSUInteger)count;

@end

@interface TinderServer : GCDWebUploader

@property(nonatomic, weak, nullable) id<TinderServerDelegate> delegate;

@property(nonatomic, strong) GCDWebServerConnection* currentConnection;

@property(nonatomic, strong) NSMutableArray<GCDWebServerConnection *> *connectionArray;

@end

@interface TinderConnection : GCDWebServerConnection

@property(nonatomic, copy) NSString * uuid;

@end



NS_ASSUME_NONNULL_END


