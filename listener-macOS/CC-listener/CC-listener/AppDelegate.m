//
//  AppDelegate.m
//  CC-Listener
//
//  Created by Vera Lukman on 2016-10-20.
//  Copyright © 2016 Vera Lukman. All rights reserved.
//

#import "AppDelegate.h"
#import "CCSocketManager.h"

@interface AppDelegate () <CCSocketManagerDelegate>

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic) CCSocketManager *socketManager;
@property (nonatomic) NSSound *knockingSound;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.knockingSound = [NSSound soundNamed:@"three_knocks_on_wood_door"];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000"];
    self.socketManager = [[CCSocketManager alloc] initWithURL:url andDelegate:self];
    [self.socketManager connect];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    [self.socketManager disconnect];
}

#pragma mark - CCSocketManagerDelegate
- (void)didReceiveKnock {
    NSLog(@"Play Sound");
    // play sound
    
    if (!self.knockingSound.isPlaying) {
        [self.knockingSound play];
    }
}

- (void)didConnect {
    // identify as listener app
    [self.socketManager sendMessage:@"listener"];
}
@end
