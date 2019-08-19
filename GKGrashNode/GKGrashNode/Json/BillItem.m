//
//	Item.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BillItem.h"

NSString *const kItemI = @"I";
NSString *const kItemQ = @"Q";

@interface BillItem ()
@end
@implementation BillItem




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kItemI] isKindOfClass:[NSNull class]]){
		self.i = [dictionary[kItemI] integerValue];
	}

	if(![dictionary[kItemQ] isKindOfClass:[NSNull class]]){
		self.q = [dictionary[kItemQ] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kItemI] = @(self.i);
	dictionary[kItemQ] = @(self.q);
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
	[aCoder encodeObject:@(self.i) forKey:kItemI];	[aCoder encodeObject:@(self.q) forKey:kItemQ];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.i = [[aDecoder decodeObjectForKey:kItemI] integerValue];
	self.q = [[aDecoder decodeObjectForKey:kItemQ] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	BillItem *copy = [BillItem new];

	copy.i = self.i;
	copy.q = self.q;

	return copy;
}
@end