//
//	RootClass.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "DataObject.h"

NSString *const kRootClassBills = @"Bills";
NSString *const kRootClassDiscounts = @"Discounts";
NSString *const kRootClassItems = @"Items";

@interface DataObject ()
@end
@implementation DataObject




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kRootClassBills] != nil && [dictionary[kRootClassBills] isKindOfClass:[NSArray class]]){
		NSArray * billsDictionaries = dictionary[kRootClassBills];
		NSMutableArray * billsItems = [NSMutableArray array];
		for(NSDictionary * billsDictionary in billsDictionaries){
			Bill * billsItem = [[Bill alloc] initWithDictionary:billsDictionary];
			[billsItems addObject:billsItem];
		}
		self.bills = billsItems;
	}
	if(dictionary[kRootClassDiscounts] != nil && [dictionary[kRootClassDiscounts] isKindOfClass:[NSArray class]]){
		NSArray * discountsDictionaries = dictionary[kRootClassDiscounts];
		NSMutableArray * discountsItems = [NSMutableArray array];
		for(NSDictionary * discountsDictionary in discountsDictionaries){
			Discount * discountsItem = [[Discount alloc] initWithDictionary:discountsDictionary];
			[discountsItems addObject:discountsItem];
		}
		self.discounts = discountsItems;
	}
	if(dictionary[kRootClassItems] != nil && [dictionary[kRootClassItems] isKindOfClass:[NSArray class]]){
		NSArray * itemsDictionaries = dictionary[kRootClassItems];
		NSMutableArray * itemsItems = [NSMutableArray array];
		for(NSDictionary * itemsDictionary in itemsDictionaries){
			Item * itemsItem = [[Item alloc] initWithDictionary:itemsDictionary];
			[itemsItems addObject:itemsItem];
		}
		self.items = itemsItems;
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.bills != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Bill * billsElement in self.bills){
			[dictionaryElements addObject:[billsElement toDictionary]];
		}
		dictionary[kRootClassBills] = dictionaryElements;
	}
	if(self.discounts != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Discount * discountsElement in self.discounts){
			[dictionaryElements addObject:[discountsElement toDictionary]];
		}
		dictionary[kRootClassDiscounts] = dictionaryElements;
	}
	if(self.items != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Item * itemsElement in self.items){
			[dictionaryElements addObject:[itemsElement toDictionary]];
		}
		dictionary[kRootClassItems] = dictionaryElements;
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
	if(self.bills != nil){
		[aCoder encodeObject:self.bills forKey:kRootClassBills];
	}
	if(self.discounts != nil){
		[aCoder encodeObject:self.discounts forKey:kRootClassDiscounts];
	}
	if(self.items != nil){
		[aCoder encodeObject:self.items forKey:kRootClassItems];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.bills = [aDecoder decodeObjectForKey:kRootClassBills];
	self.discounts = [aDecoder decodeObjectForKey:kRootClassDiscounts];
	self.items = [aDecoder decodeObjectForKey:kRootClassItems];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	DataObject *copy = [DataObject new];

	copy.bills = [self.bills copy];
	copy.discounts = [self.discounts copy];
	copy.items = [self.items copy];

	return copy;
}
@end