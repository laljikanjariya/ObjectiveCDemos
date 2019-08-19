//
//  RIMExpandTableModel.h
//  ExpandebleTableView
//
//  Created by Lalji on 11/07/19.
//  Copyright © 2019 Lalji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, RIMExpandChangeType) {
    RIMExpandChangeTypeInsert = 1,
    RIMExpandChangeTypeDelete = 2,
};
@protocol RIMExpandChangeTypeDelegate <NSObject>
@required
- (void)updateModelRowWillChangeContent;
- (void)updateModelRowChangeType:(RIMExpandChangeType)type forIndexPaths:(NSArray <NSIndexPath *>*)arrIndexPath;
- (void)updateModelRowDidChangeContent;
@end
@class RIMExpandTableSectionModel, RIMExpandTableRowModel;
@interface RIMExpandTableModel : NSObject
- (instancetype)initWithDelegate:(id<RIMExpandChangeTypeDelegate>)delegate;
- (void)addNewSection:(NSDictionary *)section isOpend:(BOOL)isOpen withSectionRowData:(NSArray *)arrRowData;
- (NSInteger)numberOfSectionsInTableModel;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (RIMExpandTableSectionModel *)sectionAtIndex:(NSInteger)section;
- (RIMExpandTableRowModel *)rowAtIndexPath:(NSIndexPath *)indexPath;
- (void)expandCollapseSection:(NSInteger)section;
@end

/**
 Table Model section data
 */
@interface RIMExpandTableSectionModel : NSObject
@property (nonatomic, strong, readonly) NSDictionary * sectionData;
@property (nonatomic, assign, readonly) BOOL isOpen;

- (instancetype)initWithData:(NSDictionary *)section isOpend:(BOOL)isOpen withSectionRowData:(NSArray *)arrRowData;
- (NSInteger)numberOfRowsInSection;
- (NSInteger)getAllNumberOfRowsInSection;
- (RIMExpandTableRowModel *)rowAtIndex:(NSInteger)index;
- (void)expandCollapseSection;
@end

/**
 Table Model Row data
 */
@interface RIMExpandTableRowModel : NSObject
@property (nonatomic, strong, readonly) NSDictionary * rowData;
- (instancetype)initWithData:(NSDictionary *)row;
@end
NS_ASSUME_NONNULL_END
