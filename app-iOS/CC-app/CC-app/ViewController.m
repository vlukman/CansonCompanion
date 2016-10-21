//
//  ViewController.m
//  CC-app
//
//  Created by Vera Lukman on 2016-10-20.
//  Copyright © 2016 Vera Lukman. All rights reserved.
//

#import "ViewController.h"
#import "CCSocketManager.h"

@interface ViewController () <CCSocketManagerDelegate>
@property (nonatomic) CCSocketManager *socketManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000"];
    self.socketManager = [[CCSocketManager alloc] initWithURL:url andDelegate:self];
    [self.socketManager connect];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.socketManager disconnect];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didSelectKnock:(id)sender {
    [self.socketManager sendKnock];
}

#pragma mark - CCSocketManagerDelegate


@end
