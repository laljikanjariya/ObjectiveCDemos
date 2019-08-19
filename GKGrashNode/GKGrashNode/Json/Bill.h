#import <UIKit/UIKit.h>
#import "BillItem.h"

@interface Bill : NSObject

@property (nonatomic, assign) NSInteger bill;
@property (nonatomic, strong) NSArray * items;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end