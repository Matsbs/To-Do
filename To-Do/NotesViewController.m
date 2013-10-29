//
//  NotesViewController.m
//  To-Do
//
//  Created by Mats Sandvoll on 28.10.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import "NotesViewController.h"

@interface NotesViewController ()

@end

@implementation NotesViewController

- (NSMutableArray* ) notes{
    if(_notes == nil){
        _notes = [[NSMutableArray alloc] init];
    }
    return _notes;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    self.title = @"Notes";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStylePlain];
    self.tableView.rowHeight = 60;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (IBAction)newClicked:(id)sender {
    NewTaskViewController *newTaskView = [[NewTaskViewController alloc] init];
    [self.navigationController pushViewController:newTaskView animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = self.notes.count;
    if(self.editing) {
        count = count + 1;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    if (indexPath.row < self.notes.count ) {
        cell.textLabel.text = [self.notes objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        self.noteField = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, cell.bounds.size.width, cell.bounds.size.height)];
        self.noteField.placeholder = @"Add New Note";
        [cell.contentView addSubview:self.noteField];
        //cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.notes.count ) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleInsert;
    }
}

-(void)setEditing:(BOOL)editing animated:(BOOL) animated {
    if(editing != self.editing ) {
        [super setEditing:editing animated:animated];
        [self.tableView setEditing:editing animated:animated];
        NSArray *indexes =[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.notes.count inSection:0]];
        if (editing == YES ) {
            [self.tableView insertRowsAtIndexPaths:indexes
                                  withRowAnimation:UITableViewRowAnimationLeft];
        } else {
            [self.tableView deleteRowsAtIndexPaths:indexes
                                  withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle) editing
 forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editing == UITableViewCellEditingStyleDelete ) {
        [self.notes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationLeft];
    }else{
        NSString *test = [[NSString alloc] init];
        test = @"";
        [self.notes addObject:test];
        [self.tableView reloadData];
    }
}

//Extra Functions

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
