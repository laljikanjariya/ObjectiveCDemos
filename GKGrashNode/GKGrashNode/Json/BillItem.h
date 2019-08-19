#import <UIKit/UIKit.h>

@interface BillItem : NSObject

@property (nonatomic, assign) NSInteger i;
@property (nonatomic, assign) NSInteger q;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end