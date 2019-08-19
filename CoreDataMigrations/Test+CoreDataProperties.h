//
//  Test+CoreDataProperties.h
//  CoreDataMigrations
//
//  Created by Lalji on 19/05/18.
//  Copyright © 2018 Lalji. All rights reserved.
//
//

#import "Test+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Test (CoreDataProperties)

+ (NSFetchRequest<Test *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *ssss;

@end

NS_ASSUME_NONNULL_END
