//
//  UserData.m
//  
//
//  Created by Siya9 on 11/08/16.
//
//

#import "UserData.h"
#import "Messages.h"

@implementation UserData
@dynamic lastMessage,myUnreadMessages;

-(Messages *)lastMessage{
    NSArray * arrMessage = self.myUnreadMessages;
    
    arrMessage = [arrMessage sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDate *first = [(Messages *)a sendTime];
        NSDate *second = [(Messages*)b sendTime];
        return [first compare:second];
    }];
    return (Messages *)[arrMessage lastObject];
}
@end
