//
//  ViewNoteController.h
//  To-Do
//
//  Created by Mats Sandvoll on 11.10.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@class ViewNoteController;

//Protocol for communication with mainView
@protocol ViewNoteControllerDelegate <NSObject>
- (void)removeItemViewController:(ViewNoteController *)controller didFinishEnteringItem:(Task *)item;
@end

@interface ViewNoteController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <ViewNoteControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITextView *nameView;
@property (nonatomic, retain) IBOutlet UITextView *dateView;
@property (nonatomic, retain) IBOutlet UITextView *noteView;
@property (nonatomic, retain) Task *task;
@property (nonatomic, retain) UITableView *tableView;

@end
