//
//  Manager.m
//  To-Do
//
//  Created by Mats Sandvoll on 26.12.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import "Manager.h"

@implementation Manager


//fikse det med taskID
- (int)insertTask:(Task *)task{
    [self.taskArray addObject:task];
    return ([self.taskArray count]-1.0);
}

- (void)updateTask:(Task *)task{
    for (int i = 0; i < self.taskArray.count; i++) {
        if (task.taskID == [[self.taskArray objectAtIndex:i]taskID]) {
            [self.taskArray replaceObjectAtIndex:i withObject:task];
        }
    }
}

- (void)deleteTask:(Task *)task{
    for (int i = 0; i < self.taskArray.count; i++) {
        if (task.taskID == [[self.taskArray objectAtIndex:i]taskID]) {
            [self.taskArray removeObjectAtIndex:i];
        }
    }
}

- (int)insertNote:(Note *)note{
    [self.noteArray addObject:note];
    return ([self.noteArray count]-1.0);
}

- (void)updateNote:(Note *)note{
    for (int i = 0; i < self.noteArray.count; i++) {
        if (note.noteID == [[self.noteArray objectAtIndex:i]noteID]) {
            [self.noteArray replaceObjectAtIndex:i withObject:note];
        }
    }
}

- (void)deleteNote:(Note *)note{
    for (int i = 0; i < self.noteArray.count; i++) {
        if (note.noteID == [[self.noteArray objectAtIndex:i]noteID]) {
            [self.noteArray removeObjectAtIndex:i];
        }
    }
}

- (void)deleteAllNotesToTask:(Task *)task{
    for (int i = 0; i < self.noteArray.count; i++) {
        if (task.taskID == [[self.noteArray objectAtIndex:i]taskID]) {
            [self.noteArray removeObjectAtIndex:i];
        }
    }
}

- (void)insertCategory:(Category1 *)category{
    [self.categoryArray addObject:category];
}

- (NSMutableArray*)getAllTasks{
    return self.taskArray;
}

- (NSMutableArray*)getAllCategories{
    return self.categoryArray;
}

- (NSMutableArray*)getNotesByTask:(Task *)task{
    NSMutableArray *notes =[[NSMutableArray alloc] init];
    for (int i = 0; i < self.noteArray.count; i++) {
        if (task.taskID == [[self.noteArray objectAtIndex:i]taskID]){
            [notes addObject:[self.noteArray objectAtIndex:i]];
        }
    }
    return notes;
}

- (void)deleteAllTasks{
    [self.taskArray removeAllObjects];
}

- (void) initManager{
    self.taskArray = [[NSMutableArray alloc]init];
    self.noteArray = [[NSMutableArray alloc]init];
    self.categoryArray = [[NSMutableArray alloc]init];
}

@end
