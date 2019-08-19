//
//	POVendor.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "POVendor.h"

NSString *const kPOVendorVendorID = @"VendorID";
NSString *const kPOVendorVendorName = @"VendorName";

@interface POVendor ()
@end
@implementation POVendor




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kPOVendorVendorID] isKindOfClass:[NSNull class]]){
		self.vendorID = @([dictionary[kPOVendorVendorID] integerValue]);
	}

	if(![dictionary[kPOVendorVendorName] isKindOfClass:[NSNull class]]){
		self.vendorName = dictionary[kPOVendorVendorName];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kPOVendorVendorID] = self.vendorID;
	if(self.vendorName != nil){
		dictionary[kPOVendorVendorName] = self.vendorName;
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
	[aCoder encodeObject:self.vendorID forKey:kPOVendorVendorID];	if(self.vendorName != nil){
		[aCoder encodeObject:self.vendorName forKey:kPOVendorVendorName];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.vendorID = @([[aDecoder decodeObjectForKey:kPOVendorVendorID] integerValue]);
	self.vendorName = [aDecoder decodeObjectForKey:kPOVendorVendorName];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	POVendor *copy = [POVendor new];

	copy.vendorID = self.vendorID.copy;
	copy.vendorName = [self.vendorName copy];

	return copy;
}
-(NSString *)description {
    NSMutableDictionary * dict = [NSMutableDictionary new];
    dict[@"vendorID"] = _vendorID;
    dict[@"vendorName"] = _vendorName;
    
    return [NSString stringWithFormat:@"<%@: %p, %@>",
            NSStringFromClass([self class]), self, dict.description];
}
@end
