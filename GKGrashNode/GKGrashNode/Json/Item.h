#import <UIKit/UIKit.h>

@interface Item : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger singlePrice;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end