//
//  ViewNoteController.m
//  To-Do
//
//  Created by Mats Sandvoll on 11.10.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import "ViewTaskController.h"
#import "NotesViewController.h"

@interface ViewTaskController ()

@end

@implementation ViewTaskController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    //Persistant
    //self.dbManager = [[DBManager alloc]init];
    //[self.dbManager setDbPath];
    //Not persistant
    self.manager = [Manager sharedManager];
    
    self.title = self.task.name;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStyleGrouped];
    self.tableView.rowHeight = 60;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editClicked:)] ;
    self.navigationItem.rightBarButtonItem = editButton;
}

- (IBAction)editClicked:(id)sender {
    NewTaskViewController *editTaskView = [[NewTaskViewController alloc]init];
    editTaskView.task = self.task;
    editTaskView.isEditingExistingTask = YES;
    [self.navigationController pushViewController:editTaskView animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = self.task.name;
        }else if (indexPath.row == 1){
            cell.textLabel.text = self.task.description;
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"Date:";
            cell.detailTextLabel.text = self.task.date;
        }else if (indexPath.row == 3){
            cell.textLabel.text = @"Category:";
            cell.detailTextLabel.text = self.task.category;
        }
    }else if(indexPath.section == 1){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.text = @"View Notes";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        NotesViewController *noteView = [[NotesViewController alloc] init];
        if (self.editing==YES) {
            noteView.canEdit = YES;
        }
        noteView.task = self.task;
        [self.navigationController pushViewController:noteView animated:YES];
    }
}

@end
