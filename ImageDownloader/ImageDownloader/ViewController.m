//
//  ViewController.m
//  ImageDownloader
//
//  Created by Siya9 on 17/11/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "DDFileManager.h"
@interface ViewController ()
{
    NSMutableArray * arrImageList;
    BOOL isLazyLoading;
    NSNumber * cells;
}
@property (nonatomic, weak) IBOutlet UITableView * tblList;
@property (nonatomic, weak) IBOutlet UITextField * txtCell;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrImageList = [NSMutableArray array];
    isLazyLoading = FALSE;
    cells = [[NSUserDefaults standardUserDefaults] objectForKey:@"cell"];
    
    [arrImageList addObject:[NSString stringWithFormat:@"https://s3-eu-west-1.amazonaws.com/alf-proeysen/Bakvendtland-MASTER.mp4"]];
    
    [arrImageList addObject:[NSString stringWithFormat:@"http://is3.mzstatic.com/image/thumb/Purple71/v4/3f/b0/d9/3fb0d9ac-d5ee-d06e-3003-d3abc74ccc2d/mzl.lkoqnqhe.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is5.mzstatic.com/image/thumb/Purple71/v4/26/ef/89/26ef8980-d2a1-9089-8e05-5806d6c524da/mzl.irdhzukd.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is1.mzstatic.com/image/thumb/Purple71/v4/72/92/7d/72927d21-d11c-8ed1-e9da-4027d519c697/pr_source.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is2.mzstatic.com/image/thumb/Purple5/v4/1a/2d/16/1a2d16b8-ce11-712c-efb5-6d791f945b3d/mzl.spyxltcm.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is1.mzstatic.com/image/thumb/Purple71/v4/cf/4d/36/cf4d360b-4538-aa83-1f41-bc0b7871737c/mzl.mscuhkal.jpg%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is4.mzstatic.com/image/thumb/Purple1/v4/46/16/62/461662d0-861a-4eed-a736-64da8fe475a3/mzl.xwmnrpez.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is4.mzstatic.com/image/thumb/Purple71/v4/76/5d/a2/765da24f-bc07-bbfb-6eee-e73b0e569852/mzl.lxjvazwu.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is4.mzstatic.com/image/thumb/Purple62/v4/a8/74/af/a874af01-11bb-497c-ac69-30a45cdb9290/mzl.ftotfsmu.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is4.mzstatic.com/image/thumb/Purple6/v4/f0/16/a0/f016a00d-0174-ae7c-5474-b64856c09148/mzl.tccojkqs.jpg%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is5.mzstatic.com/image/thumb/Purple71/v4/3c/b5/c9/3cb5c991-c850-8474-18a9-70909879a52a/mzl.sbvdwfcr.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is3.mzstatic.com/image/thumb/Purple71/v4/ec/3e/6c/ec3e6c54-13e4-b96b-82a9-9b358b55d773/mzl.hkodstqt.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is4.mzstatic.com/image/thumb/Purple71/v4/7b/d6/27/7bd6273d-f47b-58c7-166d-ffb79ad9c497/pr_source.jpg%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is4.mzstatic.com/image/thumb/Purple71/v4/89/42/6e/89426ebf-f5f5-78ac-738b-10d605a5a73c/mzl.ddqjatlx.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is2.mzstatic.com/image/thumb/Purple62/v4/2f/2a/1b/2f2a1be0-ea57-155b-86b1-c9358656709d/mzl.thvugtmx.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is4.mzstatic.com/image/thumb/Purple62/v4/8d/fd/96/8dfd96e4-1676-a8dd-de14-0cf83932c8b5/mzl.vthrhqoq.jpg%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is3.mzstatic.com/image/thumb/Purple71/v4/09/45/ba/0945bafc-6c0e-46d5-d750-dab641ee12c1/mzl.nxdygamx.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is1.mzstatic.com/image/thumb/Purple71/v4/7c/b6/32/7cb63278-f6ce-f34d-3316-34b1f7b0094e/mzl.tjlgxfab.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is5.mzstatic.com/image/thumb/Purple4/v4/f5/68/69/f56869ca-ecc7-b078-2ad9-9dd759a675b7/mzl.kanjtbmh.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is2.mzstatic.com/image/thumb/Purple69/v4/92/79/8a/92798adc-055d-4fb9-4c82-5a0316020de0/mzl.igysykhz.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is4.mzstatic.com/image/thumb/Purple3/v4/a2/c1/4f/a2c14fc1-f33a-6fb1-00a9-34e58205d9d9/mzl.qzdpwozq.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is2.mzstatic.com/image/thumb/Purple71/v4/32/41/52/3241526c-9394-3259-0ddd-1e8babcd444e/pr_source.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is4.mzstatic.com/image/thumb/Purple71/v4/b7/c3/1f/b7c31fb5-81b3-719b-d99e-fd961a68d2c9/mzl.koqvrqxz.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is1.mzstatic.com/image/thumb/Purple71/v4/57/54/68/57546874-2e19-3ff9-5ceb-b6b64dd65aa8/mzl.nshexhjl.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is5.mzstatic.com/image/thumb/Purple22/v4/11/b6/76/11b676b4-0a59-2806-e83a-a4e707728a91/mzm.zzcqbvdz.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is3.mzstatic.com/image/thumb/Purple/fb/59/e3/mzi.evhqkslz.jpg%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is4.mzstatic.com/image/thumb/Purple71/v4/f9/c9/2f/f9c92fc5-edbd-7823-1ebc-c1047a17261b/mzl.lnxkcutb.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is3.mzstatic.com/image/thumb/Purple62/v4/bf/52/5e/bf525e53-fcad-b051-be00-3d401a74fc37/mzl.qbllchnp.jpg%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is3.mzstatic.com/image/thumb/Purple71/v4/1c/52/52/1c5252ea-f782-7655-7c20-fb135f2e5985/mzl.ndntihdt.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is4.mzstatic.com/image/thumb/Purple62/v4/9a/7d/7b/9a7d7b62-6de2-5e84-23fb-8c2a96429a88/mzl.moscwqfw.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is4.mzstatic.com/image/thumb/Purple3/v4/dc/42/82/dc4282be-1d73-d8fc-e1d7-8a5bf9c333a5/mzl.nedtzwvh.jpg%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is4.mzstatic.com/image/thumb/Purple71/v4/9a/08/b9/9a08b9ae-d028-e44f-baa3-e548b29785e7/mzl.hmovorpn.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is5.mzstatic.com/image/thumb/Purple4/v4/98/d3/ab/98d3ab78-0330-4535-fdad-d49707bf2caf/mzl.jnbezbpp.jpg%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is5.mzstatic.com/image/thumb/Purple20/v4/72/10/50/72105007-5dc6-8db8-4e24-dbcb8b700ec7/mzl.enlfisvk.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is1.mzstatic.com/image/thumb/Purple71/v4/68/4b/c9/684bc9f7-b2ba-510d-7370-ebf2e064a239/mzl.ynvapmih.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is3.mzstatic.com/image/thumb/Purple62/v4/c7/86/fd/c786fd12-780c-a2c7-9223-5c49db1eadf5/mzl.rimygguo.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is1.mzstatic.com/image/thumb/Purple1/v4/8a/82/b5/8a82b5ed-36d7-d17a-8620-ac899beefddd/mzl.lwqsprmf.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is2.mzstatic.com/image/thumb/Purple62/v4/46/ce/09/46ce09b3-c8ff-16a2-c024-5d4ff19984d4/pr_source.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is5.mzstatic.com/image/thumb/Purple49/v4/65/1b/6e/651b6e3a-48c6-d89a-0d23-856915640a8a/mzl.cnjdtdjh.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is4.mzstatic.com/image/thumb/Purple69/v4/9e/f6/10/9ef610c9-8e6f-c89b-6d9c-2a5d183e142e/mzl.iaorfaih.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is2.mzstatic.com/image/thumb/Purple60/v4/fd/22/fd/fd22fdbd-4c34-f495-2d4f-62689635f4aa/mzl.buzljamm.jpg%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is5.mzstatic.com/image/thumb/Purple1/v4/be/87/73/be8773ce-be12-7f1e-2230-329d489809f0/mzl.snnqehsw.jpg%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is3.mzstatic.com/image/thumb/Purple6/v4/16/4c/44/164c448d-eaaa-0ba9-e373-eca83a48f514/mzl.cvyeeyxu.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is5.mzstatic.com/image/thumb/Purple71/v4/16/7e/5d/167e5d4d-af1a-381b-1572-22991d93dda8/mzl.eclpxwez.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is2.mzstatic.com/image/thumb/Purple3/v4/51/a3/46/51a3466b-fdec-a5ed-5e29-c814b07ad77f/pr_source.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is2.mzstatic.com/image/thumb/Purple62/v4/52/b1/db/52b1db12-c6c6-6245-c11c-eb3df8375de7/mzl.ubmdburl.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is1.mzstatic.com/image/thumb/Purple71/v4/1f/d8/54/1fd85489-2df8-7484-1da9-e472c828eea5/pr_source.jpg%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is5.mzstatic.com/image/thumb/Purple69/v4/69/c7/4c/69c74cb0-15f8-5fde-d67b-f911c64cade4/mzl.sfobodhx.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is2.mzstatic.com/image/thumb/Purple71/v4/05/05/5d/05055d1b-73e5-b02d-4940-ca57f004507b/pr_source.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is2.mzstatic.com/image/thumb/Purple1/v4/2c/1f/9f/2c1f9faf-c2e4-a3e4-2319-114d07ee2ef0/pr_source.jpg%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is3.mzstatic.com/image/thumb/Purple60/v4/c5/18/6b/c5186b77-64c4-197f-dea1-a83504436f06/mzl.ajqzdifq.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is5.mzstatic.com/image/thumb/Purple19/v4/70/46/32/70463231-da84-6c50-8bfd-05cdd18c09b5/mzl.eieyykha.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is2.mzstatic.com/image/thumb/Purple20/v4/54/08/6c/54086c04-c527-a507-ece9-f518d95ee560/mzl.ovhjafbz.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is5.mzstatic.com/image/thumb/Purple60/v4/da/33/fb/da33fb87-f16c-133d-e8c0-f0d776aaa4b2/mzl.nptuqxzk.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is1.mzstatic.com/image/thumb/Purple71/v4/bf/3f/4e/bf3f4eba-4130-2968-b72d-49bec7659349/mzl.grfmnyep.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is3.mzstatic.com/image/thumb/Purple71/v4/20/db/8b/20db8bbe-bd50-2467-9f6e-9642234d8330/mzl.jdrplhqn.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is5.mzstatic.com/image/thumb/Purple5/v4/d4/0a/22/d40a2204-f6cc-e883-c713-5bdc17b13dcd/mzl.eytrphlx.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is5.mzstatic.com/image/thumb/Purple71/v4/25/67/fd/2567fdc1-df61-e86d-371a-e509f6349458/mzl.wegdfivz.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is1.mzstatic.com/image/thumb/Purple71/v4/55/25/43/552543fe-7661-de96-031a-939f5264b73c/mzl.inmekrgk.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is3.mzstatic.com/image/thumb/Purple19/v4/84/a5/c4/84a5c4c5-967e-f55b-e12e-d13b9d0bffa7/mzl.taumnwop.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is5.mzstatic.com/image/thumb/Purple3/v4/44/45/a4/4445a413-be74-59fd-8c13-91e6752cedf8/mzl.fqhyncai.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is4.mzstatic.com/image/thumb/Purple3/v4/c8/ef/31/c8ef31f2-a094-9644-5ee1-fcd30665657b/mzl.egsiloyo.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is3.mzstatic.com/image/thumb/Purple19/v4/62/28/cb/6228cb69-97f4-e44b-7b25-590ca794532e/pr_source.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is3.mzstatic.com/image/thumb/Purple62/v4/2a/af/9f/2aaf9f5e-b787-caa3-56b3-d949fe42df79/mzl.riwtmjwc.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is3.mzstatic.com/image/thumb/Purple1/v4/9a/be/b5/9abeb58d-a54d-666b-3dab-0c0699fc7b64/pr_source.jpg%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is2.mzstatic.com/image/thumb/Purple69/v4/ea/de/96/eade96d8-3df9-f1e8-b381-88f6f41d7593/mzl.lqzbdvmc.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is5.mzstatic.com/image/thumb/Purple20/v4/21/43/7e/21437ec6-e543-2264-ec67-7fff56e4a2ec/mzl.siguwusg.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is4.mzstatic.com/image/thumb/Purple71/v4/fe/cf/4f/fecf4ff6-a6c9-1493-f490-648f494692a1/pr_source.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is1.mzstatic.com/image/thumb/Purple71/v4/6b/8c/b1/6b8cb13f-7819-06cf-1c61-68fd8e7abe75/mzl.uvszfdob.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is4.mzstatic.com/image/thumb/Purple71/v4/d2/54/88/d25488d4-faec-4856-ea6d-ad04dfae78b6/mzl.jksxatcf.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is5.mzstatic.com/image/thumb/Purple71/v4/9e/c7/de/9ec7de7d-7fa0-54f7-b94d-5506321115c5/pr_source.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is1.mzstatic.com/image/thumb/Purple19/v4/91/de/57/91de57c6-69c4-bfc0-df2e-785f7b2f49b9/mzl.iibjcwuw.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is1.mzstatic.com/image/thumb/Purple71/v4/86/1e/59/861e5949-2099-db6c-be07-30bf1d37e041/mzl.pjgzacyv.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is3.mzstatic.com/image/thumb/Purple49/v4/af/76/6d/af766d00-eed6-1e34-df0d-5bcc78642c24/mzl.evgtccti.jpg%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is3.mzstatic.com/image/thumb/Purple60/v4/c6/7c/48/c67c489a-35eb-e765-a371-9373bac8b2c6/mzl.nyupddfy.png%@",Prifix]];
    [arrImageList addObject:[NSString stringWithFormat:@"http://is5.mzstatic.com/image/thumb/Purple71/v4/4b/ec/e3/4bece33c-1088-466f-59a8-d34370a4f4ea/mzl.nsmaypyq.png%@",Prifix]];
    // Do any additional setup after loading the view, typically from a nib.
    if (!cells || cells.integerValue == 0) {
        cells = @(arrImageList.count);
    }
    _txtCell.text = cells.stringValue;
}
-(void)viewDidAppear:(BOOL)animated {
    [self loadImagesForOnscreenRows];
}
#pragma mark - Table view data source -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
//    int cell = self.txtCell.text.intValue;
//    if (cell>0 && cell<arrImageList.count) {
//        return cell;
//    }
    return cells.integerValue;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ImageTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    cell.textLabel.text = [NSString stringWithFormat:@"Image Number %d",(int)indexPath.row];
    cell.imgView.imgView.image = [UIImage imageNamed:@"Default.png"];
    if (!isLazyLoading) {
        DDFileInfo * file = [cell.imgView loadImage:arrImageList[indexPath.row] imageCatchType:ImageCatchTypeRIM withCompletionHandler:^(id response, NSError *error) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSIndexPath * ind = (NSIndexPath *)response;
                [self.tblList reloadRowsAtIndexPaths:@[ind] withRowAnimation:UITableViewRowAnimationAutomatic];
            });
        }];
        file.responce = indexPath;
        file.progressHandler = ^(id responce){
            NSIndexPath * ind = (NSIndexPath *)responce;
            if ([[self.tblList indexPathsForVisibleRows] containsObject:ind]) {
                [cell.imgView.indView setIndicatorStatus:ACPDownloadStatusRunning];
                [cell.imgView.indView setProgress:file.downloadProgress animated:TRUE];
            }
        };

    }
    else{
         UIImage * imgLoaded = [RapidImage getImageFromCatch:arrImageList[indexPath.row] imageCatchType:ImageCatchTypeRIM];
        cell.imgView.indView.hidden = TRUE;
        if (imgLoaded) {
            cell.imgView.imgView.image = imgLoaded;
        }
    }
    
    
//    UIImage * image = [cell.imageView loadImageFromCatch:arrImageList[indexPath.row] imageCatchType:ImageCatchTypeRIM];
//    if (image) {
//        cell.imageView.image = image;
//    }
//    else {
//        cell.imageView.image = [UIImage imageNamed:@"Default.png"];
//        FileInfo * file = [cell.imageView loadImage:arrImageList[indexPath.row] imageCatchType:ImageCatchTypeRIM withCompletionHandler:^(id responce) {
//            [self.tblList reloadRowsAtIndexPaths:@[responce] withRowAnimation:UITableViewRowAnimationAutomatic];
//        }];
//        file.responce = indexPath;
//    }
//    [cell.imageView loadImage:arrImageList[indexPath.row] imageCatchType:ImageCatchTypeRIM];
//    FileInfo * file = [cell.imageView loadImage:arrImageList[indexPath.row] imageCatchType:ImageCatchTypeRIM withCompletionHandler:^(id responce) {
//        [tableView reloadRowsAtIndexPaths:@[responce] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }];
//    file.responce = indexPath;
    return cell;
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate

// -------------------------------------------------------------------------------
//	scrollViewDidEndDragging:willDecelerate:
//  Load images for all onscreen rows when scrolling is finished.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self loadImagesForOnscreenRows];
    }
}

// -------------------------------------------------------------------------------
//	scrollViewDidEndDecelerating:scrollView
//  When scrolling stops, proceed to load the app icons that are on screen.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}
- (void)loadImagesForOnscreenRows
{
    if (isLazyLoading) {
        NSArray *visiblePaths = [self.tblList indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            ImageTestCell *cell = [self.tblList cellForRowAtIndexPath:indexPath];
            DDFileInfo * file = [cell.imgView loadImage:arrImageList[indexPath.row] imageCatchType:ImageCatchTypeRIM withCompletionHandler:^(id response, NSError *error) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    NSIndexPath * ind = (NSIndexPath *)response;
                    [self.tblList reloadRowsAtIndexPaths:@[ind] withRowAnimation:UITableViewRowAnimationAutomatic];
                });
            }];
            file.responce = indexPath;
        }
    }
}

#pragma mark - UITextFieldDelegate -
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self.tblList reloadData];
    int cell = self.txtCell.text.intValue;
    if (cell>0 && cell<arrImageList.count) {
        [[NSUserDefaults standardUserDefaults]setObject:@(cell) forKey:@"cell"];
    }
    return YES;
}

-(IBAction)removeAllImages:(id)sender {
    NSString * strCatchPath = [NSString stringWithFormat:@"%@/Documents/MyChatMedia/ProfileImages/",NSHomeDirectory()];
    NSLog(@"Home Directory %@\n\n\n\n\n\n\n\n\n\n",strCatchPath);
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    for (NSString *file in [fileManager contentsOfDirectoryAtPath:strCatchPath error:&error]) {
        if (![file.pathExtension.lowercaseString isEqualToString:@"data"]) {
            [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@%@", strCatchPath, file] error:&error];
        }
    }
    [self.tblList reloadRowsAtIndexPaths:[self.tblList indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(IBAction)setLazyLoadingImages:(UIButton *)sender {
    NSArray * arrDownloadList = [DDFileManager sharedInstance].arrDownloadList.copy;
    
    for (DDFileInfo * objFile in arrDownloadList) {
        [DDFileManager pushDownloadForFile:objFile];
    }
    isLazyLoading = !isLazyLoading;
    sender.selected = isLazyLoading;
    [self removeAllImages:sender];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadImagesForOnscreenRows];
    });
}
@end


#pragma mark - Cell -
@implementation ImageTestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
