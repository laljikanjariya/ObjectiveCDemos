//
//  Messages+CoreDataProperties.h
//  
//
//  Created by Siya9 on 17/08/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Messages.h"

NS_ASSUME_NONNULL_BEGIN

@interface Messages (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *fromMsg;
@property (nullable, nonatomic, retain) NSNumber *isSeen;
@property (nullable, nonatomic, retain) NSNumber *isSent;
@property (nullable, nonatomic, retain) NSString *stringMessage;
@property (nullable, nonatomic, retain) NSNumber *mID;
@property (nullable, nonatomic, retain) NSString *msgURL;
@property (nullable, nonatomic, retain) NSString *sectionKey;
@property (nullable, nonatomic, retain) NSDate *sendTime;
@property (nullable, nonatomic, retain) NSNumber *toMsg;
@property (nullable, nonatomic, retain) NSNumber *messageType;
@property (nullable, nonatomic, retain) UserData *userData;

@end

NS_ASSUME_NONNULL_END
