//
//	POItemListData.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "POItemListData.h"

NSString *const kPOItemListDataPOItemDetail = @"POItemDetail";

@interface POItemListData ()
@end
@implementation POItemListData




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kPOItemListDataPOItemDetail] != nil && [dictionary[kPOItemListDataPOItemDetail] isKindOfClass:[NSArray class]]){
		NSArray * pOItemDetailDictionaries = dictionary[kPOItemListDataPOItemDetail];
		NSMutableArray * pOItemDetailItems = [NSMutableArray array];
		for(NSDictionary * pOItemDetailDictionary in pOItemDetailDictionaries){
			POItemDetail * pOItemDetailItem = [[POItemDetail alloc] initWithDictionary:pOItemDetailDictionary];
			[pOItemDetailItems addObject:pOItemDetailItem];
		}
		self.pOItemDetail = pOItemDetailItems;
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.pOItemDetail != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(POItemDetail * pOItemDetailElement in self.pOItemDetail){
			[dictionaryElements addObject:[pOItemDetailElement toDictionary]];
		}
		dictionary[kPOItemListDataPOItemDetail] = dictionaryElements;
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
	if(self.pOItemDetail != nil){
		[aCoder encodeObject:self.pOItemDetail forKey:kPOItemListDataPOItemDetail];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.pOItemDetail = [aDecoder decodeObjectForKey:kPOItemListDataPOItemDetail];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	POItemListData *copy = [POItemListData new];

	copy.pOItemDetail = [self.pOItemDetail copy];

	return copy;
}
-(NSString *)description {
    
    NSString * strPOItemDetail = [self.pOItemDetail.description stringByReplacingOccurrencesOfString:@"\\n" withString:@"\r    "];
    strPOItemDetail = [strPOItemDetail stringByReplacingOccurrencesOfString:@"\n" withString:@"\r    "];

    strPOItemDetail = [strPOItemDetail stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    strPOItemDetail = [strPOItemDetail stringByReplacingOccurrencesOfString:@"\\\\\"" withString:@"\""];
    strPOItemDetail = [strPOItemDetail stringByReplacingOccurrencesOfString:@"        \"POItemDetail" withString:@"\"POItemDetail"];

    
    return [NSString stringWithFormat:@"<%@: %p, %@>",
            NSStringFromClass([self class]), self, strPOItemDetail];
}
@end
