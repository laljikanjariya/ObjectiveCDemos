//
//  CustomLayoutDemo.h
//  UICollectionViewFlowDemo
//
//  Created by Siya9 on 28/09/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomLayoutDelegate<NSObject>
    - (float)collectionView:(UICollectionView *)collectionView heightForItemAtIndexPath:(NSIndexPath *)indexPath;
    - (NSInteger)numberOfCulumnInCollectionView:(UICollectionView *)collectionView;
@end
@interface CustomLayoutDemo : UICollectionViewLayout

@property (nonatomic, weak) id<CustomLayoutDelegate> delegate;
@property (nonatomic, assign) float cellPadding;
@end
