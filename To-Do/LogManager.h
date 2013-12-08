//
//  LogManager.h
//  To-Do
//
//  Created by Mats Sandvoll on 04.12.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"
#import "Note.h"

@interface LogManager : NSObject

typedef enum {
    CreateTask,
    UpdateTask,
    DeleteTask,
    CreateNote,
    UpdateNote,
    DeleteNote,
    DeleteAll
} OperationType;


-(void)writeToLog:(OperationType) operation :(NSObject*) object;
-(void)readLog;
-(BOOL)logFileHasContent;

@end
