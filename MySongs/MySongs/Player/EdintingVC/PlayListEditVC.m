//
//  PlayListEditVC.m
//  MySongs
//
//  Created by Siya Infotech on 30/12/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import "PlayListEditVC.h"

@interface PlayListEditVC (){
        IBOutlet UITextField * txtPlayListName;
}

@end

@implementation PlayListEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    txtPlayListName.delegate = nil;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)AddnewPlayList:(id)sender {
    if (txtPlayListName.text.length>0) {
        txtPlayListName.backgroundColor = [UIColor whiteColor];
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"PlayLists"];
        //    fetchRequest.resultType = NSDictionaryResultType;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pname == %@",txtPlayListName.text];
        [fetchRequest setPredicate:predicate];
        NSError *error      = nil;
        NSArray *results    = [self.managedObjectContext executeFetchRequest:fetchRequest
                               
                                                                       error:&error];
        
        if (results.count == 0) {
            NSManagedObjectContext * moc =[QueryManager privateConextFromParentContext:self.managedObjectContext];
            PlayLists * objNewPL = (PlayLists *)[QueryManager InsertObject:@"PlayLists" withContext:moc isSave:NO];
            objNewPL.pname = txtPlayListName.text;
            [moc save:nil];
            txtPlayListName.text = @"";
        }
        else {
            txtPlayListName.backgroundColor = [UIColor redColor];
        }
    }
    else {
        txtPlayListName.backgroundColor = [UIColor redColor];
    }
}

@end
