//
//  DownloadManager.m
//  ImageDownloader
//
//  Created by Siya9 on 18/11/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "DownloadManager.h"
//#import "IconDownloader.h"
#import "DDFileManager.h"

@implementation DownloadManager
+ (instancetype)sharedInstance
{
    static DownloadManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DownloadManager alloc] init];
        sharedInstance.arrDownLoadList = [[NSMutableArray alloc]init];
    });
    return sharedInstance;
}
+(BOOL)isDownloadFrom:(NSString *)strUrl{
    if([DownloadManager  getDownloadFrom:strUrl]){
        return TRUE;
    }
    else{
        return FALSE;
    }
}
+(FileInfo *)getDownloadFrom:(NSString *)strUrl{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"self.imageURLString == %@",strUrl];
    return [[[DownloadManager sharedInstance].arrDownLoadList filteredArrayUsingPredicate:predicate] firstObject];
}
+(FileInfo *)addDownloadFrom:(NSString *)strUrl storeTo:(NSString *)storePath responce:(id)responce completionHandler:(completionHandler)completionHandler progresView:(ACPDownloadView *)DownloadView{
    FileInfo * objFile = [DownloadManager getDownloadFrom:strUrl];
    if (!objFile) {
        objFile = [[FileInfo alloc]init];
        objFile.imageURLString = strUrl;
        objFile.storePath = storePath;
        objFile.responce = responce;
        objFile.completionHandler = completionHandler;
        objFile.indView = DownloadView;
        objFile.isDownloading = FALSE;
        [[DownloadManager sharedInstance].arrDownLoadList addObject:objFile];
        [DownloadManager startDownloadToFile:objFile];
    }
    return objFile;
}
+(BOOL)startDownloadToFile:(FileInfo *)objFile{
    if (!objFile.isDownloading) {
        [DataDownloader startDownloadToFile:objFile withCompletionHandler:^(FileInfo * objFile) {
            objFile.completionHandler(objFile.responce);
            [[DownloadManager sharedInstance].arrDownLoadList removeObject:objFile];
        }];
        objFile.isDownloading = TRUE;
        return objFile.isDownloading;
    }
    else{
        return FALSE;
    }
}
@end
