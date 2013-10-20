//
//  NewTaskViewController.h
//  To-Do
//
//  Created by Mats Sandvoll on 13.10.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@class NewTaskViewController;

//Protocol for communication to mainView
@protocol NewTaskViewControllerDelegate <NSObject>
- (void)addItemViewController:(NewTaskViewController *)controller didFinishEnteringItem:(Task *)item;
@end

@interface NewTaskViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) id <NewTaskViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *dateField;
@property (nonatomic, retain) IBOutlet UITextField *noteField;
@property (nonatomic, retain) Task *task;
@property (nonatomic, retain) UITableView *tableView;

@end