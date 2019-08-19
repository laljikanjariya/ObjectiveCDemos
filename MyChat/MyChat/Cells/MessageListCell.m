//
//  MessageListCell.m
//  MyChat
//
//  Created by Siya9 on 11/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "MessageListCell.h"

@implementation MessageListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)DownlaodMidiaData:(UIButton *)sender {

    [self addLoader];
    sender.hidden =TRUE;
}
-(void)addLoader{
    UIView * temp = [self.viewIndicater viewWithTag:555];
    [temp removeFromSuperview];
    self.Indicator = nil;
    self.viewIndicater.hidden = FALSE;
    if (!self.Indicator) {
        self.Indicator = [[RMDownloadIndicator alloc]initWithFrame:CGRectMake(0,0,40,40) type:kRMClosedIndicator];
        [self.Indicator setBackgroundColor:[UIColor clearColor]];
        [self.Indicator setFillColor:[UIColor clearColor]];
        [self.Indicator setStrokeColor:[UIColor greenColor]];
        [self.Indicator setClosedIndicatorBackgroundStrokeColor:[UIColor redColor]];
        self.Indicator.tag = 555;
        self.Indicator.radiusPercent = 0.45;
        [self.viewIndicater addSubview:self.Indicator];
        [self.Indicator loadIndicator];
    }
    self.btnDownload.hidden = TRUE;
    [self.viewIndicater bringSubviewToFront:self.Indicator];
    
    DDFileInfo * objFile = [DDFileManager addToDownloadUserMessageImageWithUrl:self.objMessage.msgURL];
    NSIndexPath *indexPath = [self indexPathForCellContainingView:self.btnDownload];
    
    CompletionHandler ompletionHandler =^(id response, NSError *error){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.delegate messageMediaDownloadwith:response downloadError:error];
            [self.Indicator removeFromSuperview];
            self.Indicator = nil;
        });
    };
    objFile.progressHandler =^(float fltProgress){
        NSLog(@"%f",fltProgress);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.Indicator updateWith:fltProgress];
        });
    };
    [objFile addNewResponce:indexPath withComplication:ompletionHandler];

}
-(IBAction)showMidiaData:(UIButton *)sender {
     NSIndexPath *indexPath = [self indexPathForCellContainingView:sender];
    [self.delegate showMessageDetailAt:indexPath];
}
- (NSIndexPath *)indexPathForCellContainingView:(UIView *)view {

    CGPoint viewCenterRelativeToTableview = [self.objTableview convertPoint:CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds)) fromView:view];
    NSIndexPath *cellIndexPath = [self.objTableview indexPathForRowAtPoint:viewCenterRelativeToTableview];
    return cellIndexPath;
}
-(void)setUpCellForMessage:(Messages *)objMessage{

    self.btnDownload.hidden =TRUE;
    self.btnShowDetail.hidden =TRUE;
    self.viewIndicater.hidden =TRUE;
    [[self.viewIndicater viewWithTag:555] removeFromSuperview];
    self.Indicator = nil;
    switch (objMessage.messageType.intValue) {
        case 1:
            self.lblMessage.text = objMessage.stringMessage;
            break;
        case 2:{
            self.imgMessage.image = [UIImage imageNamed:@"defaultImageMsg.png"];
            if ([DDFileManager isAddedIntoDownloadList:objMessage.msgURL]) {
                self.btnDownload.hidden = TRUE;
                [self addLoader];
            }
            else{
                if ([[objMessage.msgURL getUserMessageMediaImagesPath] isFileExist]) {
                    self.btnDownload.hidden = TRUE;
                    NSString * strImagePath = [objMessage.msgURL getUserMessageMediaImagesPath];
                    UIImage *thumbNail = [[UIImage alloc]initWithData:[[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:strImagePath]]];
                    float oldWidth = thumbNail.size.width;
                    float scaleFactor = 195 / oldWidth;
                    
                    float newHeight = thumbNail.size.height * scaleFactor;
                    float newWidth = oldWidth * scaleFactor;
                    self.layImgWidth.constant = newWidth;
                    self.layImgHeight.constant = newHeight;
                    self.imgMessage.image = thumbNail;
                    self.btnShowDetail.hidden = FALSE;
                }
                else{
                    self.btnDownload.hidden = FALSE;
                }
            }
            break;
        }
        case 3:
            self.imgMessage.image = [UIImage imageNamed:@"defaultVideoImage.png"];
            if ([DDFileManager isAddedIntoDownloadList:objMessage.msgURL]) {
                self.btnDownload.hidden = TRUE;
                [self addLoader];
            }
            else{
                if ([[objMessage.msgURL getUserMessageMediaVideoPath] isFileExist]) {
                    self.btnDownload.hidden = TRUE;

                    UIImage *thumbNail = [UIImage imageNamed:@"defaultVideoImage.png"];
                    float oldWidth = thumbNail.size.width;
                    float scaleFactor = 195 / oldWidth;
                    
                    float newHeight = thumbNail.size.height * scaleFactor;
                    float newWidth = oldWidth * scaleFactor;
                    self.layImgWidth.constant = newWidth;
                    self.layImgHeight.constant = newHeight;
                    self.imgMessage.image = thumbNail;
                    self.btnShowDetail.hidden = FALSE;
                }
                else{
                    self.btnDownload.hidden = FALSE;
                }
            }
            break;
        default:
            break;
    }
    self.lblTime.text = objMessage.sendTime.timeOfDate;
    self.objMessage = objMessage;
}
@end
