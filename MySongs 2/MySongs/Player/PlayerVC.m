//
//  PlayerVC.m
//  MySongs
//
//  Created by Siya Infotech on 25/12/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import "PlayerVC.h"
#import "DatabaseManager.h"
#import "PlayListVC.h"
#import "SongsListVC.m"

@interface PlayerVC ()

@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@property (nonatomic, strong) PlayLists * defaultPlayList;
@property (nonatomic, weak) PlayListVC * playListVC;
@property (nonatomic, weak) SongsListVC * songsListVC;
@end

@implementation PlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.managedObjectContext = [DatabaseManager sharedInstance].managedObjectContext;
    NSLog(@"%@",NSHomeDirectory());
    [self setDefaultPlayList];
    [self addjnewMp3SongsToDatabasePath];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addjnewMp3SongsToDatabasePath{
    NSString * strApppath = NSHomeDirectory();
    NSError * error;
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSArray * arrAllFiles = [fileManager contentsOfDirectoryAtPath:strApppath error:&error];
    
    if (error == nil) {
        NSManagedObjectContext * moc =[QueryManager privateConextFromParentContext:self.managedObjectContext];
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Songs"];
        
        for (NSString * strFileName in arrAllFiles) {
            
            NSString * strFromPath = [NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),strFileName];
            NSString * strToPath = [NSString stringWithFormat:@"%@/Documents/Songs/%@",NSHomeDirectory(),strFileName];
            NSString *escapedUrlString = [strFromPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if ([[[[NSURL URLWithString:escapedUrlString] pathExtension] lowercaseString] isEqualToString:@"mp3"]) {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",strFileName];
                [fetchRequest setPredicate:predicate];
                NSError *error      = nil;
                NSArray *results    = [self.managedObjectContext executeFetchRequest:fetchRequest
                                                                               error:&error];
                
                if (results.count == 0) {
                    Songs * newSong = (Songs *)[QueryManager InsertObject:@"Songs" withContext:moc isSave:NO];
                    newSong.name = strFileName;
                    [newSong addPalylistObject:[moc objectWithID:self.defaultPlayList.objectID]];
                    [fileManager moveItemAtPath:strFromPath toPath:strToPath error:nil];
                }
                NSError *error1 = nil;
                [fileManager removeItemAtPath:strFromPath error:&error1];
                NSLog(@"%@",error1);
            }
        }
        [moc save:nil];
        [[DatabaseManager sharedInstance] saveContext];
    }
    else {
        NSLog(@"%@",error);
    }
}
-(void)setDefaultPlayList {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"PlayLists"];
//    fetchRequest.resultType = NSDictionaryResultType;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pname == %@",@"Default"];
    [fetchRequest setPredicate:predicate];
    NSError *error      = nil;
    NSArray *results    = [self.managedObjectContext executeFetchRequest:fetchRequest
            
                                                                   error:&error];

    if (results.count == 0) {
        NSManagedObjectContext * moc =[QueryManager privateConextFromParentContext:self.managedObjectContext];
        self.defaultPlayList = (PlayLists *)[QueryManager InsertObject:@"PlayLists" withContext:moc isSave:NO];
        self.defaultPlayList.pname = @"Default";
        [moc save:nil];
    }
    else {
        self.defaultPlayList = (PlayLists *)[results objectAtIndex:0];
    }
    self.defaultPlayList = [self.managedObjectContext objectWithID:self.defaultPlayList.objectID];
}
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}
@end
