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


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self loadFromMemory];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    self.title = @"Notes";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStylePlain];
    self.tableView.rowHeight = 60;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
//    UIBarButtonItem *newButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(newClicked:)] ;
//    self.navigationItem.rightBarButtonItem = newButton;
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (IBAction)newClicked:(id)sender {
    NewTaskViewController *newTaskView = [[NewTaskViewController alloc] init];
    //newTaskView.delegate = self;
    [self.navigationController pushViewController:newTaskView animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = self.taskArray.count;
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
    
    if (indexPath.row < self.taskArray.count ) {
        self.task= [self.taskArray objectAtIndex:indexPath.row];
        cell.textLabel.text = self.task.name;
        cell.detailTextLabel.text = self.task.date;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.textLabel.text = @"Add New Note";
        //cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if ((indexPath.row < self.taskArray.count) && !self.editing) {
//        ViewNoteController *viewNote = [[ViewNoteController alloc] init];
//        viewNote.task = [self.taskArray objectAtIndex:indexPath.row];
//        viewNote.delegate = self;
//        [self.navigationController pushViewController:viewNote animated:YES];
//    }else if ((indexPath.row == self.taskArray.count) && self.editing){
//        NewTaskViewController *newTaskView = [[NewTaskViewController alloc] init];
//        newTaskView.delegate = self;
//        [self.navigationController pushViewController:newTaskView animated:YES];
//        //[self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//        //reloadRowsAtIndexPaths:withRowAnimation:
//    }
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.taskArray.count ) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleInsert;
    }
    
}

-(void)setEditing:(BOOL)editing animated:(BOOL) animated {
    if( editing != self.editing ) {
        
        [super setEditing:editing animated:animated];
        [self.tableView setEditing:editing animated:animated];
        
        NSArray *indexes =
        [NSArray arrayWithObject:
         [NSIndexPath indexPathForRow:self.taskArray.count inSection:0]];
        if (editing == YES ) {
            [self.tableView insertRowsAtIndexPaths:indexes
                                  withRowAnimation:UITableViewRowAnimationLeft];
        } else {
            [self.tableView deleteRowsAtIndexPaths:indexes
                                  withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
    
    //[super setEditing:editing animated:animated];
    //[self.tableView setEditing:editing animated:animated];
    //[self.tableView reloadData];
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle) editing
 forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editing == UITableViewCellEditingStyleDelete ) {
        [self.taskArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationLeft];
    }else{
        NewTaskViewController *newTaskView = [[NewTaskViewController alloc] init];
        //newTaskView.delegate = self;
        [self.navigationController pushViewController:newTaskView animated:YES];
    }
}

//Extra Functions

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
