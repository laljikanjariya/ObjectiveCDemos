//
//  AddressBookGeter.h
//  AddressBook
//
//  Created by Siya Infotech on 26/11/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

@interface AddressBookGeter : NSObject
@property (nonatomic ,strong) CNContactStore * contactsStrore;
+ (instancetype)addressBookContect:(void (^)(BOOL optestion , NSArray * array ,NSError * error )) result;
+(void)addContectToDefaultContectStoreContectInfo:(NSDictionary *)dictContectInfo withError:(NSError **)error;

+ (CNMutableContact *)contectFromDictionry:(NSDictionary *) dictContect withContectObject:(CNMutableContact *) objContect;
+ (NSMutableDictionary *)dictionryFromContects:(CNMutableContact *) contect;
@end