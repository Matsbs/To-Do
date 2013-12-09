//
//  LogManager.m
//  To-Do
//
//  Created by Mats Sandvoll on 04.12.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import "LogManager.h"

@implementation LogManager

-(void)writeToLog:(OperationType) operation :(NSObject*) object{
    NSString *query = [self getQuerryString:operation :object];
    if (query!= nil){
        NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString* logfile = [documentsPath stringByAppendingPathComponent:@"log.txt"];
        BOOL logfileExists = [[NSFileManager defaultManager] fileExistsAtPath:logfile];
        if (!logfileExists) {
            NSLog(@"Log file not exist");
            NSString *string = [[NSString alloc]initWithFormat:@"%@",query];
            [string writeToFile:logfile atomically:YES encoding:NSUTF8StringEncoding error:NULL];
        }else{
            NSFileHandle *fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:logfile];
            NSFileManager *manager = [NSFileManager defaultManager];
            NSDictionary *attributes = [manager attributesOfItemAtPath:logfile error:nil];
            unsigned long long size = [attributes fileSize];
            NSString *string;
            if (attributes && size == 0) {
                // file exists, but is empty.
                string = [NSString stringWithFormat:@"%@", query];
            }else{
                string = [NSString stringWithFormat:@"\n%@", query];
            }
            [fileHandler seekToEndOfFile];
            [fileHandler writeData:[string dataUsingEncoding:NSUTF8StringEncoding]];
            [fileHandler closeFile];
        }
    }
}

-(NSString*)getQuerryString:(OperationType) operation :(NSObject*) object{
    NSString *url = [[NSString alloc] initWithFormat:@"http://demo--1.azurewebsites.net/JSON.php?"];
    NSString *query=nil;
    switch (operation) {
        case CreateTask:
            {Task *newTask = (Task*) object;
            NSLog(@"Created task on server.");
            query = [[NSString alloc]initWithFormat:@"%@f=addTodo&t=%@&D=%@&d=%@&c=Work",url,newTask.name, newTask.description, newTask.date];//newTask.category];
            }break;
        case UpdateTask:
            {Task *newTask = (Task*) object;
            NSLog(@"Updated task on server.");
                query = [[NSString alloc]initWithFormat:@"%@f=updateTodo&tid=%d&t=%@&D=%@&d=%@&c=Work",url,newTask.externalTaskID,newTask.name, newTask.description, newTask.date]; //newTask.category];
            }break;
        case DeleteTask:
            {Task *newTask = (Task*) object;
            NSLog(@"Deleted task on server.");
            query = [[NSString alloc]initWithFormat:@"%@f=removeTodo&tid=%d",url,newTask.externalTaskID];
        }break;
        case CreateNote:
            {Note *newNote = (Note*) object;
            NSLog(@"Created note on server.");
            query = [[NSString alloc]initWithFormat:@"%@f=addNote&tid=%d&D=%@",url, newNote.externalTaskID, newNote.description];
        }break;
        case UpdateNote:
            {Note *newNote = (Note*) object;
            NSLog(@"Updated note on server.");
            query = [[NSString alloc]initWithFormat:@"%@f=updateNote&nid=%d&D=%@",url, newNote.externalNoteID, newNote.description];
        }break;
        case DeleteNote:
            {Note *newNote = (Note*) object;
            NSLog(@"Deleted note on server.");
            query = [[NSString alloc]initWithFormat:@"%@f=removeNote&nid=%d",url, newNote.externalNoteID];
        }break;
        case DeleteAll:
        {
            //Not supported by server
        }break;
    }
    if (query != nil) {
        query = [query stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    }
    return query;
}

-(void)readLog{
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* logfile = [documentsPath stringByAppendingPathComponent:@"log.txt"];
    NSCharacterSet *newlineCharSet = [NSCharacterSet newlineCharacterSet];
    NSString* fileContents = [NSString stringWithContentsOfFile:logfile
                                                       encoding:NSUTF8StringEncoding
                                                          error:nil];
    NSArray *lines = [fileContents componentsSeparatedByCharactersInSet:newlineCharSet];
    NSMutableArray *linesArray = [(NSArray*) lines mutableCopy];
    //[linesArray removeObjectAtIndex:0];
    for (NSString *query in linesArray) {
        NSLog(@"Lines %@",query);
        NSData *dataFromServer = [[NSData alloc] initWithContentsOfURL:
                                  [NSURL URLWithString:query]];
//        NSError *error;
//        NSMutableArray *arrayJson = [NSJSONSerialization JSONObjectWithData:dataFromServer options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error];
//        if(error){
//            NSLog(@"%@", [error localizedDescription]);
//        }
//        else {
////            for (NSDictionary *data in arrayJson) {
////                Task *newTask = [[Task alloc] init];
////                newTask.name = [data objectForKey:@"Title"];
////                newTask.description = [data objectForKey:@"Description"];
////                newTask.date = [data objectForKey:@"Date"];
////                [self.dbManager insertTask:newTask];
////            }
//        }
    }
    [@"" writeToFile:logfile atomically:YES encoding:NSUTF8StringEncoding error:NULL];
}

-(BOOL)logFileHasContent{
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* logfile = [documentsPath stringByAppendingPathComponent:@"log.txt"];
    BOOL logfileExists = [[NSFileManager defaultManager] fileExistsAtPath:logfile];
    if (logfileExists) {
        NSFileManager *manager = [NSFileManager defaultManager];
        NSDictionary *attributes = [manager attributesOfItemAtPath:logfile error:nil];
        unsigned long long size = [attributes fileSize];
        if (attributes && size == 0) {
            // file exists, but is empty.
            return false;
        }else{
            return true;
        }
    }else{
        return false;
    }
}



@end
