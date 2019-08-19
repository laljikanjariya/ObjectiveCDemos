//
//  UserData+CoreDataProperties.h
//  
//
//  Created by Siya9 on 31/12/16.
//
//  This file was automatically generated and should not be edited.
//

#import "UserData.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserData (CoreDataProperties)

+ (NSFetchRequest<UserData *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *fName;
@property (nullable, nonatomic, copy) NSDate *lastActiveTime;
@property (nullable, nonatomic, copy) NSString *lName;
@property (nullable, nonatomic, copy) NSString *pImage;
@property (nullable, nonatomic, copy) NSNumber *uID;
@property (nullable, nonatomic, copy) NSNumber *userStatus;
@property (nullable, nonatomic, copy) NSString *emailID;
@property (nullable, nonatomic, retain) NSSet<Messages *> *messages;

@end

@interface UserData (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(Messages *)value;
- (void)removeMessagesObject:(Messages *)value;
- (void)addMessages:(NSSet<Messages *> *)values;
- (void)removeMessages:(NSSet<Messages *> *)values;

@end

NS_ASSUME_NONNULL_END
