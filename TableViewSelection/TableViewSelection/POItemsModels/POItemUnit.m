//
//	POItemUnit.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "POItemUnit.h"

NSString *const kPOItemUnitCaseField = @"Case";
NSString *const kPOItemUnitPack = @"Pack";
NSString *const kPOItemUnitSingle = @"Single";

@interface POItemUnit ()
@end
@implementation POItemUnit




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kPOItemUnitCaseField] isKindOfClass:[NSNull class]]){
		self.caseField = @([dictionary[kPOItemUnitCaseField] floatValue]);
	}

	if(![dictionary[kPOItemUnitPack] isKindOfClass:[NSNull class]]){
		self.pack = @([dictionary[kPOItemUnitPack] floatValue]);
	}

	if(![dictionary[kPOItemUnitSingle] isKindOfClass:[NSNull class]]){
		self.single = @([dictionary[kPOItemUnitSingle] floatValue]);
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kPOItemUnitCaseField] = self.caseField;
	dictionary[kPOItemUnitPack] = self.pack;
	dictionary[kPOItemUnitSingle] = self.single;
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
	[aCoder encodeObject:self.caseField forKey:kPOItemUnitCaseField];	[aCoder encodeObject:self.pack forKey:kPOItemUnitPack];	[aCoder encodeObject:self.single forKey:kPOItemUnitSingle];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.caseField = @([[aDecoder decodeObjectForKey:kPOItemUnitCaseField] floatValue]);
	self.pack = @([[aDecoder decodeObjectForKey:kPOItemUnitPack] floatValue]);
	self.single = @([[aDecoder decodeObjectForKey:kPOItemUnitSingle] floatValue]);
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	POItemUnit *copy = [POItemUnit new];

	copy.caseField = self.caseField;
	copy.pack = self.pack;
	copy.single = self.single;

	return copy;
}
-(NSString *)description {
    NSMutableDictionary * dict = [NSMutableDictionary new];
    dict[@"case"] = _caseField;
    dict[@"pack"] = _pack;
    dict[@"single"] = _single;
    return [NSString stringWithFormat:@"<%@: %p, %@>",
            NSStringFromClass([self class]), self, dict.description];
}
//-(NSString *)description
//{
//    return [NSString stringWithFormat:@"<%@: %p, ID: %@>",
//            NSStringFromClass([self class]), self, [self single]];
//}
@end
