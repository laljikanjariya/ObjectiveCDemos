//
//  main.m
//  Swizzling
//
//  Created by Siya9 on 21/06/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CustomClass.h"
#import "CustomClass+CustomCategory.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        CustomClass *cc = [[CustomClass alloc] init];
        [cc newMethod];
        return 0;
    }
}
