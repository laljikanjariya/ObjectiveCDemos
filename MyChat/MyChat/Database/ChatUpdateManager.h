//
//  ChatUpdateManager.h
//  MyChat
//
//  Created by Siya9 on 11/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPRoster.h"
//Coredata
#import "UserData.h"
#import "Messages.h"

typedef NS_ENUM(NSInteger, MessageType)
{
    MessageTypeString = 1,
    MessageTypeImage = 2,
    MessageTypeVideo = 3,
    MessageTypeAudio = 4,
};

@interface ChatUpdateManager : NSObject <XMPPRosterDelegate>


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) UserData * userLoged;


+ (instancetype)sharedInstance;

#pragma mark - CoreData -

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (NSManagedObjectContext *)managedObjectContext_roster;

#pragma mark - Add Message From XMPP -

+(void)addNewStringMessage:(NSString *)strMessage ToUser:(UserData *)toUser fromUser:(UserData *)fromUser isSent:(NSNumber *)isSent isSeeen:(NSNumber *)isSeen moc:(NSManagedObjectContext *)moc;
+(void)addNewImageMessage:(NSString *)strImageUrl ToUser:(UserData *)toUser fromUser:(UserData *)fromUser isSent:(NSNumber *)isSent isSeeen:(NSNumber *)isSeen moc:(NSManagedObjectContext *)moc;
+(void)addNewVideoMessage:(NSString *)strVideoUrl ToUser:(UserData *)toUser fromUser:(UserData *)fromUser isSent:(NSNumber *)isSent isSeeen:(NSNumber *)isSeen moc:(NSManagedObjectContext *)moc;

+(NSNumber *)getRendomNumber:(int)min toMax:(int)max;
+(NSNumber *)getNewMessageId;
+(NSNumber *)countForEntity:(NSString *)strEntity;

@end
