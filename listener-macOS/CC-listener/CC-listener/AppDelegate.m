//
//  AppDelegate.m
//  CC-Listener
//
//  Created by Vera Lukman on 2016-10-20.
//  Copyright © 2016 Vera Lukman. All rights reserved.
//

#import "AppDelegate.h"
#import "CCSocketManager.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic) CCSocketManager *socketManager;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000"];
    self.socketManager = [[CCSocketManager alloc] initWithURL:url];
    [self.socketManager connect];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
