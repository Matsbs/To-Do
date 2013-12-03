//
//  NewTaskViewController.h
//  To-Do
//
//  Created by Mats Sandvoll on 13.10.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "NotesViewController.h"
#import "DBManager.h"

@class NewTaskViewController;

@protocol NewTaskViewControllerDelegate <NSObject>
- (void)reloadTableData:(NewTaskViewController *)controller;
@end

@interface NewTaskViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, weak) id <NewTaskViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *dateField;
@property (nonatomic, retain) IBOutlet UITextField *descriptionField;
@property (nonatomic, retain) IBOutlet UITextField *categoryField;
@property (nonatomic, retain) IBOutlet UIDatePicker *picker;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;
@property (nonatomic, retain) NSMutableArray *categories;
@property (nonatomic, retain) Task *task;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) DBManager *dbManager;
@property bool isEditingExistingTask;

@end
