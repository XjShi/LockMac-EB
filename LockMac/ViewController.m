//
//  ViewController.m
//  LockMac
//
//  Created by xjshi on 21/02/2017.
//  Copyright © 2017 sxj. All rights reserved.
//

#import "ViewController.h"
#import "BLEService.h"

@interface ViewController ()

@property (strong) BLEService *service;
@property (weak) IBOutlet NSTextField *modelNameTextField;
@property (weak) IBOutlet NSButton *doneButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)lock:(NSButton *)sender {
    NSString *str = self.modelNameTextField.stringValue;
    if (str.length == 0) {
        return;
    }
    self.service = [[BLEService alloc] initWithiDeviceModelName:str];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
