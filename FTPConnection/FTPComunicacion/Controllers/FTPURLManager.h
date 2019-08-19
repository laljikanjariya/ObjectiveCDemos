//
//  FTPURLManager.h
//  FTPConnection
//
//  Created by Siya9 on 05/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTPURLManager : NSObject


+ (NSURL *)smartURLForString:(NSString *)str;
+ (NSString *)pathForTemporaryFileWithPrefix:(NSString *)prefix;
@end
