//
//  NSString+Validation.h
//  MyChat
//
//  Created by Siya9 on 17/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validation)
-(NSString *)getUserProfileImagePath;
-(NSString *)getUserMessageMediaImagesPath;
-(NSString *)getUserMessageMediaAudioPath;
-(NSString *)getUserMessageMediaVideoPath;
-(BOOL)isFileExist;
@end
