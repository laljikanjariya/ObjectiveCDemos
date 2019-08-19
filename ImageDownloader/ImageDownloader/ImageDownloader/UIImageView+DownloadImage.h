//
//  UIImageView+DownloadImage.h
//  ImageDownloader
//
//  Created by Siya9 on 17/11/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ImageCatchType1)
{
    ImageCatchTypeRIM1,
};

typedef void (^completionHandler)(id responce);
@class FileInfo1;

@interface UIImageView (DownloadImage)
-(UIImage *)loadImageFromCatch:(NSString *)strUrl imageCatchType:(ImageCatchType1)catchType;
-(FileInfo1 *)loadImage:(NSString *)strUrl imageCatchType:(ImageCatchType1)catchType;
-(FileInfo1 *)loadImage:(NSString *)strUrl imageCatchType:(ImageCatchType1)catchType withCompletionHandler:(completionHandler)completionHandler;
@end


@interface FileInfo1 : NSObject
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *imageURLString;
@property (nonatomic, strong) NSString *storePath;
@property (nonatomic, strong) id responce;
@property (nonatomic, copy) void (^completionHandler)(id responce);
@end