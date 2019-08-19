//
//  XMLtoObject.m
//  PumpUpdateXML
//
//  Created by Siya9 on 08/02/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "XMLtoObject.h"

@interface XMLtoObject() <NSXMLParserDelegate>
{
    NSDictionary * dictXML;
    NSDictionary * dictCurrentXML;
    NSString * strCurrentPosition;
}
@end
@implementation XMLtoObject
+(id)parseXMLtoObjectfromURL:(NSString *)strURL{
    return [XMLtoObject parseXMLtoObjectfrom:[NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]]];
}
+(id)parseXMLtoObjectfrom:(NSData *)dataXML {
    XMLtoObject * objXML = [[XMLtoObject alloc]init];
    return [objXML startParsing:dataXML];
}
-(id)startParsing:(NSData *)dataXML{
    dictXML = [NSMutableDictionary dictionary];
    strCurrentPosition = @"";
    NSXMLParser * obj = [[NSXMLParser alloc]initWithData:dataXML];
    obj.delegate = self;
    [obj parse];
    return dictXML;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if (strCurrentPosition.length == 0) {
        dictCurrentXML = dictXML;
    }
    else{
        dictCurrentXML = [dictXML valueForKeyPath:[strCurrentPosition stringByReplacingOccurrencesOfString:@"/" withString:@"."]];
    }
    strCurrentPosition = [strCurrentPosition stringByAppendingPathComponent:elementName];
    if (dictCurrentXML[elementName]) {
        if ([dictCurrentXML[elementName] isKindOfClass:[NSDictionary class]]) {
            NSMutableArray * arr = [NSMutableArray array];
            [arr addObject:dictCurrentXML[elementName]];
            [arr addObject:attributeDict];
            [dictCurrentXML setValue:arr forKey:elementName];
        }
        else{
            NSMutableArray * arr = dictCurrentXML[elementName];
            [arr addObject:attributeDict];
            [dictCurrentXML setValue:arr forKey:elementName];
        }
    }
    else{
        [dictCurrentXML setValue:attributeDict.mutableCopy forKey:elementName];
    }
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    strCurrentPosition = [strCurrentPosition stringByDeletingLastPathComponent];
}
@end
