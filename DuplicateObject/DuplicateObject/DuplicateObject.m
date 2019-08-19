//
//  DuplicateObject.m
//  DuplicateObject
//
//  Created by Siya Infotech on 26/11/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import "DuplicateObject.h"

@implementation DuplicateObject
-(id)createDublicateobjectFrom:(id)object{
    if ([object isKindOfClass:[NSArray class]]){
        return [self createDublicateArrayFrom:object];
    }
    else if ([object isKindOfClass:[NSDictionary class]]){
        return [self createDublicateDictionaryFrom:object];
    }
    else if ([object isKindOfClass:[NSString class]]){
        return [self createDublicateStringFrom:object];
    }
    else if ([object isKindOfClass:[NSNumber class]]){
        return [self createDublicateNumberFrom:object];
    }
    return nil;
}
#pragma mark - duplicate create -
-(id)createDublicateArrayFrom:(id)object{
    NSMutableArray * arrNewObject = [[NSMutableArray alloc]init];
    for (id subobject in object) {
        [arrNewObject addObject:[self createDublicateobjectFrom:subobject]];
    }
    return arrNewObject;
}
-(id)createDublicateDictionaryFrom:(id)object{
    NSMutableDictionary * dictNewObject =[[NSMutableDictionary alloc]init];
    NSArray * arrAllkeys = [object allKeys];
    for (NSString * strKey in arrAllkeys) {
        [dictNewObject setObject:[self createDublicateobjectFrom:[object objectForKey:strKey]] forKey:strKey];
    }
    return dictNewObject;
}
-(id)createDublicateStringFrom:(id)object{
    return [NSString stringWithFormat:@"%@",object];
}
-(id)createDublicateNumberFrom:(NSNumber *)object{
    return object;
}
@end
