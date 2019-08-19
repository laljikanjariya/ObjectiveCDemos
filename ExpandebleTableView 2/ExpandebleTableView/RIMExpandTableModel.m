//
//  RIMExpandTableModel.m
//  ExpandebleTableView
//
//  Created by Lalji on 11/07/19.
//  Copyright © 2019 Lalji. All rights reserved.
//

#import "RIMExpandTableModel.h"
#import <UIKit/UIKit.h>

@interface RIMExpandTableModel()
@property (nonatomic, weak) id<RIMExpandChangeTypeDelegate> delegate;
@property (nonatomic, strong, readwrite) NSMutableArray <RIMExpandTableSectionModel *>* sectionsData;
@end


@implementation RIMExpandTableModel
- (instancetype)initWithDelegate:(id<RIMExpandChangeTypeDelegate>)delegate{
    self = [super init];
    if (self) {
        self.sectionsData = [NSMutableArray new];
        self.delegate = delegate;
    }
    return self;
}
- (void)addNewSection:(NSDictionary *)section isOpend:(BOOL)isOpen withSectionRowData:(NSArray *)arrRowData{
    RIMExpandTableSectionModel * sectionObject = [[RIMExpandTableSectionModel alloc]initWithData:section isOpend:isOpen withSectionRowData:arrRowData];
    [self.sectionsData addObject:sectionObject];
}
- (NSInteger)numberOfSectionsInTableModel {
    return self.sectionsData.count;
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    RIMExpandTableSectionModel * sectionObject = [self sectionAtIndex:section];
    return [sectionObject numberOfRowsInSection];
}
- (RIMExpandTableSectionModel *)sectionAtIndex:(NSInteger)section {
    return self.sectionsData[section];
}
- (RIMExpandTableRowModel *)rowAtIndexPath:(NSIndexPath *)indexPath {
    RIMExpandTableSectionModel * sectionObject = [self sectionAtIndex:indexPath.section];
    return [sectionObject rowAtIndex:indexPath.row];
}
- (void)expandCollapseSection:(NSInteger)section{
    [self.delegate updateModelRowWillChangeContent];
    RIMExpandTableSectionModel * sectionObject = [self sectionAtIndex:section];
    [sectionObject expandCollapseSection];
    NSUInteger allRow = [sectionObject getAllNumberOfRowsInSection];
    RIMExpandChangeType type;
    NSMutableArray <NSIndexPath *>* arrIndexPaths = [NSMutableArray new];
    if (sectionObject.isOpen) {
        type = RIMExpandChangeTypeInsert;
        for (int i = 0; i < allRow; i++) {
            [arrIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
        }
    }
    else {
        type = RIMExpandChangeTypeDelete;
        for (int i = (int)allRow-1; i >= 0; i--) {
            [arrIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
        }
    }
    [self.delegate updateModelRowChangeType:type forIndexPaths:arrIndexPaths];
    [self.delegate updateModelRowDidChangeContent];
}
@end




@interface RIMExpandTableSectionModel()
@property (nonatomic, strong, readwrite) NSDictionary * sectionData;
@property (nonatomic, assign, readwrite) BOOL isOpen;
@property (nonatomic, strong, readwrite) NSArray <RIMExpandTableRowModel *>* rowData;
@end

@implementation RIMExpandTableSectionModel
- (instancetype)initWithData:(NSDictionary *)section isOpend:(BOOL)isOpen withSectionRowData:(NSArray *)arrRowData {
    self = [super init];
    if (self) {
        self.sectionData = section;
        self.isOpen = isOpen;
        NSMutableArray <RIMExpandTableRowModel *>* arrRows = [NSMutableArray new];
        for (NSDictionary * dictRowData in arrRowData) {
            [arrRows addObject:[[RIMExpandTableRowModel alloc]initWithData:dictRowData]];
        }
        self.rowData = arrRows.copy;
    }
    return self;
}
- (NSInteger)numberOfRowsInSection {
    if (self.isOpen) {
        return self.rowData.count;
    }
    else{
        return 0;
    }
}
- (NSInteger)getAllNumberOfRowsInSection {
    return self.rowData.count;
}
-(RIMExpandTableRowModel *)rowAtIndex:(NSInteger)index {
    return self.rowData[index];
}
- (void)expandCollapseSection{
    self.isOpen = !self.isOpen;
}
@end

/**
 Table Model Row data
 */
@interface RIMExpandTableRowModel()
@property (nonatomic, strong, readwrite) NSDictionary * rowData;
@end

@implementation RIMExpandTableRowModel
- (instancetype)initWithData:(NSDictionary *)row{
    self = [super init];
    if (self) {
        self.rowData = row;
    }
    return self;
}
@end
