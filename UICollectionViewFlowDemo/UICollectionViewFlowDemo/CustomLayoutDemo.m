//
//  CustomLayoutDemo.m
//  UICollectionViewFlowDemo
//
//  Created by Siya9 on 28/09/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "CustomLayoutDemo.h"

@implementation CustomLayoutDemo{
    int numberOfColumns;
    float contentHeight;
    NSMutableArray<UICollectionViewLayoutAttributes *> * attributes;
}
-(float)contentWidth{
    UIEdgeInsets insets = self.collectionView.contentInset;
    return self.collectionView.bounds.size.width - (insets.left + insets.right);

}
-(CGSize)collectionViewContentSize{
    return CGSizeMake(self.contentWidth, contentHeight);
}
-(void)prepareLayout{
    
}
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray <UICollectionViewLayoutAttributes *> *visibleLayoutAttributes = [NSMutableArray new];
    
    for (UICollectionViewLayoutAttributes * attribut in attributes) {
        if (attribut.frame)
    }
//    // Loop through the cache and look for items in the rect
//    for attributes in cache {
//        if attributes.frame.intersects(rect) {
//            visibleLayoutAttributes.append(attributes)
//        }
//    }
    return visibleLayoutAttributes
}
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
        
}
@end
