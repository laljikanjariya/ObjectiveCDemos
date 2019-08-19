//
//	POItemDetail.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "POItemDetail.h"

NSString *const kPOItemDetailCost = @"Cost";
NSString *const kPOItemDetailItemInfo = @"ItemInfo";
NSString *const kPOItemDetailPODetail = @"PODetail";
NSString *const kPOItemDetailPrice = @"Price";
NSString *const kPOItemDetailQTYInUnit = @"QTYInUnit";
NSString *const kPOItemDetailQTYOH = @"QTYOH";
NSString *const kPOItemDetailQTYSold = @"QTYSold";
NSString *const kPOItemDetailReOrede = @"ReOrede";
NSString *const kPOItemDetailVendor = @"Vendor";
NSString *const kPOItemDetailIsSelected = @"isSelected";

@interface POItemDetail ()
@end
@implementation POItemDetail




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kPOItemDetailCost] isKindOfClass:[NSNull class]]){
		self.cost = [[POItemUnit alloc] initWithDictionary:dictionary[kPOItemDetailCost]];
	}

	if(![dictionary[kPOItemDetailItemInfo] isKindOfClass:[NSNull class]]){
		self.itemInfo = [[POItemInfo alloc] initWithDictionary:dictionary[kPOItemDetailItemInfo]];
	}

	if(![dictionary[kPOItemDetailPODetail] isKindOfClass:[NSNull class]]){
		self.pODetail = [[PODetail alloc] initWithDictionary:dictionary[kPOItemDetailPODetail]];
	}

	if(![dictionary[kPOItemDetailPrice] isKindOfClass:[NSNull class]]){
		self.price = [[POItemUnit alloc] initWithDictionary:dictionary[kPOItemDetailPrice]];
	}

	if(![dictionary[kPOItemDetailQTYInUnit] isKindOfClass:[NSNull class]]){
		self.qTYInUnit = [[POItemUnit alloc] initWithDictionary:dictionary[kPOItemDetailQTYInUnit]];
	}

	if(![dictionary[kPOItemDetailQTYOH] isKindOfClass:[NSNull class]]){
		self.qTYOH = [[POItemUnit alloc] initWithDictionary:dictionary[kPOItemDetailQTYOH]];
	}

	if(![dictionary[kPOItemDetailQTYSold] isKindOfClass:[NSNull class]]){
		self.qTYSold = [[POItemUnit alloc] initWithDictionary:dictionary[kPOItemDetailQTYSold]];
	}

	if(![dictionary[kPOItemDetailReOrede] isKindOfClass:[NSNull class]]){
		self.reOrede = [[POItemUnit alloc] initWithDictionary:dictionary[kPOItemDetailReOrede]];
	}

	if(dictionary[kPOItemDetailVendor] != nil && [dictionary[kPOItemDetailVendor] isKindOfClass:[NSArray class]]){
		NSArray * vendorDictionaries = dictionary[kPOItemDetailVendor];
		NSMutableArray * vendorItems = [NSMutableArray array];
		for(NSDictionary * vendorDictionary in vendorDictionaries){
			POVendor * vendorItem = [[POVendor alloc] initWithDictionary:vendorDictionary];
			[vendorItems addObject:vendorItem];
		}
		self.vendor = vendorItems;
	}
	if(![dictionary[kPOItemDetailIsSelected] isKindOfClass:[NSNull class]]){
		self.isSelected = [dictionary[kPOItemDetailIsSelected] boolValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.cost != nil){
		dictionary[kPOItemDetailCost] = [self.cost toDictionary];
	}
	if(self.itemInfo != nil){
		dictionary[kPOItemDetailItemInfo] = [self.itemInfo toDictionary];
	}
	if(self.pODetail != nil){
		dictionary[kPOItemDetailPODetail] = [self.pODetail toDictionary];
	}
	if(self.price != nil){
		dictionary[kPOItemDetailPrice] = [self.price toDictionary];
	}
	if(self.qTYInUnit != nil){
		dictionary[kPOItemDetailQTYInUnit] = [self.qTYInUnit toDictionary];
	}
	if(self.qTYOH != nil){
		dictionary[kPOItemDetailQTYOH] = [self.qTYOH toDictionary];
	}
	if(self.qTYSold != nil){
		dictionary[kPOItemDetailQTYSold] = [self.qTYSold toDictionary];
	}
	if(self.reOrede != nil){
		dictionary[kPOItemDetailReOrede] = [self.reOrede toDictionary];
	}
	if(self.vendor != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(POVendor * vendorElement in self.vendor){
			[dictionaryElements addObject:[vendorElement toDictionary]];
		}
		dictionary[kPOItemDetailVendor] = dictionaryElements;
	}
	dictionary[kPOItemDetailIsSelected] = @(self.isSelected);
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
	if(self.cost != nil){
		[aCoder encodeObject:self.cost forKey:kPOItemDetailCost];
	}
	if(self.itemInfo != nil){
		[aCoder encodeObject:self.itemInfo forKey:kPOItemDetailItemInfo];
	}
	if(self.pODetail != nil){
		[aCoder encodeObject:self.pODetail forKey:kPOItemDetailPODetail];
	}
	if(self.price != nil){
		[aCoder encodeObject:self.price forKey:kPOItemDetailPrice];
	}
	if(self.qTYInUnit != nil){
		[aCoder encodeObject:self.qTYInUnit forKey:kPOItemDetailQTYInUnit];
	}
	if(self.qTYOH != nil){
		[aCoder encodeObject:self.qTYOH forKey:kPOItemDetailQTYOH];
	}
	if(self.qTYSold != nil){
		[aCoder encodeObject:self.qTYSold forKey:kPOItemDetailQTYSold];
	}
	if(self.reOrede != nil){
		[aCoder encodeObject:self.reOrede forKey:kPOItemDetailReOrede];
	}
	if(self.vendor != nil){
		[aCoder encodeObject:self.vendor forKey:kPOItemDetailVendor];
	}
	[aCoder encodeObject:@(self.isSelected) forKey:kPOItemDetailIsSelected];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.cost = [aDecoder decodeObjectForKey:kPOItemDetailCost];
	self.itemInfo = [aDecoder decodeObjectForKey:kPOItemDetailItemInfo];
	self.pODetail = [aDecoder decodeObjectForKey:kPOItemDetailPODetail];
	self.price = [aDecoder decodeObjectForKey:kPOItemDetailPrice];
	self.qTYInUnit = [aDecoder decodeObjectForKey:kPOItemDetailQTYInUnit];
	self.qTYOH = [aDecoder decodeObjectForKey:kPOItemDetailQTYOH];
	self.qTYSold = [aDecoder decodeObjectForKey:kPOItemDetailQTYSold];
	self.reOrede = [aDecoder decodeObjectForKey:kPOItemDetailReOrede];
	self.vendor = [aDecoder decodeObjectForKey:kPOItemDetailVendor];
	self.isSelected = [[aDecoder decodeObjectForKey:kPOItemDetailIsSelected] boolValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	POItemDetail *copy = [POItemDetail new];

	copy.cost = [self.cost copy];
	copy.itemInfo = [self.itemInfo copy];
	copy.pODetail = [self.pODetail copy];
	copy.price = [self.price copy];
	copy.qTYInUnit = [self.qTYInUnit copy];
	copy.qTYOH = [self.qTYOH copy];
	copy.qTYSold = [self.qTYSold copy];
	copy.reOrede = [self.reOrede copy];
	copy.vendor = [self.vendor copy];
	copy.isSelected = self.isSelected;

	return copy;
}
-(NSString *)description {
    NSMutableDictionary * dict = [NSMutableDictionary new];
    dict[@"cost"] = [_cost.description stringByReplacingOccurrencesOfString:@"\n" withString:@"\r    "];
    dict[@"itemInfo"] = [_itemInfo.description stringByReplacingOccurrencesOfString:@"\n" withString:@"\r    "];
    dict[@"pODetail"] = [_pODetail.description stringByReplacingOccurrencesOfString:@"\n" withString:@"\r    "];
    dict[@"price"] = [_price.description stringByReplacingOccurrencesOfString:@"\n" withString:@"\r    "];
    dict[@"qTYInUnit"] = [_qTYInUnit.description stringByReplacingOccurrencesOfString:@"\n" withString:@"\r    "];
    dict[@"qTYOH"] = [_qTYOH.description stringByReplacingOccurrencesOfString:@"\n" withString:@"\r    "];
    dict[@"qTYSold"] = [_qTYSold.description stringByReplacingOccurrencesOfString:@"\n" withString:@"\r    "];
    dict[@"reOrede"] = [_reOrede.description stringByReplacingOccurrencesOfString:@"\n" withString:@"\r    "];
    NSString * strVenderArr = [_vendor.description stringByReplacingOccurrencesOfString:@"\\n" withString:@"\r    "];
    strVenderArr = [strVenderArr stringByReplacingOccurrencesOfString:@"\n" withString:@"\r    "];
    dict[@"vendor"] = strVenderArr;
    NSString * strDescription = [NSString stringWithFormat:@"POItemDetail %@",dict.description];
    strDescription = [strDescription stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    strDescription = [strDescription stringByReplacingOccurrencesOfString:@"\\\\\"" withString:@"\""];
    return [NSString stringWithFormat:@"<%@: %p, %@>",
            NSStringFromClass([self class]), self, strDescription];
}
@end
