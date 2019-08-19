//
//	RootClass.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Item.h"

NSString *const kRootClassCode = @"Code";
NSString *const kRootClassName = @"Name";
NSString *const kRootClassSinglePrice = @"SinglePrice";

@interface Item ()
@end
@implementation Item




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kRootClassCode] isKindOfClass:[NSNull class]]){
		self.code = [dictionary[kRootClassCode] integerValue];
	}

	if(![dictionary[kRootClassName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kRootClassName];
	}	
	if(![dictionary[kRootClassSinglePrice] isKindOfClass:[NSNull class]]){
		self.singlePrice = [dictionary[kRootClassSinglePrice] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kRootClassCode] = @(self.code);
	if(self.name != nil){
		dictionary[kRootClassName] = self.name;
	}
	dictionary[kRootClassSinglePrice] = @(self.singlePrice);
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
	[aCoder encodeObject:@(self.code) forKey:kRootClassCode];	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kRootClassName];
	}
	[aCoder encodeObject:@(self.singlePrice) forKey:kRootClassSinglePrice];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.code = [[aDecoder decodeObjectForKey:kRootClassCode] integerValue];
	self.name = [aDecoder decodeObjectForKey:kRootClassName];
	self.singlePrice = [[aDecoder decodeObjectForKey:kRootClassSinglePrice] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Item *copy = [Item new];

	copy.code = self.code;
	copy.name = [self.name copy];
	copy.singlePrice = self.singlePrice;

	return copy;
}
@end