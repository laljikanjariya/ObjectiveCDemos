//
//	Bill.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Bill.h"

NSString *const kBillBill = @"Bill";
NSString *const kBillItems = @"Items";

@interface Bill ()
@end
@implementation Bill




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kBillBill] isKindOfClass:[NSNull class]]){
		self.bill = [dictionary[kBillBill] integerValue];
	}

	if(dictionary[kBillItems] != nil && [dictionary[kBillItems] isKindOfClass:[NSArray class]]){
		NSArray * itemsDictionaries = dictionary[kBillItems];
		NSMutableArray * itemsItems = [NSMutableArray array];
		for(NSDictionary * itemsDictionary in itemsDictionaries){
			BillItem * billitem = [[BillItem alloc] initWithDictionary:itemsDictionary];
			[itemsItems addObject:billitem];
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
	dictionary[kBillBill] = @(self.bill);
	if(self.items != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(BillItem * itemsElement in self.items){
			[dictionaryElements addObject:[itemsElement toDictionary]];
		}
		dictionary[kBillItems] = dictionaryElements;
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
	[aCoder encodeObject:@(self.bill) forKey:kBillBill];	if(self.items != nil){
		[aCoder encodeObject:self.items forKey:kBillItems];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.bill = [[aDecoder decodeObjectForKey:kBillBill] integerValue];
	self.items = [aDecoder decodeObjectForKey:kBillItems];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Bill *copy = [Bill new];

	copy.bill = self.bill;
	copy.items = [self.items copy];

	return copy;
}
@end