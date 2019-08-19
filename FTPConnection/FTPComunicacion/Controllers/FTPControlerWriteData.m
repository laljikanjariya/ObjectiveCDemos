//
//  FTPControlerWriteData.m
//  FTPConnection
//
//  Created by Siya9 on 06/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "FTPControlerWriteData.h"

enum {
    kSendBufferSize = 32768
};

@interface FTPControlerWriteData ()


@property (nonatomic, assign, readonly ) uint8_t * buffer;
@property (nonatomic, assign, readwrite) size_t            bufferOffset;
@property (nonatomic, assign, readwrite) size_t            bufferLimit;
@end

@implementation FTPControlerWriteData
{
    uint8_t _buffer[kSendBufferSize];
}

+(instancetype)uploadFileToFTPPath:(NSString *)strFTPpath fileLocalPath:(NSString *)strFile userID:(NSString *)strUserId userPassword:(NSString *)strPassword forDelegate:(id)delegate {
    FTPControlerWriteData * ovjCreate = [[FTPControlerWriteData alloc]init];
    ovjCreate.ftpPath = strFTPpath;
    ovjCreate.fileOrDir= strFile;
    
    ovjCreate.userName= strUserId;
    ovjCreate.password= strPassword;
    ovjCreate.delegate = delegate;
    [ovjCreate openWriteData];
    return ovjCreate;
}
- (uint8_t *)buffer
{
    return self-> _buffer;
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
// An NSStream delegate callback that's called when events happen on our
// network stream.
{
#pragma unused(aStream)
    assert(aStream == self.objOutputStream);
    
    switch (eventCode) {
        case NSStreamEventOpenCompleted: {
        } break;
        case NSStreamEventHasBytesAvailable: {
            assert(NO);     // should never happen for the output stream
        } break;
        case NSStreamEventHasSpaceAvailable: {
            if (self.bufferOffset == self.bufferLimit) {
                NSInteger   bytesRead;
                
                bytesRead = [self.objInputStream read:self.buffer maxLength:kSendBufferSize];
                
                if (bytesRead == -1) {
                    [self sendErrorMessage:@"File read error"];
                } else if (bytesRead == 0) {
                    [self.delegate uploadFileTo:self.ftpPath];
                    [self stopStream];
                } else {
                    self.bufferOffset = 0;
                    self.bufferLimit  = bytesRead;
                }
            }
            
            // If we're not out of data completely, send the next chunk.
            
            if (self.bufferOffset != self.bufferLimit) {
                NSInteger   bytesWritten;
                bytesWritten = [self.objOutputStream write:&self.buffer[self.bufferOffset] maxLength:self.bufferLimit - self.bufferOffset];
                assert(bytesWritten != 0);
                if (bytesWritten == -1) {
                    [self sendErrorMessage:@"Network write error"];
                } else {
                    self.bufferOffset += bytesWritten;
                }
            }
        } break;
        case NSStreamEventErrorOccurred: {
            [self sendErrorMessage:@"Stream open error"];
        } break;
        case NSStreamEventEndEncountered: {
        } break;
        default: {
            assert(NO);
        } break;
    }
}
-(void)sendErrorMessage:(NSString *)message{
    [self.delegate updateStatus:self WithError:message];
    [self stopStream];
}
-(void)stopStream{
    if (self.objOutputStream != nil) {
        [self.objOutputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.objOutputStream.delegate = nil;
        [self.objOutputStream close];
        self.objOutputStream = nil;
    }
    if (self.objInputStream != nil) {
        [self.objInputStream close];
        self.objInputStream = nil;
    }
}
@end
