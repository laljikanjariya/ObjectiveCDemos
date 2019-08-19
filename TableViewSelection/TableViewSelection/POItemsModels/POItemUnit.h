#import <UIKit/UIKit.h>

@interface POItemUnit : NSObject

@property (nonatomic, strong) NSNumber * caseField;
@property (nonatomic, strong) NSNumber * pack;
@property (nonatomic, strong) NSNumber * single;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
