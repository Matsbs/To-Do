//
//  DBManager.m
//  To-Do
//
//  Created by Mats Sandvoll on 02.12.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

- (void)initDatabase{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    _databasePath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:@"TASK.db"]];
    //NSFileManager *filemgr = [NSFileManager defaultManager];
    //if ([filemgr fileExistsAtPath: _databasePath ] == NO){
        const char *dbpath = [_databasePath UTF8String];
        if (sqlite3_open(dbpath, &_TASKDB) == SQLITE_OK){
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS CATEGORIES (NAME TEXT PRIMARY KEY)";
            if (sqlite3_exec(_TASKDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK){
                //_status.text = @"Failed to create table";
            }
            sql_stmt ="CREATE TABLE IF NOT EXISTS TASKS (NAME TEXT PRIMARY KEY, DESCRIPTION TEXT, DATE TEXT, CATEGORY TEXT, FOREIGN KEY(CATEGORY) REFERENCES CATEGORIES(NAME))";
            if (sqlite3_exec(_TASKDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK){
                //_status.text = @"Failed to create table";
                NSLog(@"%s",sqlite3_errmsg(_TASKDB));
            }
            sql_stmt = "CREATE TABLE IF NOT EXISTS NOTES (DESCRIPTION TEXT PRIMARY KEY, TASK TEXT, FOREIGN KEY(TASK) REFERENCES TASKS(NAME))";
            if (sqlite3_exec(_TASKDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK){
                //_status.text = @"Failed to create table";
            }
            sqlite3_close(_TASKDB);
        } else {
            //_status.text = @"Failed to open/create database";
        }
        NSLog(@"Database created! Path: %@",_databasePath);
        
    //}
}

- (void)setDbPath{
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    self.databasePath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:@"TASK.db"]];
}

- (void)insertTask:(Task *)task{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_TASKDB) == SQLITE_OK){
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO TASKS (name, description, date, category) VALUES (\"%@\", \"%@\", \"%@\", \"%@\")", task.name, task.description, task.date, task.category];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_TASKDB, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE){
            NSLog(@"Task inserted");
        }else{
            NSLog(@"%s",sqlite3_errmsg(_TASKDB));
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
        sqlite3_close(_TASKDB);
    }
}

- (void)deleteTask:(Task *)task{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_TASKDB) == SQLITE_OK){
        NSString *insertSQL = [NSString stringWithFormat:@"DELETE FROM TASKS WHERE (name) = (\"%@\")", task.name];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_TASKDB, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE){
            NSLog(@"Task deleted");
        }else{
            NSLog(@"%s",sqlite3_errmsg(_TASKDB));
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
        sqlite3_close(_TASKDB);
    }
}

- (void)insertNote:(Note *)note : (Task *)task{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_TASKDB) == SQLITE_OK){
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO NOTES (description,task) VALUES (\"%@\", \"%@\")", note.description, task.name];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_TASKDB, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE){
            NSLog(@"Note inserted");
        }else{
            NSLog(@"%s",sqlite3_errmsg(_TASKDB));
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
        sqlite3_close(_TASKDB);
    }
}

- (void)deleteNote:(Note *)note : (Task *)task{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_TASKDB) == SQLITE_OK){
        NSString *insertSQL = [NSString stringWithFormat:@"DELETE FROM NOTES WHERE ((description) = (\"%@\") and (task) = (\"%@\"))", note.description, task.name];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_TASKDB, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE){
            NSLog(@"Note deleted");
        }else{
            NSLog(@"%s",sqlite3_errmsg(_TASKDB));
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
        sqlite3_close(_TASKDB);
    }
}

- (void)deleteAllNotesToTask:(Task *)task{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_TASKDB) == SQLITE_OK){
        NSString *insertSQL = [NSString stringWithFormat:@"DELETE FROM NOTES WHERE (task) = (\"%@\")",  task.name];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_TASKDB, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE){
            NSLog(@"All notes to task deleted");
        }else{
            NSLog(@"%s",sqlite3_errmsg(_TASKDB));
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
        sqlite3_close(_TASKDB);
    }
}

- (void)insertCategory:(Category1 *)category{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_TASKDB) == SQLITE_OK){
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO CATEGORIES (name) VALUES (\"%@\")", category.name];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_TASKDB, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE){
            NSLog(@"Category inserted");
        }else{
            NSLog(@"%s",sqlite3_errmsg(_TASKDB));
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
        sqlite3_close(_TASKDB);
    }
}

- (NSMutableArray*)getAllTasks{
    NSMutableArray *Tasks =[[NSMutableArray alloc] init];
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &_TASKDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM TASKS"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_TASKDB,query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW){
                Task *newTask = [[Task alloc]init];
                newTask.name = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                newTask.description = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                newTask.date = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                newTask.category = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                [Tasks addObject:newTask];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_TASKDB);
    }
    return Tasks;
}

- (NSMutableArray*)getAllCategories{
    NSMutableArray *categories =[[NSMutableArray alloc] init];
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &_TASKDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM CATEGORIES"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_TASKDB,query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW){
                Category1 *newCategory = [[Category1 alloc]init];
                newCategory.name = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                [categories addObject:newCategory];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_TASKDB);
    }
    return categories;
}

- (NSMutableArray*)getNotesByTask:(Task *)task{
    NSMutableArray *notes =[[NSMutableArray alloc] init];
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &_TASKDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT (description) FROM NOTES WHERE (task) = \"%@\"", task.name];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_TASKDB,query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW){
                Note *newNote = [[Note alloc]init];
                newNote.description = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                [notes addObject:newNote];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_TASKDB);
    }
    return notes;
}

- (void)deleteAllTasks{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_TASKDB) == SQLITE_OK){
        NSString *insertSQL = [NSString stringWithFormat:@"DELETE FROM TASKS"];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_TASKDB, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE){
            NSLog(@"All task deleted");
        }else{
            NSLog(@"%s",sqlite3_errmsg(_TASKDB));
        }
        insertSQL = [NSString stringWithFormat:@"DELETE FROM NOTES"];
        insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_TASKDB, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE){
            NSLog(@"All notes deleted");
        }else{
            NSLog(@"%s",sqlite3_errmsg(_TASKDB));
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
        sqlite3_close(_TASKDB);
    }
}

@end
