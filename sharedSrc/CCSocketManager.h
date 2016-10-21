//
//  CCSocketManager.h
//  CC-Listener
//
//  Created by Vera Lukman on 2016-10-20.
//  Copyright © 2016 Vera Lukman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketRocket/SocketRocket.h>

typedef enum {
    CCSocketStatusConnected,
    CCSocketStatusConnecting,
    CCSocketStatusDisconnected,
} CCSocketStatus;

@protocol CCSocketManagerDelegate <NSObject>
@optional
- (void)didReceiveKnock;
- (void)didConnect;
- (void)didDisconnect:(NSError *)error;
@end

@interface CCSocketManager : NSObject <SRWebSocketDelegate>

@property (nonatomic, readonly) NSURL* url;
@property (nonatomic, readonly) CCSocketStatus socketStatus;
@property (nonatomic, weak, readonly) id <CCSocketManagerDelegate> delegate;

- (instancetype)initWithURL:(NSURL *)url andDelegate:(id <CCSocketManagerDelegate>)delegate;
- (void)connect;
- (void)disconnect;

- (void)sendKnock;
- (void)sendMessage:(NSString *)message;

@end
