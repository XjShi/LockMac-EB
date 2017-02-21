//
//  LockService.m
//  LockMac
//
//  Created by xjshi on 21/02/2017.
//  Copyright © 2017 sxj. All rights reserved.
//

#import "LockService.h"

@implementation LockService

// http://stackoverflow.com/questions/11505255/osx-check-if-the-screen-is-locked
+ (BOOL)isScreenLocked {
    BOOL locked = NO;
    CFDictionaryRef CGSessionCurrentDictionary = CGSessionCopyCurrentDictionary();
    id result = [(__bridge NSDictionary*)CGSessionCurrentDictionary objectForKey:@"CGSSessionScreenIsLocked"];
    if (result) {
        locked = [result boolValue];
    }
    CFRelease(CGSessionCurrentDictionary);
    return locked;
}

+ (void)lock {
    if ([self isScreenLocked]) {
        return;
    }
    io_registry_entry_t entry = IORegistryEntryFromPath(kIOMasterPortDefault, "IOService:/IOResources/IODisplayWrangler");
    if (entry) {
        IORegistryEntrySetCFProperty(entry, CFSTR("IORequestIdle"), kCFBooleanTrue);
        IOObjectRelease(entry);
    }
}

+ (void)unlock
{
    if (![self isScreenLocked]) {
        return;
    }
    io_registry_entry_t entry = IORegistryEntryFromPath(kIOMasterPortDefault, "IOService:/IOResources/IODisplayWrangler");
    if (entry) {
        IORegistryEntrySetCFProperty(entry, CFSTR("IORequestIdle"), kCFBooleanFalse);
        IOObjectRelease(entry);
    }
}

@end
