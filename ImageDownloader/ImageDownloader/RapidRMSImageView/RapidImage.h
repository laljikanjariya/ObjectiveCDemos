//
//  RapidImage.h
//  ImageDownloader
//
//  Created by Siya9 on 18/11/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACPDownloadView.h"
#import "DDFileManager.h"

typedef NS_ENUM(NSUInteger, ImageCatchType)
{
    ImageCatchTypeRIM,
};

@class ACPDownloadView;

@interface RapidImage : UIView
@property (nonatomic, weak) IBOutlet UIImageView * imgView;
@property (weak, nonatomic) IBOutlet ACPDownloadView * indView;
@property (nonatomic, strong) CompletionHandler completionHandler;
+(UIImage *)getImageFromCatch:(NSString *)strUrl imageCatchType:(ImageCatchType)catchType;
-(DDFileInfo *)loadImage:(NSString *)strUrl imageCatchType:(ImageCatchType)catchType withCompletionHandler:(CompletionHandler)completionHandler;
@end
