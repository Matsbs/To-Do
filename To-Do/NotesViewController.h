//
//  NotesViewController.h
//  To-Do
//
//  Created by Mats Sandvoll on 28.10.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "NewTaskViewController.h"

@interface NotesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *notes;
@property (nonatomic, retain) UITextField IBOutlet *noteField;

@end
