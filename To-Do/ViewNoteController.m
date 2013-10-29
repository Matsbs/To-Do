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
    self.title = @"Details";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStyleGrouped];
    self.tableView.rowHeight = 60;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editClicked:)] ;
    self.navigationItem.rightBarButtonItem = editButton;
    
    //UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneClicked:)] ;
    //self.navigationItem.rightBarButtonItem = doneButton;
}

- (IBAction)editClicked:(id)sender {
    self.isEditing = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(doneClicked:)] ;
    self.navigationItem.rightBarButtonItem = doneButton;
    [self.tableView reloadData];
    
    
   //Call removeItemViewController in mainView
    //[self.delegate removeItemViewController:self didFinishEnteringItem:self.task];
    //[self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)doneClicked:(id)sender {
    self.isEditing = NO;
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editClicked:)] ;
    self.navigationItem.rightBarButtonItem = editButton;
    [self.tableView reloadData];
    
    if (self.nameField.text.length > 0) {
        self.task = [[Task alloc] init];
        self.task.name = self.nameField.text;
        self.task.category.name = self.categoryField.text;
        //self.task.note.description = self.noteField.text;
        self.task.date = self.dateField.text;
        //Call the addItemViewController in mainView to add task to taskArray
        [self.delegate addItemViewController:self didFinishEnteringItem:self.task];
    }
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
    //Check if the task has changed, and update--> or just delete and create.
    
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
                self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, cellWidth,cellHeight)];
                cell.textLabel.text = @"Title";
                self.nameField.text = self.task.name;
                //self.nameField.delegate = self;
                [cell.contentView addSubview:self.nameField];
                //cell.textLabel.text = self.task.name;
            }else if (indexPath.row == 1){
                cell.textLabel.text = @"Description:";
                cell.detailTextLabel.text = @"";
                self.descriptionField = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, cellWidth, cellHeight)];
                self.descriptionField.text = self.task.description;
                //self.dateField.delegate = self;
                [cell.contentView addSubview:self.descriptionField];
                
                //cell.textLabel.text = @"Test:";
                //cell.detailTextLabel.text = self.task.date;
            }else if (indexPath.row == 2){
                cell.textLabel.text = @"Date:";
                cell.detailTextLabel.text = @"";
                self.dateField = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, cellWidth, cellHeight)];
                self.dateField.text = self.task.date;
                //self.dateField.delegate = self;
                [cell.contentView addSubview:self.dateField];

                //cell.textLabel.text = @"Test:";
                //cell.detailTextLabel.text = self.task.date;
            }else if (indexPath.row == 3){
                cell.textLabel.text = @"Category:";
                cell.detailTextLabel.text = @"";
                self.categoryField = [[UITextField alloc] initWithFrame:CGRectMake(95, 0, cellWidth, cellHeight)];
                self.categoryField.text = self.task.category.name;
                //self.categoryField.delegate = self;
                [cell.contentView addSubview:self.categoryField];
                //cell.textLabel.text = @"Test:";
                //cell.detailTextLabel.text = self.task.category.name;
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
            cell.detailTextLabel.text = self.task.category.name;
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

//Extra functions

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        NotesViewController *noteView = [[NotesViewController alloc] init];
        //noteView.delegate = self;
        [self.navigationController pushViewController:noteView animated:YES];
    }else if (indexPath.section==2){
        [self.delegate removeItemViewController:self didFinishEnteringItem:self.task];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
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
