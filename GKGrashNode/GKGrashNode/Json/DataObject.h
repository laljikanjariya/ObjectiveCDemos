#import <UIKit/UIKit.h>
#import "Bill.h"
#import "Discount.h"
#import "Item.h"

@interface DataObject : NSObject

@property (nonatomic, strong) NSArray * bills;
@property (nonatomic, strong) NSArray * discounts;
@property (nonatomic, strong) NSArray * items;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end