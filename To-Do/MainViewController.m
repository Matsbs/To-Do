//
//  MainViewController.m
//  MobileApps4Tourism
//
//  Created by Mats Sandvoll on 18.09.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (NSMutableArray* ) taskArray{
    if(_taskArray == nil){
        _taskArray = [[NSMutableArray alloc] init];
    }
    return _taskArray;
}

- (void) createObjects{
    self.task = [[Task alloc] init];
    self.task.name = @"Buy groceries";
    self.task.note = @"Bread, Milk, Water";
    self.task.date = @"16.12.2013";
    [self.taskArray addObject:self.task];
    
    self.task = [[Task alloc] init];
    self.task.name = @"Wash the car";
    self.task.note = @"Remeber to wax as well";
    self.task.date = @"10.11.2013";
    [self.taskArray addObject:self.task];
    
    self.task = [[Task alloc] init];
    self.task.name = @"Pay the phone bill";
    self.task.note = @"Pay for three months";
    self.task.date = @"21.11.2013";
    [self.taskArray addObject:self.task];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //if ([self.taskArray count]==0) {
        self.task = [[Task alloc] init];
        self.task.name = @"Buy groceries";
        self.task.note = @"Bread, Milk, Water";
        self.task.date = @"16.12.2013";
        [self.taskArray addObject:self.task];
        
        self.task = [[Task alloc] init];
        self.task.name = @"Wash the car";
        self.task.note = @"Remeber to wax as well";
        self.task.date = @"10.11.2013";
        [self.taskArray addObject:self.task];
        
        self.task = [[Task alloc] init];
        self.task.name = @"Pay the phone bill";
        self.task.note = @"Pay for three months";
        self.task.date = @"21.11.2013";
        [self.taskArray addObject:self.task];
    //}
    
    
	// Do any additional setup after loading the view.
    //Init objects
    //Move to model? Add Task
    //self.taskArray = [[NSMutableArray alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStylePlain];
    
    self.tableView.rowHeight = 60;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.title = @"To-Do";
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(refreshClicked:)] ;
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    Task *test = [self.taskArray objectAtIndex:1];
    NSLog(@"hei %@",test.name);
    NSLog(@"Number of elements: %lu", (unsigned long)[self.taskArray count]);
    
    
}

- (void)addItemViewController:(NewTaskViewController *)controller didFinishEnteringItem:(Task *)item
{
    NSLog(@"This was returned from ViewControllerB %@",item.name);
    //not working
    [self.taskArray addObject:item];
    NSLog(@"Number of elements: %lu", (unsigned long)[self.taskArray count]);
    [self.tableView reloadData];
    
    if([self.taskArray containsObject:item]){
        NSLog(@"yeyeee");
        //[self.taskArray removeObject:item];
    }
    
}

- (void)removeItemViewController:(ViewNoteController *)controller didFinishEnteringItem:(Task *)item
{
    if([self.taskArray containsObject:item]){
        NSLog(@"yeyeee");
        [self.taskArray removeObject:item];
    }
    [self.tableView reloadData];
    
}

- (IBAction)refreshClicked:(id)sender {
    //[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewTaskViewController *newTaskView = [[NewTaskViewController alloc] init];
    //viewNote.task = [self.taskArray objectAtIndex:indexPath.row];
    newTaskView.delegate = self;
    [self.navigationController pushViewController:newTaskView animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.taskArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    self.task= [self.taskArray objectAtIndex:indexPath.row];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    //CGFloat screenHeight = screenRect.size.height;
//    
//    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, screenWidth, 30)];
//    [name setFont:[UIFont fontWithName:@"FontName" size:12.0]];
//    [name setTextColor:[UIColor blackColor]];
//    name.text = self.task.name;
//    [cell addSubview:name];
//    
//    UILabel *date = [[UILabel alloc]initWithFrame:CGRectMake(20, 25, screenWidth, 30)];
//    [date setFont:[UIFont fontWithName:@"FontName" size:12.0]];
//    [date setTextColor:[UIColor grayColor]];
//    date.text = self.task.date;
//    [cell addSubview:date];
    
    cell.textLabel.text = self.task.name;
    cell.detailTextLabel.text = self.task.date;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    ViewNoteController *viewNote = [[ViewNoteController alloc] init];
    viewNote.task = [self.taskArray objectAtIndex:indexPath.row];
    viewNote.delegate = self;
    [self.navigationController pushViewController:viewNote animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
