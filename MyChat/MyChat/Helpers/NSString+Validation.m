//
//  NSString+Validation.m
//  MyChat
//
//  Created by Siya9 on 17/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)
-(NSString *)getUserProfileImagePath{
    return [NSString stringWithFormat:@"%@/Documents/MyChatMedia/ProfileImages/%@",NSHomeDirectory(),self.lastPathComponent];
}
-(NSString *)getUserMessageMediaImagesPath{
    return [NSString stringWithFormat:@"%@/Documents/MyChatMedia/MessageImages/%@",NSHomeDirectory(),self.lastPathComponent];
}
-(NSString *)getUserMessageMediaAudioPath{
    return [NSString stringWithFormat:@"%@/Documents/MyChatMedia/MessageAudio/%@",NSHomeDirectory(),self.lastPathComponent];
}
-(NSString *)getUserMessageMediaVideoPath{
    return [NSString stringWithFormat:@"%@/Documents/MyChatMedia/MessageVideo/%@",NSHomeDirectory(),self.lastPathComponent];
}

-(BOOL)isFileExist{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:self isDirectory:nil];
}
@end
