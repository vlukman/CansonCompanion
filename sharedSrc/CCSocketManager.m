//
//  CCSocketManager.m
//  CC-Listener
//
//  Created by Vera Lukman on 2016-10-20.
//  Copyright © 2016 Vera Lukman. All rights reserved.
//

#import "CCSocketManager.h"
#import <SocketRocket/SocketRocket.h>

@interface CCSocketManager()
@property (nonatomic) SRWebSocket *webSocket;
@end

@implementation CCSocketManager

#pragma mark - SRWebSocketDelegate

- (instancetype)initWithURL:(NSURL *)url andDelegate:(id <CCSocketManagerDelegate>)delegate; {
    self = [super init];
    if (self) {
        _url = url;
        self.webSocket = [[SRWebSocket alloc] initWithURL:url];
        self.webSocket.delegate = self;
        _socketStatus = CCSocketStatusDisconnected;
        _delegate = delegate;
    }
    return self;
}

- (void)connect {
    @synchronized(self) {
        if (_socketStatus == CCSocketStatusDisconnected) {
            _socketStatus = CCSocketStatusConnecting;
            [self.webSocket open];
        }
    }
}

- (void)disconnect {
    @synchronized(self) {
        if (_socketStatus == CCSocketStatusConnected) {
        _socketStatus = CCSocketStatusDisconnected;
        [self.webSocket close];
        }
    }
}

- (void)sendKnock {
    [self sendMessage:@"knock"];
}

- (void)sendMessage:(NSString *)message {
    BOOL shouldSendKnock = NO;
    @synchronized(self) {
        shouldSendKnock = self.socketStatus == CCSocketStatusConnected;
    }
    if (shouldSendKnock) {
        [self.webSocket send:message];
        NSLog(@"Sending message %@", message);
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(NSString*)message {
    NSLog(@"Websocket received message %@", message);
    
    if ([message isEqualToString:@"knock"]) {
        if ([self.delegate respondsToSelector:@selector(didReceiveKnock)]) {
            [self.delegate didReceiveKnock];
        }
    }
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    @synchronized(self) {
        _socketStatus = CCSocketStatusConnected;
    }
    NSLog(@"Websocket Connected");
    if ([self.delegate respondsToSelector:@selector(didConnect)]) {
        [self.delegate didConnect];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    @synchronized(self) {
        _socketStatus = CCSocketStatusDisconnected;
    }
    NSLog(@"Websocket Fail with error %@", error.description);
    if ([self.delegate respondsToSelector:@selector(didDisconnect:)]) {
        [self.delegate didDisconnect:error];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket
 didCloseWithCode:(NSInteger)code
           reason:(NSString *)reason
         wasClean:(BOOL)wasClean
{
    @synchronized(self) {
        _socketStatus = CCSocketStatusDisconnected;
    }
    // TODO: vlukman handle this error please
    NSError * error = nil;
    if ([self.delegate respondsToSelector:@selector(didDisconnect:)]) {
        [self.delegate didDisconnect:error];
    }
    NSLog(@"Websocket didClose code: %zd | reason %@ | wasClean %i", code, reason, wasClean);
}


@end
