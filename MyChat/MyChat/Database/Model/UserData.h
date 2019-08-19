//
//  UserData.h
//  
//
//  Created by Siya9 on 11/08/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Messages;

NS_ASSUME_NONNULL_BEGIN

@interface UserData : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@property (nonatomic, weak) Messages * lastMessage;
@property (nonatomic, weak) NSArray<Messages *>* myUnreadMessages;
@end

NS_ASSUME_NONNULL_END

#import "UserData+CoreDataProperties.h"
