//
//  FTPServer.m
//  FTPConnection
//
//  Created by Siya9 on 09/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "FTPServer.h"

@interface FTPServer ()
@property (weak, nonatomic) IBOutlet UITextField *txtURL;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@end

@implementation FTPServer
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated {
    [self saveData:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveData:(id)sender {
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:_txtURL.text forKey:@"FTPurl"];
    [ud setObject:_txtUserName.text forKey:@"FTPuser"];
    [ud setObject:_txtPassword.text forKey:@"FTPpassword"];
    [ud synchronize];
}
@end
