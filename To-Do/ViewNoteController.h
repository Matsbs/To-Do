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

@class ViewNoteController;

@protocol ViewNoteControllerDelegate <NSObject>
- (void)reloadTableData:(ViewNoteController *)controller;
@end

@interface ViewNoteController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <ViewNoteControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *dateField;
@property (nonatomic, retain) IBOutlet UITextField *descriptionField;
@property (nonatomic, retain) IBOutlet UITextField *categoryField;
@property (nonatomic, retain) Task *task;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, retain) DBManager *dbManager;

@end
