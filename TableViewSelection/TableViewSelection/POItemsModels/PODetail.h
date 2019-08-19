#import <UIKit/UIKit.h>

@interface PODetail : NSObject

@property (nonatomic, strong) NSString * created;
@property (nonatomic, strong) NSString * oPNNumber;
@property (nonatomic, strong) NSString * pOName;
@property (nonatomic, strong) NSString * pOStatus;
@property (nonatomic, strong) NSString * userName;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
