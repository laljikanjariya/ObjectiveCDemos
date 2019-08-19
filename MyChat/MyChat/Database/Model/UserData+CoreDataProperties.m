//
//  UserData+CoreDataProperties.m
//  
//
//  Created by Siya9 on 31/12/16.
//
//  This file was automatically generated and should not be edited.
//

#import "UserData+CoreDataProperties.h"

@implementation UserData (CoreDataProperties)

+ (NSFetchRequest<UserData *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UserData"];
}

@dynamic fName;
@dynamic lastActiveTime;
@dynamic lName;
@dynamic pImage;
@dynamic uID;
@dynamic userStatus;
@dynamic emailID;
@dynamic messages;

@end
