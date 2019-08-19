#import <UIKit/UIKit.h>
#import "POItemUnit.h"
#import "POItemInfo.h"
#import "PODetail.h"
#import "POVendor.h"

@interface POItemDetail : NSObject

@property (nonatomic, strong) POItemUnit * cost;
@property (nonatomic, strong) POItemInfo * itemInfo;
@property (nonatomic, strong) PODetail * pODetail;
@property (nonatomic, strong) POItemUnit * price;
@property (nonatomic, strong) POItemUnit * qTYInUnit;
@property (nonatomic, strong) POItemUnit * qTYOH;
@property (nonatomic, strong) POItemUnit * qTYSold;
@property (nonatomic, strong) POItemUnit * reOrede;
@property (nonatomic, strong) NSArray<POVendor *>* vendor;
@property (nonatomic, assign) BOOL isSelected;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
