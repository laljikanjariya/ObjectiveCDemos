//
//  SongsListEditVC.m
//  MySongs
//
//  Created by Siya Infotech on 30/12/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import "SongsListEditVC.h"
#import "PlayLists.h"
#import "Songs.h"

@interface SongsListEditVC ()

@end

@implementation SongsListEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tblList.delegate = self;
    // Do any additional setup after loading the view.
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
#pragma mark - Table view data source


#pragma mark - Table view data source


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.imageView.image = nil;
    Songs * objSong = [self.itemDilspayPalyListRC objectAtIndexPath:indexPath];
    if (self.selectedPlayList) {
        if ([objSong.palylist containsObject:self.selectedPlayList]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    return cell;
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Songs * objSong = [self.itemDilspayPalyListRC objectAtIndexPath:indexPath];
    if (self.selectedPlayList) {
        if ([objSong.palylist containsObject:self.selectedPlayList]) {
            [self.selectedPlayList removeSongsObject:objSong];
        }
        else {
            [self.selectedPlayList addSongsObject:objSong];
        }
    }
    [self.tblList reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
@end
