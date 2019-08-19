#import <UIKit/UIKit.h>
#import "POItemDetail.h"

@interface POItemListData : NSObject

@property (nonatomic, strong) NSArray<POItemDetail *>* pOItemDetail;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
