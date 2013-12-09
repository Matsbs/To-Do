//
//  Spots.h
//  MobileApps4Tourism
//
//  Created by Mats Sandvoll on 18.09.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Category1.h"
#import "Note.h"

@interface Task : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSMutableArray *notes;
@property int taskID;
@property int externalTaskID;


@end
