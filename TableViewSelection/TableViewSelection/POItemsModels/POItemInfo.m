//
//	POItemInfo.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "POItemInfo.h"

NSString *const kPOItemInfoItemCode = @"ItemCode";
NSString *const kPOItemInfoItemImageURL = @"ItemImageURL";
NSString *const kPOItemInfoItemMax = @"ItemMax";
NSString *const kPOItemInfoItemMin = @"ItemMin";
NSString *const kPOItemInfoItemName = @"ItemName";
NSString *const kPOItemInfoItemNo = @"ItemNo";
NSString *const kPOItemInfoItemType = @"ItemType";

@interface POItemInfo ()
@end
@implementation POItemInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kPOItemInfoItemCode] isKindOfClass:[NSNull class]]){
		self.itemCode = @([dictionary[kPOItemInfoItemCode] floatValue]);
	}

	if(![dictionary[kPOItemInfoItemImageURL] isKindOfClass:[NSNull class]]){
		self.itemImageURL = dictionary[kPOItemInfoItemImageURL];
	}	
	if(![dictionary[kPOItemInfoItemMax] isKindOfClass:[NSNull class]]){
		self.itemMax = @([dictionary[kPOItemInfoItemMax] floatValue]);
	}

	if(![dictionary[kPOItemInfoItemMin] isKindOfClass:[NSNull class]]){
		self.itemMin = @([dictionary[kPOItemInfoItemMin] floatValue]);
	}

	if(![dictionary[kPOItemInfoItemName] isKindOfClass:[NSNull class]]){
		self.itemName = dictionary[kPOItemInfoItemName];
	}	
	if(![dictionary[kPOItemInfoItemNo] isKindOfClass:[NSNull class]]){
		self.itemNo = dictionary[kPOItemInfoItemNo];
	}	
	if(![dictionary[kPOItemInfoItemType] isKindOfClass:[NSNull class]]){
		self.itemType = dictionary[kPOItemInfoItemType];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kPOItemInfoItemCode] = self.itemCode;
	if(self.itemImageURL != nil){
		dictionary[kPOItemInfoItemImageURL] = self.itemImageURL;
	}
	dictionary[kPOItemInfoItemMax] = self.itemMax;
	dictionary[kPOItemInfoItemMin] = self.itemMin;
	if(self.itemName != nil){
		dictionary[kPOItemInfoItemName] = self.itemName;
	}
	if(self.itemNo != nil){
		dictionary[kPOItemInfoItemNo] = self.itemNo;
	}
	if(self.itemType != nil){
		dictionary[kPOItemInfoItemType] = self.itemType;
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
	[aCoder encodeObject:self.itemCode forKey:kPOItemInfoItemCode];	if(self.itemImageURL != nil){
		[aCoder encodeObject:self.itemImageURL forKey:kPOItemInfoItemImageURL];
	}
	[aCoder encodeObject:self.itemMax forKey:kPOItemInfoItemMax];
    [aCoder encodeObject:self.itemMin forKey:kPOItemInfoItemMin];
    if(self.itemName != nil){
		[aCoder encodeObject:self.itemName forKey:kPOItemInfoItemName];
	}
	if(self.itemNo != nil){
		[aCoder encodeObject:self.itemNo forKey:kPOItemInfoItemNo];
	}
	if(self.itemType != nil){
		[aCoder encodeObject:self.itemType forKey:kPOItemInfoItemType];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.itemCode = @([[aDecoder decodeObjectForKey:kPOItemInfoItemCode] integerValue]);
	self.itemImageURL = [aDecoder decodeObjectForKey:kPOItemInfoItemImageURL];
	self.itemMax = @([[aDecoder decodeObjectForKey:kPOItemInfoItemMax] integerValue]);
	self.itemMin = @([[aDecoder decodeObjectForKey:kPOItemInfoItemMin] integerValue]);
	self.itemName = [aDecoder decodeObjectForKey:kPOItemInfoItemName];
	self.itemNo = [aDecoder decodeObjectForKey:kPOItemInfoItemNo];
	self.itemType = [aDecoder decodeObjectForKey:kPOItemInfoItemType];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	POItemInfo *copy = [POItemInfo new];

	copy.itemCode = self.itemCode.copy;
	copy.itemImageURL = [self.itemImageURL copy];
	copy.itemMax = self.itemMax.copy;
	copy.itemMin = self.itemMin.copy;
	copy.itemName = [self.itemName copy];
	copy.itemNo = [self.itemNo copy];
	copy.itemType = [self.itemType copy];

	return copy;
}
-(NSString *)description {
    NSMutableDictionary * dict = [NSMutableDictionary new];
    dict[@"itemCode"] = _itemCode;
    dict[@"itemImageURL"] = _itemImageURL;
    dict[@"itemMax"] = _itemMax;
    dict[@"itemMin"] = _itemMin;
    dict[@"itemName"] = _itemName;
    dict[@"itemNo"] = _itemNo;
    dict[@"itemType"] = _itemType;
    
    return [NSString stringWithFormat:@"<%@: %p, %@>",
            NSStringFromClass([self class]), self, dict.description];
}
@end
