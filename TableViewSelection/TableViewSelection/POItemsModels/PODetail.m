//
//	PODetail.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "PODetail.h"

NSString *const kPODetailCreated = @"Created";
NSString *const kPODetailOPNNumber = @"OPNNumber";
NSString *const kPODetailPOName = @"POName";
NSString *const kPODetailPOStatus = @"POStatus";
NSString *const kPODetailUserName = @"UserName";

@interface PODetail ()
@end
@implementation PODetail




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kPODetailCreated] isKindOfClass:[NSNull class]]){
		self.created = dictionary[kPODetailCreated];
	}	
	if(![dictionary[kPODetailOPNNumber] isKindOfClass:[NSNull class]]){
		self.oPNNumber = dictionary[kPODetailOPNNumber];
	}	
	if(![dictionary[kPODetailPOName] isKindOfClass:[NSNull class]]){
		self.pOName = dictionary[kPODetailPOName];
	}	
	if(![dictionary[kPODetailPOStatus] isKindOfClass:[NSNull class]]){
		self.pOStatus = dictionary[kPODetailPOStatus];
	}	
	if(![dictionary[kPODetailUserName] isKindOfClass:[NSNull class]]){
		self.userName = dictionary[kPODetailUserName];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.created != nil){
		dictionary[kPODetailCreated] = self.created;
	}
	if(self.oPNNumber != nil){
		dictionary[kPODetailOPNNumber] = self.oPNNumber;
	}
	if(self.pOName != nil){
		dictionary[kPODetailPOName] = self.pOName;
	}
	if(self.pOStatus != nil){
		dictionary[kPODetailPOStatus] = self.pOStatus;
	}
	if(self.userName != nil){
		dictionary[kPODetailUserName] = self.userName;
	}
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.created != nil){
		[aCoder encodeObject:self.created forKey:kPODetailCreated];
	}
	if(self.oPNNumber != nil){
		[aCoder encodeObject:self.oPNNumber forKey:kPODetailOPNNumber];
	}
	if(self.pOName != nil){
		[aCoder encodeObject:self.pOName forKey:kPODetailPOName];
	}
	if(self.pOStatus != nil){
		[aCoder encodeObject:self.pOStatus forKey:kPODetailPOStatus];
	}
	if(self.userName != nil){
		[aCoder encodeObject:self.userName forKey:kPODetailUserName];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.created = [aDecoder decodeObjectForKey:kPODetailCreated];
	self.oPNNumber = [aDecoder decodeObjectForKey:kPODetailOPNNumber];
	self.pOName = [aDecoder decodeObjectForKey:kPODetailPOName];
	self.pOStatus = [aDecoder decodeObjectForKey:kPODetailPOStatus];
	self.userName = [aDecoder decodeObjectForKey:kPODetailUserName];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	PODetail *copy = [PODetail new];

	copy.created = [self.created copy];
	copy.oPNNumber = [self.oPNNumber copy];
	copy.pOName = [self.pOName copy];
	copy.pOStatus = [self.pOStatus copy];
	copy.userName = [self.userName copy];

	return copy;
}
-(NSString *)description {
    NSMutableDictionary * dict = [NSMutableDictionary new];
    dict[@"created"] = _created;
    dict[@"oPNNumber"] = _oPNNumber;
    dict[@"pOName"] = _pOName;
    dict[@"pOStatus"] = _pOStatus;
    dict[@"userName"] = _userName;

    return [NSString stringWithFormat:@"<%@: %p, %@>",
            NSStringFromClass([self class]), self, dict.description];
}
@end
