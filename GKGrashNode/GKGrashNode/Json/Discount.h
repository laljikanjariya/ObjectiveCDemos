#import <UIKit/UIKit.h>

@interface Discount : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger primaryItemCode;
@property (nonatomic, assign) NSInteger primaryQty;
@property (nonatomic, assign) NSInteger secondaryQty;
@property (nonatomic, assign) NSInteger value;
@property (nonatomic, assign) NSInteger yItem;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end