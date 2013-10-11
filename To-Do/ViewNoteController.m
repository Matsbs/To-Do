//
//  ViewNoteController.m
//  To-Do
//
//  Created by Mats Sandvoll on 11.10.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import "ViewNoteController.h"

@interface ViewNoteController ()

@end

@implementation ViewNoteController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //MAKE A TABLE VIEW
    
    self.title = self.task.name;
    
    //self.view.backgroundColor = [UIColor whiteColor];
    
    self.dateView = [[UITextView alloc] initWithFrame:CGRectMake(20, 50, 50, 20)];
    self.dateView.text = self.task.note;
    self.dateView.editable = NO;
    self.dateView.scrollEnabled = YES;
    self.dateView.font = [UIFont fontWithName:@"Helvetica" size:14];
    [self.view addSubview:self.dateView];
   

    self.noteView = [[UITextView alloc] initWithFrame:CGRectMake(20, 150, 50, 20)];
    self.noteView.text = self.task.note;
    self.noteView.editable = NO;
    self.noteView.scrollEnabled = YES;
    self.noteView.font = [UIFont fontWithName:@"Helvetica" size:14];
    [self.view addSubview:self.noteView];
    
  
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

@end
