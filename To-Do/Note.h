//
//  Note.h
//  To-Do
//
//  Created by Mats Sandvoll on 25.10.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property (nonatomic, retain) NSString *description;
@property int taskID;
@property int noteID;
@property int externalNoteID;
@property int externalTaskID;

@end
