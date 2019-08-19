//
//  UILabel+ResetLocalizable.m
//  Localizetion
//
//  Created by Siya9 on 30/07/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "UILabel+ResetLocalizable.h"
#import "AppDelegate.h"
@implementation UILabel (ResetLocalizable)


- (NSString *)imageHeightPre{
    return @"";
}
-(void)setImageHeightPre:(NSString *)strId{
    AppDelegate * appD = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.text = [appD strGetFromKey:@"test"];
}
@end
