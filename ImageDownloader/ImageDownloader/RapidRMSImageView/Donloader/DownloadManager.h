//
//  DownloadManager.h
//  ImageDownloader
//
//  Created by Siya9 on 18/11/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RapidImage.h"

@interface DownloadManager : NSObject

@property (nonatomic, strong) NSMutableArray <FileInfo *> * arrDownLoadList;

+(BOOL)isDownloadFrom:(NSString *)strUrl;
+(FileInfo *)getDownloadFrom:(NSString *)strUrl;
+(FileInfo *)addDownloadFrom:(NSString *)strUrl storeTo:(NSString *)storePath responce:(id)responce completionHandler:(completionHandler)completionHandler progresView:(ACPDownloadView *)DownloadView;
+(BOOL)startDownloadToFile:(FileInfo *)objFile;
@end
