//
//  FTPControler.m
//  FTPConnection
//
//  Created by Siya9 on 05/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "FTPControler.h"
#import "FTPURLManager.h"

@interface FTPControler ()<NSStreamDelegate>

@end
@implementation FTPControler

#pragma mark - Create Stream -

- (void)openForCreateDIRStream
// Starts a connection to download the current URL.
{
    BOOL                success;
    NSURL *             url;
    
    assert(self.objInputStream == nil);      // don't tap receive twice in a row!
    
    url = [FTPURLManager smartURLForString:self.ftpPath];
    success = (url != nil);
    
    if (success) {
        url = CFBridgingRelease(
                                CFURLCreateCopyAppendingPathComponent(NULL, (__bridge CFURLRef) url, (__bridge CFStringRef) self.fileOrDir, true)
                                );
        success = (url != nil);
    }
    
    if ( ! success) {
        [self.delegate updateStatus:self WithError:@"Invalid URL"];
    } else {
        
        self.objInputStream = CFBridgingRelease(
                                                CFWriteStreamCreateWithFTPURL(NULL, (__bridge CFURLRef) url)
                                                );
        
        assert(self.objInputStream != nil);
        
        if (self.userName.length > 0) {
            success = [self.objInputStream setProperty:self.userName forKey:(id)kCFStreamPropertyFTPUserName];
            assert(success);
            success = [self.objInputStream setProperty:self.password forKey:(id)kCFStreamPropertyFTPPassword];
            assert(success);
        }
        self.objInputStream.delegate = self;
        [self.objInputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [self.objInputStream open];
    }
}
#pragma mark - Receive List of Item in URL -

-(void)openReceiveList
// Starts a connection to download the current URL.
{
    BOOL                success;
    NSURL *             url;
    
    assert(self.objInputStream == nil);      // don't tap receive twice in a row!
    
    // First get and check the URL.
    
    url = [FTPURLManager smartURLForString:self.ftpPath];
    success = (url != nil);
    
    // If the URL is bogus, let the user know.  Otherwise kick off the connection.
    
    if ( ! success) {
        [self.delegate updateStatus:self WithError:@"Invalid URL"];
    } else {
        
        self.objInputStream = CFBridgingRelease(
                                               CFReadStreamCreateWithFTPURL(NULL, (__bridge CFURLRef) url)
                                               );
        
        assert(self.objInputStream != nil);
        
        if (self.userName.length > 0) {
            success = [self.objInputStream setProperty:self.userName forKey:(id)kCFStreamPropertyFTPUserName];
            assert(success);
            success = [self.objInputStream setProperty:self.password forKey:(id)kCFStreamPropertyFTPPassword];
            assert(success);
        }
        self.objInputStream.delegate = self;
        [self.objInputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [self.objInputStream open];
    }
}

#pragma mark - Write Data -

-(void)openWriteData{
    BOOL                    success;
    NSURL *                 url;
    
    assert(self.fileOrDir != nil);
    assert([[NSFileManager defaultManager] fileExistsAtPath:self.fileOrDir]);
//    assert( [filePath.pathExtension isEqual:@"png"] || [filePath.pathExtension isEqual:@"jpg"] );
    
    assert(self.objOutputStream == nil);      // don't tap send twice in a row!
    assert(self.objInputStream == nil);         // ditto
    
    // First get and check the URL.
    NSString * strServerPath = [self.ftpPath stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"/%@",[self.fileOrDir lastPathComponent]] withString:@""];
    url = [FTPURLManager smartURLForString:strServerPath];
    success = (url != nil);
    
    if (success) {
        // Add the last part of the file name to the end of the URL to form the final
        // URL that we're going to put to.
        
        url = CFBridgingRelease(
                                CFURLCreateCopyAppendingPathComponent(NULL, (__bridge CFURLRef) url, (__bridge CFStringRef) [self.fileOrDir lastPathComponent], false)
                                );
        success = (url != nil);
    }
    
    // If the URL is bogus, let the user know.  Otherwise kick off the connection.
    
    if ( ! success) {
        [self.delegate updateStatus:self WithError:@"Invalid URL"];
//        self.statusLabel.text = @"Invalid URL";
    } else {
        
        // Open a stream for the file we're going to send.  We do not open this stream;
        // NSURLConnection will do it for us.
        
        self.objInputStream = [NSInputStream inputStreamWithFileAtPath:self.fileOrDir];
        assert(self.objInputStream != nil);
        
        [self.objInputStream open];
        
        // Open a CFFTPStream for the URL.
        
        self.objOutputStream = CFBridgingRelease(
                                               CFWriteStreamCreateWithFTPURL(NULL, (__bridge CFURLRef) url)
                                               );
        assert(self.objOutputStream != nil);
        
        if (self.userName.length > 0) {
            success = [self.objOutputStream setProperty:self.userName forKey:(id)kCFStreamPropertyFTPUserName];
            assert(success);
            success = [self.objOutputStream setProperty:self.password forKey:(id)kCFStreamPropertyFTPPassword];
            assert(success);
        }
        
        self.objOutputStream.delegate = self;
        [self.objOutputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [self.objOutputStream open];
    }
}

- (void)openReadData
// Starts a connection to download the current URL.
{
    BOOL                success;
    NSURL *             url;
    
    assert(self.objInputStream == nil);      // don't tap receive twice in a row!
    assert(self.objOutputStream == nil);         // ditto
    
    // First get and check the URL.
    
    url = [FTPURLManager smartURLForString:self.ftpPath];
    success = (url != nil);
    
    // If the URL is bogus, let the user know.  Otherwise kick off the connection.
    
    if ( ! success) {
        [self.delegate updateStatus:self WithError:@"Invalid URL"];
    } else {
        
        self.fileTempPath = [FTPURLManager pathForTemporaryFileWithPrefix:@"Get"];
        self.objOutputStream = [NSOutputStream outputStreamToFileAtPath:self.fileTempPath append:NO];
        assert(self.objOutputStream != nil);
        
        [self.objOutputStream open];
        
        // Open a CFFTPStream for the URL.
        
        self.objInputStream = CFBridgingRelease(
                                               CFReadStreamCreateWithFTPURL(NULL, (__bridge CFURLRef) url)
                                               );
        assert(self.objInputStream != nil);
        
        if (self.userName.length > 0) {
            success = [self.objInputStream setProperty:self.userName forKey:(id)kCFStreamPropertyFTPUserName];
            assert(success);
            success = [self.objInputStream setProperty:self.password forKey:(id)kCFStreamPropertyFTPPassword];
            assert(success);
        }
        self.objInputStream.delegate = self;
        [self.objInputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [self.objInputStream open];
    }
}
-(void)stopOpretion {
    if (self.objOutputStream != nil) {
        [self.objOutputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.objOutputStream.delegate = nil;
        [self.objOutputStream close];
        self.objOutputStream = nil;
    }
    if (self.objInputStream != nil) {
        [self.objInputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.objInputStream.delegate = nil;
        [self.objInputStream close];
        self.objInputStream = nil;
    }
}
@end
