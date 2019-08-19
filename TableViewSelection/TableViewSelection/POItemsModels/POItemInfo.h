#import <UIKit/UIKit.h>

@interface POItemInfo : NSObject

@property (nonatomic, strong) NSNumber * itemCode;
@property (nonatomic, strong) NSString * itemImageURL;
@property (nonatomic, strong) NSNumber * itemMax;
@property (nonatomic, strong) NSNumber * itemMin;
@property (nonatomic, strong) NSString * itemName;
@property (nonatomic, strong) NSString * itemNo;
@property (nonatomic, strong) NSString * itemType;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
