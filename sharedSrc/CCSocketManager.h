//
//  CCSocketManager.h
//  CC-Listener
//
//  Created by Vera Lukman on 2016-10-20.
//  Copyright © 2016 Vera Lukman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketRocket/SocketRocket.h>

@interface CCSocketManager : NSObject <SRWebSocketDelegate>

@property (nonatomic, readonly) NSURL* url;

- (instancetype)initWithURL:(NSURL *)url;
- (void)connect;

@end
