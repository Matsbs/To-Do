//
//  DBManager.h
//  To-Do
//
//  Created by Mats Sandvoll on 02.12.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Task.h"
#import "Note.h"
#import "LogManager.h"

@interface DBManager : NSObject

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *TASKDB;

- (void)initDatabase;
- (void)setDbPath;
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
//- (NSInteger)getTaskID:(Task *)task;
//- (NSInteger)getNoteID:(Note *)note;
//

@end
