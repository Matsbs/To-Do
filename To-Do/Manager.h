//
//  Manager.h
//  To-Do
//
//  Created by Mats Sandvoll on 26.12.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"
#import "Note.h"
#import "LogManager.h"

@interface Manager : NSObject

@property (nonatomic, strong) NSMutableArray *taskArray;
@property (nonatomic, strong) NSMutableArray *noteArray;
@property (nonatomic, strong) NSMutableArray *categoryArray;

- (int)insertTask:(Task *)task;
- (int)insertNote:(Note *)note;
- (void)insertCategory:(Category1 *)category;
- (void)deleteTask:(Task *)task;
- (void)deleteNote:(Note *)note;
- (void)deleteAllTasks;
- (NSMutableArray*)getAllTasks;
- (NSMutableArray*)getAllCategories;
- (NSMutableArray*)getNotesByTask: (Task *)task;
- (void)deleteAllNotesToTask:(Task *)task;
- (void)updateTask:(Task *)task;
+ (id)sharedManager;
- (id)init;

@end
