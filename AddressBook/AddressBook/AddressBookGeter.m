//
//  AddressBookGeter.m
//  AddressBook
//
//  Created by Siya Infotech on 26/11/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import "AddressBookGeter.h"
#import "Test.h"


@interface AddressBookGeter ()

@property (nonatomic ,strong) NSMutableArray * arrContectList;
@property (nonatomic ,strong) NSError * error;
@end
@implementation AddressBookGeter
#pragma mark - Address Book -
+ (instancetype)addressBookContect:(void (^)(BOOL optestion , NSArray * array ,NSError * error )) result{
    AddressBookGeter * obj = [[AddressBookGeter alloc]init];

    [obj checkContactsAccess];
    result(YES,obj.arrContectList,obj.error);
    return obj;
}
-(void)addressBookContect:(void (^)(BOOL optestion , NSArray * array ,NSError * error )) result{
    [self checkContactsAccess];
    result(YES,self.arrContectList,self.error);
}
-(void)checkContactsAccess{
    if (!self.contactsStrore) {
        self.contactsStrore= [[CNContactStore alloc] init];
    }
    [self requestContactsAccessWithHandler:^(BOOL grandted) {
        
        if (grandted) {
            self.arrContectList = [[NSMutableArray alloc]init];
            CNContactFetchRequest *request = [[CNContactFetchRequest alloc]initWithKeysToFetch:@[[CNContactViewController descriptorForRequiredKeys]]];
            [self.contactsStrore enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
                    [self.arrContectList addObject:contact];
            }];
        }
    }];
}
-(void)requestContactsAccessWithHandler:(void (^)(BOOL grandted))handler{
    
    switch ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts]) {
        case CNAuthorizationStatusAuthorized:
            handler(YES);
            break;
        case CNAuthorizationStatusDenied:
        case CNAuthorizationStatusNotDetermined:{
            [self.contactsStrore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                self.error = error;
                handler(granted);
            }];
            break;
        }
        case CNAuthorizationStatusRestricted:
            [self.contactsStrore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                self.error = error;
                handler(granted);
            }];
            break;
    }
}

#pragma mark - AddContect With Data -
+(void)addContectToDefaultContectStoreContectInfo:(NSDictionary *)dictContectInfo withError:(NSError *__nullable *__nullable)error{
    
    CNContactStore *store = [[CNContactStore alloc] init];
    // create contact
    
    
    CNMutableContact *contact;
    if ([dictContectInfo isKindOfClass:[NSDictionary class]]) {
        contact = [self contectFromDictionry:dictContectInfo withContectObject:nil];
    }
    else if ([dictContectInfo isKindOfClass:[CNMutableContact class]]){
        contact = (CNMutableContact *)dictContectInfo;
    }
    else{
        return;
    }
    CNSaveRequest *request = [[CNSaveRequest alloc] init];
    [request addContact:contact toContainerWithIdentifier:nil];
    
    // save it
    
    if (![store executeSaveRequest:request error:error]) {
        NSLog(@"error = %@", *error);
    }
}
#pragma mark - Type Casting -
+ (CNMutableContact *)contectFromDictionry:(NSDictionary *) dictContect withContectObject:(CNMutableContact *) objContect{
    if (!objContect) {
            objContect = [[CNMutableContact alloc]init];
    }
//    if ([dictContect objectForKey:@"<#key#>"]) {
//        objContect.<#keys#> = [dictContect objectForKey:@"<#key#>"];
//    }
    if ([dictContect objectForKey:@"namePrefix"]) {
        objContect.namePrefix = [dictContect objectForKey:@"namePrefix"];
    }
    if ([dictContect objectForKey:@"givenName"]) {
        objContect.givenName = [dictContect objectForKey:@"givenName"];
    }
    if ([dictContect objectForKey:@"middleName"]) {
        objContect.middleName = [dictContect objectForKey:@"middleName"];
    }
    if ([dictContect objectForKey:@"familyName"]) {
        objContect.familyName = [dictContect objectForKey:@"familyName"];
    }
    if ([dictContect objectForKey:@"previousFamilyName"]) {
        objContect.previousFamilyName = [dictContect objectForKey:@"previousFamilyName"];
    }
    if ([dictContect objectForKey:@"nameSuffix"]) {
        objContect.nameSuffix = [dictContect objectForKey:@"nameSuffix"];
    }
    if ([dictContect objectForKey:@"nickname"]) {
        objContect.nickname = [dictContect objectForKey:@"nickname"];
    }
    if ([dictContect objectForKey:@"phoneticGivenName"]) {
//        CNLabeledValue *homePhone = [CNLabeledValue labeledValueWithLabel:CNLabelHome value:[CNPhoneNumber phoneNumberWithStringValue:@"312-555-1212"]];
//        contact.phoneNumbers = @[homePhone];
        objContect.phoneticGivenName = [dictContect objectForKey:@"phoneticGivenName"];
    }
    if ([dictContect objectForKey:@"phoneticMiddleName"]) {
        objContect.phoneticMiddleName = [dictContect objectForKey:@"phoneticMiddleName"];
    }
    if ([dictContect objectForKey:@"phoneticFamilyName"]) {
        objContect.phoneticFamilyName = [dictContect objectForKey:@"phoneticFamilyName"];
    }
    if ([dictContect objectForKey:@"organizationName"]) {
        objContect.organizationName = [dictContect objectForKey:@"organizationName"];
    }
    if ([dictContect objectForKey:@"departmentName"]) {
        objContect.departmentName = [dictContect objectForKey:@"departmentName"];
    }
    if ([dictContect objectForKey:@"jobTitle"]) {
        objContect.jobTitle = [dictContect objectForKey:@"jobTitle"];
    }
    if ([dictContect objectForKey:@"note"]) {
        objContect.note = [dictContect objectForKey:@"note"];
    }
    if ([dictContect objectForKey:@"imageData"]) {
        objContect.imageData = [dictContect objectForKey:@"imageData"];
    }
    if ([dictContect objectForKey:@"phoneNumbers"]) {
        objContect.phoneNumbers = [dictContect objectForKey:@"phoneNumbers"];
    }
    if ([dictContect objectForKey:@"emailAddresses"]) {
        objContect.emailAddresses = [dictContect objectForKey:@"emailAddresses"];
    }
    if ([dictContect objectForKey:@"postalAddresses"]) {
        objContect.postalAddresses = [dictContect objectForKey:@"postalAddresses"];
    }
    if ([dictContect objectForKey:@"urlAddresses"]) {
        objContect.urlAddresses = [dictContect objectForKey:@"urlAddresses"];
    }
    if ([dictContect objectForKey:@"contactRelations"]) {
        objContect.contactRelations = [dictContect objectForKey:@"contactRelations"];
    }
    if ([dictContect objectForKey:@"socialProfiles"]) {
        objContect.socialProfiles = [dictContect objectForKey:@"socialProfiles"];
    }
    if ([dictContect objectForKey:@"instantMessageAddresses"]) {
        objContect.instantMessageAddresses = [dictContect objectForKey:@"instantMessageAddresses"];
    }
    if ([dictContect objectForKey:@"birthday"]) {
        objContect.birthday = [dictContect objectForKey:@"birthday"];
    }
    
    return objContect;
}
+ (NSMutableDictionary *)dictionryFromContects:(CNMutableContact *) contect{
    NSMutableDictionary * dictContect = [[NSMutableDictionary alloc]init];
//    if (contect.<#keys#>) {
//        [dictContect setObject:contect.<#keys#> forKey:@"<#key#>"];
//    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSString *namePrefix;
    if (contect.namePrefix) {
        [dictContect setObject:contect.namePrefix forKey:@"namePrefix"];
    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSString *givenName;
    if (contect.givenName) {
        [dictContect setObject:contect.givenName forKey:@"givenName"];
    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSString *middleName;
    if (contect.middleName) {
        [dictContect setObject:contect.middleName forKey:@"middleName"];
    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSString *familyName;
    if (contect.familyName) {
        [dictContect setObject:contect.familyName forKey:@"familyName"];
    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSString *previousFamilyName;
    if (contect.previousFamilyName) {
        [dictContect setObject:contect.previousFamilyName forKey:@"previousFamilyName"];
    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSString *nameSuffix;
    if (contect.nameSuffix) {
        [dictContect setObject:contect.nameSuffix forKey:@"nameSuffix"];
    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSString *nickname;
    if (contect.nickname) {
        [dictContect setObject:contect.nickname forKey:@"nickname"];
    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSString *phoneticGivenName;
    if (contect.phoneticGivenName) {
        [dictContect setObject:contect.phoneticGivenName forKey:@"phoneticGivenName"];
    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSString *phoneticMiddleName;
    if (contect.phoneticMiddleName) {
        [dictContect setObject:contect.phoneticMiddleName forKey:@"phoneticMiddleName"];
    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSString *phoneticFamilyName;
    if (contect.phoneticFamilyName) {
        [dictContect setObject:contect.phoneticFamilyName forKey:@"phoneticFamilyName"];
    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSString *organizationName;
    if (contect.organizationName) {
        [dictContect setObject:contect.organizationName forKey:@"organizationName"];
    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSString *departmentName;
    if (contect.departmentName) {
        [dictContect setObject:contect.departmentName forKey:@"departmentName"];
    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSString *jobTitle;
    if (contect.jobTitle) {
        [dictContect setObject:contect.jobTitle forKey:@"jobTitle"];
    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSString *note;
    if (contect.note) {
        [dictContect setObject:contect.note forKey:@"note"];
    }
//    @property (copy, nullable, NS_NONATOMIC_IOSONLY) NSData *imageData;
    if (contect.imageData) {
        [dictContect setObject:contect.imageData forKey:@"imageData"];
    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSArray<CNLabeledValue<CNPhoneNumber*>*>               *phoneNumbers;
    if (contect.phoneNumbers) {
        [dictContect setObject:contect.phoneNumbers forKey:@"phoneNumbers"];
    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSArray<CNLabeledValue<NSString*>*>                    *emailAddresses;
    if (contect.emailAddresses) {
        [dictContect setObject:contect.emailAddresses forKey:@"emailAddresses"];
    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSArray<CNLabeledValue<CNPostalAddress*>*>             *postalAddresses;
    if (contect.postalAddresses) {
        [dictContect setObject:contect.postalAddresses forKey:@"postalAddresses"];
    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSArray<CNLabeledValue<NSString*>*>                    *urlAddresses;
    if (contect.urlAddresses) {
        [dictContect setObject:contect.urlAddresses forKey:@"urlAddresses"];
    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSArray<CNLabeledValue<CNContactRelation*>*>           *contactRelations;
    if (contect.contactRelations) {
        [dictContect setObject:contect.contactRelations forKey:@"contactRelations"];
    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSArray<CNLabeledValue<CNSocialProfile*>*>             *socialProfiles;
    if (contect.socialProfiles) {
        [dictContect setObject:contect.socialProfiles forKey:@"socialProfiles"];
    }
//    @property (copy, NS_NONATOMIC_IOSONLY) NSArray<CNLabeledValue<CNInstantMessageAddress*>*>     *instantMessageAddresses;
    if (contect.instantMessageAddresses) {
        [dictContect setObject:contect.instantMessageAddresses forKey:@"instantMessageAddresses"];
    }
//    @property (copy, nullable, NS_NONATOMIC_IOSONLY) NSDateComponents *birthday;
    if (contect.birthday) {
        [dictContect setObject:contect.birthday forKey:@"birthday"];
    }
    
    return dictContect;
}
@end
