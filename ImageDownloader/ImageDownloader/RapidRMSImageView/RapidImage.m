//
//  RapidImage.m
//  ImageDownloader
//
//  Created by Siya9 on 18/11/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "RapidImage.h"
#import "AppDelegate.h"
#import "DDFileManager.h"

@implementation RapidImage

+(UIImage *)getImageFromCatch:(NSString *)strUrl imageCatchType:(ImageCatchType)catchType{
    strUrl = [strUrl stringByReplacingOccurrencesOfString:Prifix withString:@""];
    NSString * strCatchPath = [NSString stringWithFormat:@"%@/%@",[RapidImage getPathForCatchType:catchType],strUrl.lastPathComponent];
    NSFileManager * fileManage = [NSFileManager defaultManager];
    NSString * strLocation = [strCatchPath stringByReplacingOccurrencesOfString:strCatchPath.lastPathComponent withString:@""];
    strLocation = [strLocation stringByReplacingOccurrencesOfString:strCatchPath.lastPathComponent withString:@""];
    
    if (![fileManage fileExistsAtPath:strLocation]) {
        [fileManage createDirectoryAtPath:strLocation withIntermediateDirectories:TRUE attributes:nil error:nil];
    }
    if ([fileManage fileExistsAtPath:strCatchPath]) {
        return [UIImage imageWithContentsOfFile:strCatchPath];
    }
    else{
        return nil;
    }
}

-(DDFileInfo *)loadImage:(NSString *)strUrl imageCatchType:(ImageCatchType)catchType{
    return [self loadImage:strUrl imageCatchType:catchType withCompletionHandler:nil];
}
-(DDFileInfo *)loadImage:(NSString *)strUrl imageCatchType:(ImageCatchType)catchType withCompletionHandler:(CompletionHandler)completionHandler {
    UIImage * image = [RapidImage getImageFromCatch:strUrl imageCatchType:catchType];
    if (image) {
        self.imgView.image = image;
        self.indView.hidden = TRUE;
        return nil;
    }
    else {
        self.indView.hidden = FALSE;
        
//        DDFileInfo * fileInfo =  [DDFileManager addToDownloadUserImageWithUrl:@"https://s3-eu-west-1.amazonaws.com/alf-proeysen/Bakvendtland-MASTER.mp4"];
        DDFileInfo * fileInfo =  [DDFileManager addToDownloadUserImageWithUrl:strUrl];
        [self.indView setIndicatorStatus:ACPDownloadStatusIndeterminate];
        fileInfo.completionHandler = completionHandler;
        [self.indView setProgress:0.0f animated:FALSE];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:Prifix withString:@""];
        fileInfo.strStoreTO = [NSString stringWithFormat:@"%@%@",[RapidImage getPathForCatchType:catchType],strUrl.lastPathComponent];
        
        if (fileInfo.downloadProgress > 0.0f) {
            [self.indView setIndicatorStatus:ACPDownloadStatusRunning];
            [self.indView setProgress:fileInfo.downloadProgress animated:TRUE];
        }
        [self.indView setActionForTap:^(ACPDownloadView *downloadView, ACPDownloadStatus status) {
            switch (status) {
                case ACPDownloadStatusRunning:
                    [downloadView setIndicatorStatus:ACPDownloadStatusNone];
                    [DDFileManager pushDownloadForFile:fileInfo];
                    NSLog(@"%lu",(unsigned long)status);
                    break;
                case ACPDownloadStatusNone:
                    [downloadView setIndicatorStatus:ACPDownloadStatusIndeterminate];
                    [DDFileManager startDownloadForFile:fileInfo];
                    NSLog(@"%lu",(unsigned long)status);
                    break;
                default:
                    break;
            }
        }];
        if (fileInfo.fileStatus != DDFileDownloadStatusPush) {
            [DDFileManager startDownloadForFile:fileInfo];
        }
        else{
            [self.indView setIndicatorStatus:ACPDownloadStatusNone];
        }
        return fileInfo;
    }
}
+(NSString *)getPathForCatchType:(ImageCatchType)catchType {
    NSString * strCatchPath = [NSString stringWithFormat:@"%@/Documents/MyChatMedia/ProfileImages/",NSHomeDirectory()];
    //    switch (catchType) {
    //        case ImageCatchTypeRIM:
    //
    //            break;
    //
    //        default:
    //            break;
    //    }
    return strCatchPath;
}
@end