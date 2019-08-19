//
//  POSelectUserOptionVC.m
//  PopUPSearch
//
//  Created by Siya9 on 07/07/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "POSelectUserOptionVC.h"

@interface POSelectUserOptionVC (){
    NSString * strSearch;
}

@property (nonatomic, weak) IBOutlet UITableView * tblList;

@property (nonatomic, strong) SelectionComplete selectionComplete;
@property (nonatomic, strong) SelectionColse selectionColse;

@property (nonatomic, strong) NSArray * arrListOptionFilter;
@property (nonatomic, strong) NSArray * arrListOption;
@end

@implementation POSelectUserOptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.fltRowHeight || self.fltRowHeight == 0) {
        self.fltRowHeight = 45.0f;
    }
    if (!self.intMiximumRowDisplay || self.intMiximumRowDisplay == 0) {
        self.intMiximumRowDisplay = 5;
    }
    self.isHideArrow = TRUE;
    strSearch = @"";
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    _lblTitle.text = _strTitle;
    if (!self.strkey) {
        self.strkey = @"name";
    }
    if (!self.strImgKey) {
        self.strImgKey = @"image";
    }
}
+(instancetype)setSelectionViewitem:(NSArray *)arrItem SelectionComplete:(SelectionComplete)selectionComplete SelectionColse:(SelectionColse)selectionColse {
    POSelectUserOptionVC * instance = [POSelectUserOptionVC getViewFromStoryBoard];
    
    instance.arrListOption = arrItem;
    instance.arrListOptionFilter = instance.arrListOption;
    instance.selectionComplete = selectionComplete;
    instance.selectionColse = selectionColse;
    return instance;
}
+(instancetype)getViewFromStoryBoard{
    return (POSelectUserOptionVC *)[[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"POSelectUserOptionVC_sid"];
}

#pragma mark - UITextFieldDelegate -

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{   // return NO to not change text
    strSearch = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self filterList];
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{               // called when clear button pressed. return NO to ignore (no notifications)
    strSearch = @"";
    [self filterList];
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self filterList];
    return YES;
}

#pragma mark - Table view data source -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.arrListOptionFilter.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.fltRowHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * strOptionValue = @"";
    NSString * strCellIdentifier = @"cell";
    UIImage * imgImage = nil;
    if ([self.arrListOptionFilter[indexPath.row] isKindOfClass:[NSString class]]) {
        strOptionValue = self.arrListOptionFilter[indexPath.row];
        
    }
    else if ([self.arrListOptionFilter[indexPath.row] isKindOfClass:[NSDictionary class]]) {
        strOptionValue = self.arrListOptionFilter[indexPath.row][self.strkey];
        if (self.arrListOptionFilter[indexPath.row][self.strImgKey]) {
            imgImage = [UIImage imageNamed:self.arrListOptionFilter[indexPath.row][self.strImgKey]];
        }
    }
    SelectUserOptionVCCell *cell = [tableView dequeueReusableCellWithIdentifier:strCellIdentifier forIndexPath:indexPath];
    
    cell.lblTitle.textColor = [UIColor whiteColor];
    cell.lblTitle.text = strOptionValue.uppercaseString;
    cell.imgCell.image = imgImage;
    if (indexPath.row == [self tableView:tableView numberOfRowsInSection:indexPath.section]-1) {
        cell.viewSeparator.hidden = TRUE;
    }
    else{
        cell.viewSeparator.hidden = FALSE;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectionComplete(@[self.arrListOption[indexPath.row]]);
    self.selectionColse(self);
}
-(void)filterList{
    if (strSearch.length > 0) {
        NSPredicate * predicate;
        id object = self.arrListOption.firstObject;
        if ([object isKindOfClass:[NSString class]]) {
            predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@",strSearch];
        }
        else if ([object isKindOfClass:[NSDictionary class]]) {
            predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS[cd] %@",self.strkey,strSearch];
        }
        self.arrListOptionFilter = [self.arrListOption filteredArrayUsingPredicate:predicate];
    }
    else{
        self.arrListOptionFilter = self.arrListOption;
    }
    CGSize size = self.preferredContentSize;
    size.height = [self setHeightForView];
    [self.tblList reloadData];
    self.preferredContentSize = size;
}
-(float)setHeightForView{
    float height = (self.arrListOptionFilter.count*self.fltRowHeight) + (self.fltRowHeight/2) + 50;
    
    if (height > (self.intMiximumRowDisplay*self.fltRowHeight)+(self.fltRowHeight/2) + 50) {
        height = (self.intMiximumRowDisplay*self.fltRowHeight)+(self.fltRowHeight/2) + 50;
    }
    height = (height< 75)? 75:height;
    return height;
}

-(void)presentViewControllerForviewConteroller:(UIViewController *) objView sourceView:(UIView *)sourceView ArrowDirection:(UIPopoverArrowDirection)arrowDirection {
    CGRect frame = self.view.frame;
    frame.size.height = [self setHeightForView];
    
    if (CGSizeEqualToSize(CGSizeZero, self.sizePreferredContentSize)) {
        frame.size.width = self.sizePreferredContentSize.width;
    }
    frame.size.width = 200;
    self.sizePreferredContentSize = frame.size;
    [super presentViewControllerForviewConteroller:objView sourceView:sourceView ArrowDirection:arrowDirection];
}

@end
