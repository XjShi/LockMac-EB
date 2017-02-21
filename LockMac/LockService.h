//
//  LockService.h
//  LockMac
//
//  Created by xjshi on 21/02/2017.
//  Copyright © 2017 sxj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LockService : NSObject

+ (BOOL)isScreenLocked;
+ (void)lock;
+ (void)unlock;

@end
