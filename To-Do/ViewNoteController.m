//
//  ViewNoteController.m
//  To-Do
//
//  Created by Mats Sandvoll on 11.10.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import "ViewNoteController.h"
#import "NotesViewController.h"

@interface ViewNoteController ()

@end

@implementation ViewNoteController

- (void)viewDidLoad
{
    self.isEditing = NO;
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    self.dbManager = [[DBManager alloc]init];
    [self.dbManager setDbPath];
    
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
    self.isEditing = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(doneClicked:)] ;
    self.navigationItem.rightBarButtonItem = doneButton;
    [self.tableView reloadData];
}

- (IBAction)doneClicked:(id)sender {
    self.isEditing = NO;
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editClicked:)] ;
    self.navigationItem.rightBarButtonItem = editButton;
    [self.tableView reloadData];
    if (self.nameField.text.length > 0) {
        NSMutableArray *notes = [[NSMutableArray alloc]init];
        notes = [self.dbManager getNotesByTask:self.task];
        [self.dbManager deleteAllNotesToTask:self.task];
        [self.dbManager deleteTask:self.task];
        self.task = [[Task alloc]init];
        self.task.name = self.nameField.text;
        self.task.description = self.descriptionField.text;
        self.task.category = self.categoryField.text;
        self.task.date = self.dateField.text;
        [self.dbManager insertTask:self.task];
        for(int i=0; i<notes.count; i++){
            [self.dbManager insertNote:[notes objectAtIndex:i] :self.task];
        }
    }
    [self.delegate reloadTableData:self];
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
    if (self.isEditing==YES) {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        CGRect cellRect = [cell bounds];
        CGFloat cellWidth = cellRect.size.width;
        CGFloat cellHeight = cellRect.size.height;
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, cellWidth,cellHeight)];
                cell.textLabel.text = @"";
                self.nameField.text = self.task.name;
                [cell.contentView addSubview:self.nameField];
            }else if (indexPath.row == 1){
                cell.textLabel.text = @"";
                cell.detailTextLabel.text = @"";
                self.descriptionField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, cellWidth, cellHeight)];
                self.descriptionField.text = self.task.description;
                [cell.contentView addSubview:self.descriptionField];
            }else if (indexPath.row == 2){
                cell.textLabel.text = @"Date:";
                cell.detailTextLabel.text = @"";
                self.dateField = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, cellWidth, cellHeight)];
                self.dateField.text = self.task.date;
                [cell.contentView addSubview:self.dateField];
            }else if (indexPath.row == 3){
                cell.textLabel.text = @"Category:";
                cell.detailTextLabel.text = @"";
                self.categoryField = [[UITextField alloc] initWithFrame:CGRectMake(95, 0, cellWidth, cellHeight)];
                //self.categoryField.text = self.task.category.name;
                [cell.contentView addSubview:self.categoryField];
            }
        }else if(indexPath.section == 1 && self.isEditing == NO){
            cell.textLabel.text = @"View Notes";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }else if(indexPath.section == 1 && self.isEditing == YES){
            cell.textLabel.text = @"Manage Notes";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }else{
            cell.textLabel.text = @"Delete Task";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = self.task.name;
            self.nameField.hidden = YES;
        }else if (indexPath.row == 1){
            cell.textLabel.text = self.task.description;
            self.dateField.hidden = YES;
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"Date:";
            cell.detailTextLabel.text = self.task.date;
            self.dateField.hidden = YES;
        }else if (indexPath.row == 3){
            cell.textLabel.text = @"Category:";
            self.categoryField.hidden = YES;
            //cell.detailTextLabel.text = self.task.category.name;
        }
    }else if(indexPath.section == 1){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.text = @"View Notes";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    }
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
