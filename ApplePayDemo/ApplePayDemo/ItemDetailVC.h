//
//  ItemDetailVC.h
//  ApplePayDemo
//
//  Created by Siya Infotech on 02/12/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PassKit/PassKit.h>

@interface ItemDetailVC : UIViewController<PKPaymentAuthorizationViewControllerDelegate>

@property (nonatomic, weak) NSDictionary * dictItem;
@end
