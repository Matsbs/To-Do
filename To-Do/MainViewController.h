//
//  MainViewController.h
//  MobileApps4Tourism
//
//  Created by Mats Sandvoll on 18.09.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "ViewNoteController.h"
#import "NewTaskViewController.h"

@interface MainViewController : UIViewController <NewTaskViewControllerDelegate, ViewNoteControllerDelegate,  UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *taskArray;
@property (nonatomic, retain) Task *task;

@end
