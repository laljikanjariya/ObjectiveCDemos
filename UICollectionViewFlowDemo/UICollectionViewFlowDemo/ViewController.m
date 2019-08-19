//
//  ViewController.m
//  UICollectionViewFlowDemo
//
//  Created by Siya9 on 28/09/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "ViewController.h"
#import "CustomLayoutDemo.h"

@interface ViewController ()<CustomLayoutDelegate>{
    NSArray * arrItems;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * strPath = [[NSBundle mainBundle]pathForResource:@"Photos" ofType:@"plist"];
    arrItems = [[NSArray alloc]initWithContentsOfURL:[NSURL fileURLWithPath:strPath]];
    if ([self.collectionView.collectionViewLayout isKindOfClass:[CustomLayoutDemo class]]) {
        CustomLayoutDemo * layout = (CustomLayoutDemo *)self.collectionView.collectionViewLayout;
        layout.delegate = self;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>
    
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return arrItems.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}
@end
