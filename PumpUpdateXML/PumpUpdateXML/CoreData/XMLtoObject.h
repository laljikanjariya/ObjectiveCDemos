//
//  XMLtoObject.h
//  PumpUpdateXML
//
//  Created by Siya9 on 08/02/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLtoObject : NSObject

+(id)parseXMLtoObjectfromURL:(NSString *)strURL;
+(id)parseXMLtoObjectfrom:(NSData *)dataXML;
@end
