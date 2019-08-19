#import <UIKit/UIKit.h>

@interface POVendor : NSObject

@property (nonatomic, strong) NSNumber * vendorID;
@property (nonatomic, strong) NSString * vendorName;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
