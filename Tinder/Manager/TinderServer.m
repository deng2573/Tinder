////
////  TinderServer.m
////  Tinder
////
////  Created by Deng on 2019/8/2.
////  Copyright © 2019 Deng. All rights reserved.
////
//
//#import "TinderServer.h"
//
//@implementation TinderServer
//
//@dynamic delegate;
//
//- (instancetype)initWithUploadDirectory:(NSString *)path {
//  if (self = [super initWithUploadDirectory:path]) {
//    self.connectionArray = [[NSMutableArray alloc] init];
//  }
//  return self;
//}
//
////- (BOOL)start {
////  NSMutableDictionary* options = [NSMutableDictionary dictionary];
////  [options setObject:[NSNumber numberWithInteger:8080] forKey:GCDWebServerOption_Port];
////  [options setValue:@"" forKey:GCDWebServerOption_BonjourName];
////  [options setValue:@"GCDWebServerConnection" forKey:GCDWebServerOption_ConnectionClass];
////  return [self startWithOptions:options error:NULL];
////}
////
////- (void)willStartConnection:(TinderConnection *)connection {
////  [super willStartConnection:connection];
////  self.currentConnection = connection;
////  [self.connectionArray addObject:connection];
////  [connection addObserver:self forKeyPath:@"_totalBytesRead" options:NSKeyValueObservingOptionNew context:nil];
////}
////
////- (void)didEndConnection:(TinderConnection *)connection {
////  [super didEndConnection:connection];
//////  [self.connectionArray removeObject:connection];
////}
//- (void)dealloc
//{
//  for (GCDWebServerConnection * con in self.connectionArray ){
//    [con removeObserver:self forKeyPath:@"totalBytesRead" context:nil];
//  }
//}
//
//
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//  TinderConnection * connection = (TinderConnection *)object;
//  if ([self.delegate respondsToSelector:@selector(connection:receivedBytes:)]) {
//    dispatch_async(dispatch_get_main_queue(), ^{
//      [self.delegate connection:connection receivedBytes:connection.totalBytesRead];
//    });
//  }
//}
//
//@end
//
//@implementation TinderConnection
//
//- (instancetype)initWithServer:(GCDWebServer *)server localAddress:(NSData *)localAddress remoteAddress:(NSData *)remoteAddress socket:(CFSocketNativeHandle)socket {
//  if (self = [super initWithServer:server localAddress:localAddress remoteAddress:remoteAddress socket:socket]){
//    self.uuid = [TinderConnection uuidString];
//  }
//
//  return self;
//
//}
//
//+ (NSString *)uuidString {
//  CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
//  CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
//  NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
//  CFRelease(uuid_ref);
//  CFRelease(uuid_string_ref);
//  return [uuid lowercaseString];
//}
//
//@end
