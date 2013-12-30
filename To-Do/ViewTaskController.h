//
//  ViewNoteController.h
//  To-Do
//
//  Created by Mats Sandvoll on 11.10.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "DBManager.h"
#import "Manager.h"

@interface ViewTaskController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) Task *task;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) DBManager *dbManager;
@property (nonatomic, retain) Manager *manager;

@end
