//
//  FTPControlerCteareDIR.m
//  FTPConnection
//
//  Created by Siya9 on 05/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "FTPControlerCteareDIR.h"
#import "FTPStatus.h"

@implementation FTPControlerCteareDIR
+(instancetype)createDirectoryWith:(NSString *)strFTPpath directoryName:(NSString *)strDir userID:(NSString *)strUserId userPassword:(NSString *)strPassword forDelegate:(id)delegate{
    FTPControlerCteareDIR * ovjCreate = [[FTPControlerCteareDIR alloc]init];
    ovjCreate.ftpPath = strFTPpath;
    ovjCreate.fileOrDir= strDir;
    
    ovjCreate.userName= strUserId;
    ovjCreate.password= strPassword;
    ovjCreate.delegate = delegate;
    [ovjCreate openForCreateDIRStream];
    return ovjCreate;
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
// An NSStream delegate callback that's called when events happen on our
// network stream.
{
#pragma unused(aStream)
    assert(aStream == self.objInputStream);
    
    switch (eventCode) {
        case NSStreamEventOpenCompleted: {
        } break;
        case NSStreamEventHasBytesAvailable: {
            [self sendErrorMessage:@"never happen for the NSInputStream"];
            assert(NO);     // should never happen for the output stream
        } break;
        case NSStreamEventHasSpaceAvailable: {
            [self sendErrorMessage:@"never happen for the NSInputStream"];
            assert(NO);
        } break;
        case NSStreamEventErrorOccurred: {
            CFStreamError   err;
            err = CFWriteStreamGetError( (__bridge CFWriteStreamRef) self.objInputStream );
            if (err.domain == kCFStreamErrorDomainFTP) {
                [self sendErrorMessage:[NSString stringWithFormat:@"FTP error %d", (int) err.error]];
            } else {
                [self sendErrorMessage:@"Stream open error"];
            }
        } break;
        case NSStreamEventEndEncountered: {
            [self.delegate createDirectory:TRUE];
            [self stopStream];
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
    if (self.objInputStream) {
        [self.objInputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.objInputStream.delegate = nil;
        [self.objInputStream close];
        self.objInputStream = nil;

    }
}
@end
