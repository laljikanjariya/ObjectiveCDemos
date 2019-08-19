//
//	Discount.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Discount.h"

NSString *const kDiscountCode = @"Code";
NSString *const kDiscountName = @"Name";
NSString *const kDiscountPrimaryItemCode = @"PrimaryItemCode";
NSString *const kDiscountPrimaryQty = @"PrimaryQty";
NSString *const kDiscountSecondaryQty = @"SecondaryQty";
NSString *const kDiscountValue = @"Value";
NSString *const kDiscountYItem = @"YItem";

@interface Discount ()
@end
@implementation Discount




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kDiscountCode] isKindOfClass:[NSNull class]]){
		self.code = [dictionary[kDiscountCode] integerValue];
	}

	if(![dictionary[kDiscountName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kDiscountName];
	}	
	if(![dictionary[kDiscountPrimaryItemCode] isKindOfClass:[NSNull class]]){
		self.primaryItemCode = [dictionary[kDiscountPrimaryItemCode] integerValue];
	}

	if(![dictionary[kDiscountPrimaryQty] isKindOfClass:[NSNull class]]){
		self.primaryQty = [dictionary[kDiscountPrimaryQty] integerValue];
	}

	if(![dictionary[kDiscountSecondaryQty] isKindOfClass:[NSNull class]]){
		self.secondaryQty = [dictionary[kDiscountSecondaryQty] integerValue];
	}

	if(![dictionary[kDiscountValue] isKindOfClass:[NSNull class]]){
		self.value = [dictionary[kDiscountValue] integerValue];
	}

	if(![dictionary[kDiscountYItem] isKindOfClass:[NSNull class]]){
		self.yItem = [dictionary[kDiscountYItem] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kDiscountCode] = @(self.code);
	if(self.name != nil){
		dictionary[kDiscountName] = self.name;
	}
	dictionary[kDiscountPrimaryItemCode] = @(self.primaryItemCode);
	dictionary[kDiscountPrimaryQty] = @(self.primaryQty);
	dictionary[kDiscountSecondaryQty] = @(self.secondaryQty);
	dictionary[kDiscountValue] = @(self.value);
	dictionary[kDiscountYItem] = @(self.yItem);
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
	[aCoder encodeObject:@(self.code) forKey:kDiscountCode];	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kDiscountName];
	}
	[aCoder encodeObject:@(self.primaryItemCode) forKey:kDiscountPrimaryItemCode];	[aCoder encodeObject:@(self.primaryQty) forKey:kDiscountPrimaryQty];	[aCoder encodeObject:@(self.secondaryQty) forKey:kDiscountSecondaryQty];	[aCoder encodeObject:@(self.value) forKey:kDiscountValue];	[aCoder encodeObject:@(self.yItem) forKey:kDiscountYItem];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.code = [[aDecoder decodeObjectForKey:kDiscountCode] integerValue];
	self.name = [aDecoder decodeObjectForKey:kDiscountName];
	self.primaryItemCode = [[aDecoder decodeObjectForKey:kDiscountPrimaryItemCode] integerValue];
	self.primaryQty = [[aDecoder decodeObjectForKey:kDiscountPrimaryQty] integerValue];
	self.secondaryQty = [[aDecoder decodeObjectForKey:kDiscountSecondaryQty] integerValue];
	self.value = [[aDecoder decodeObjectForKey:kDiscountValue] integerValue];
	self.yItem = [[aDecoder decodeObjectForKey:kDiscountYItem] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Discount *copy = [Discount new];

	copy.code = self.code;
	copy.name = [self.name copy];
	copy.primaryItemCode = self.primaryItemCode;
	copy.primaryQty = self.primaryQty;
	copy.secondaryQty = self.secondaryQty;
	copy.value = self.value;
	copy.yItem = self.yItem;

	return copy;
}
@end