//
//  UIImageView+DownloadImage.m
//  ImageDownloader
//
//  Created by Siya9 on 17/11/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "UIImageView+DownloadImage.h"
#import "IconDownloader.h"
#import "AppDelegate.h"
#import "RMDownloadIndicator.h"

@implementation FileInfo1 : NSObject
-(NSString *)description{
    return [NSString stringWithFormat:@"%@",self.fileName];
}
@end

@implementation UIImageView (DownloadImage)


-(UIImage *)loadImageFromCatch:(NSString *)strUrl imageCatchType:(ImageCatchType1)catchType{
    strUrl = [strUrl stringByReplacingOccurrencesOfString:Prifix withString:@""];
    NSString * strCatchPath = [NSString stringWithFormat:@"%@/%@",[self getPathForCatchType:catchType],strUrl.lastPathComponent];
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

-(FileInfo1 *)loadImage:(NSString *)strUrl imageCatchType:(ImageCatchType1)catchType{
    return [self loadImage:strUrl imageCatchType:catchType withCompletionHandler:nil];
}
-(FileInfo1 *)loadImage:(NSString *)strUrl imageCatchType:(ImageCatchType1)catchType withCompletionHandler:(completionHandler)completionHandler {
    UIImage * image = [self loadImageFromCatch:strUrl imageCatchType:catchType];
    if (image) {
        self.image = image;
        return nil;
    }
    else {

        strUrl = [strUrl stringByReplacingOccurrencesOfString:Prifix withString:@""];
        NSString * strCatchPath = [NSString stringWithFormat:@"%@/%@",[self getPathForCatchType:catchType],strUrl.lastPathComponent];
        NSString * strLocation = [strCatchPath stringByReplacingOccurrencesOfString:strCatchPath.lastPathComponent withString:@""];
        strLocation = [strLocation stringByReplacingOccurrencesOfString:strCatchPath.lastPathComponent withString:@""];

        
        FileInfo1 * file = [[FileInfo1 alloc]init];
        file.fileName = strCatchPath.lastPathComponent;
        file.storePath = strCatchPath;
        file.imageURLString = [NSString stringWithFormat:@"%@%@",strUrl,Prifix];
        file.completionHandler = completionHandler;
        IconDownloader * downloader = [[IconDownloader alloc]init];
        downloader.fileInfo = file;
//        [downloader startDownload];

        [self.indicator updateWith:0.9];
        return file;
    }
}
-(NSString *)getPathForCatchType:(ImageCatchType1)catchType {
    NSString * strCatchPath = [NSString stringWithFormat:@"%@/Library/Caches/RapidRMS",NSHomeDirectory()];
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
-(RMDownloadIndicator *)indicator{
    RMDownloadIndicator * indicator = [self viewWithTag:1587];
    if (!indicator) {
        indicator = [[RMDownloadIndicator alloc]initWithFrame:CGRectMake(10, 10, 20, 20) type:kRMFilledIndicator];

        indicator.tag = 1587;
        [indicator setBackgroundColor:[UIColor yellowColor]];
        [indicator setFillColor:[UIColor clearColor]];
        [indicator setStrokeColor:[UIColor greenColor]];
        [indicator setClosedIndicatorBackgroundStrokeColor:[UIColor redColor]];
        indicator.radiusPercent = 0.45;
//        indicator.center = self.center;
        [self addSubview:indicator];
        [indicator loadIndicator];

    }
    return indicator;
}
@end
