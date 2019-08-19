//
//  Test+CoreDataProperties.m
//  CoreDataMigrations
//
//  Created by Lalji on 19/05/18.
//  Copyright © 2018 Lalji. All rights reserved.
//
//

#import "Test+CoreDataProperties.h"

@implementation Test (CoreDataProperties)

+ (NSFetchRequest<Test *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Test"];
}

@dynamic name;
@dynamic ssss;

@end
