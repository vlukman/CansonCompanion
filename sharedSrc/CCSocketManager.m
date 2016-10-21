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

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        _url = url;
        self.webSocket = [[SRWebSocket alloc] initWithURL:url];
        self.webSocket.delegate = self;
    }
    return self;
}

- (void)connect {
    [self.webSocket open];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"Websocket received message");
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"Websocket Connected");
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"Websocket Fail with error %@", error.description);
}

- (void)webSocket:(SRWebSocket *)webSocket
 didCloseWithCode:(NSInteger)code
           reason:(NSString *)reason
         wasClean:(BOOL)wasClean
{
    NSLog(@"Websocket didClose code: %zd | reason %@ | wasClean %i", code, reason, wasClean);
}


@end
