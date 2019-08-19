//
//  ItemDetailVC.m
//  ApplePayDemo
//
//  Created by Siya Infotech on 02/12/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import "ItemDetailVC.h"
#import "PayMentDetailVC.h"

@interface ItemDetailVC ()
{
    IBOutlet UIImageView * imgItemImage;
    IBOutlet UILabel * lblItemName;
    IBOutlet UILabel * lblItemPride;
    IBOutlet UILabel * lblIteMDetail;
    IBOutlet UIButton * btnApplePay;
}

@end

@implementation ItemDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    imgItemImage.image = [UIImage imageNamed:[self.dictItem valueForKey:@"named"]];
    lblItemName.text = [self.dictItem valueForKey:@"title"];
    lblItemPride.text = [self.dictItem valueForKey:@"price"];
    lblIteMDetail.text = [self.dictItem valueForKey:@"description"];
//    [btnApplePay addTarget:self action:@selector(btnApplePay:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)viewDidAppear:(BOOL)animated {
    PKPaymentButton * paymentButton = [[PKPaymentButton alloc]initWithPaymentButtonType:PKPaymentButtonTypeBuy paymentButtonStyle:PKPaymentButtonStyleBlack];
    [paymentButton setFrame:btnApplePay.frame];
    [paymentButton addTarget:self action:@selector(btnApplePay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:paymentButton];
    [btnApplePay removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)btnApplePay:(id)sender{
    if ([PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:@[PKPaymentNetworkAmex,PKPaymentNetworkDiscover,PKPaymentNetworkMasterCard,PKPaymentNetworkPrivateLabel,PKPaymentNetworkVisa]]) {
        
        PKPaymentRequest * request = [[PKPaymentRequest alloc] init];
        request.merchantIdentifier = @"merchant.com.siya.applepaydemo.merchantid";
        request.countryCode = @"US";
        request.currencyCode = @"USD";
        request.merchantCapabilities = PKMerchantCapability3DS;
        request.supportedNetworks = @[PKPaymentNetworkAmex,PKPaymentNetworkVisa];
        float price = [[self.dictItem valueForKey:@"price"] floatValue];
        float tax = (price * 4)/100;
        
        PKPaymentSummaryItem * itemPrice = [PKPaymentSummaryItem summaryItemWithLabel:[self.dictItem valueForKey:@"title"] amount:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",price]] type:PKPaymentSummaryItemTypeFinal];
        
        PKPaymentSummaryItem * itemTax = [PKPaymentSummaryItem summaryItemWithLabel:@"tax" amount:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",tax]] type:PKPaymentSummaryItemTypeFinal];
        
        PKPaymentSummaryItem * itemTotalCost = [PKPaymentSummaryItem summaryItemWithLabel:@"Total" amount:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",price+tax]] type:PKPaymentSummaryItemTypeFinal];

        request.paymentSummaryItems = @[itemPrice,itemTax,itemTotalCost];
        
        request.requiredShippingAddressFields = PKAddressFieldPostalAddress | PKAddressFieldEmail | PKAddressFieldPhone;
        request.requiredBillingAddressFields = PKAddressFieldPostalAddress | PKAddressFieldEmail;
        
        
        PKPaymentAuthorizationViewController * objVC = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:request];
        objVC.delegate = self;
//        objVC
        [self presentViewController:objVC animated:YES completion:nil];
        
    }
}

// Sent to the delegate after the user has acted on the payment request.  The application
// should inspect the payment to determine whether the payment request was authorized.
//
// If the application requested a shipping address then the full addresses is now part of the payment.
//
// The delegate must call completion with an appropriate authorization status, as may be determined
// by submitting the payment credential to a processing gateway for payment authorization.
- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                       didAuthorizePayment:(PKPayment *)payment
                                completion:(void (^)(PKPaymentAuthorizationStatus status))completion{
    
    NSLog(@"%@",[[NSString alloc]initWithData:payment.token.paymentData encoding:NSUTF8StringEncoding]);
    completion(PKPaymentAuthorizationStatusSuccess);

    PayMentDetailVC * payMentDetailVC =
    [[UIStoryboard storyboardWithName:@"Main"
                               bundle:NULL] instantiateViewControllerWithIdentifier:@"PayMentDetailVC_SID"];
    payMentDetailVC.strID = payment.token.transactionIdentifier;
    [self.navigationController pushViewController:payMentDetailVC animated:YES];
}


// Sent to the delegate when payment authorization is finished.  This may occur when
// the user cancels the request, or after the PKPaymentAuthorizationStatus parameter of the
// paymentAuthorizationViewController:didAuthorizePayment:completion: has been shown to the user.
//
// The delegate is responsible for dismissing the view controller in this method.
- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller{
    [controller dismissViewControllerAnimated:YES completion:nil];
}
@end
