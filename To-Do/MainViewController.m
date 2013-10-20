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
    
    [self loadFromMemory];
    //self.taskArray = [[NSMutableArray alloc ] init];
    //self.taskArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]
                                                     //objectForKey:@"Key1"]];

//    if ([self.taskArray count]==0) {
//        
//        NSMutableArray *test1 = [[NSMutableArray alloc] init];
//        self.task = [[Task alloc] init];
//        self.task.name = @"Buy groceries";
//        self.task.note = @"Bread, Milk, Water";
//        self.task.date = @"16.12.2013";
//        [self.taskArray addObject:self.task];
//        [test1 addObject:self.task.name];
//        [test1 addObject:self.task.note];
//        [test1 addObject:self.task.date];
//        
//        
//        self.task = [[Task alloc] init];
//        self.task.name = @"Wash the car";
//        self.task.note = @"Remember to wax as well";
//        self.task.date = @"10.11.2013";
//        [self.taskArray addObject:self.task];
//        
//        self.task = [[Task alloc] init];
//        self.task.name = @"Pay the phone bill";
//        self.task.note = @"Pay for three months";
//        self.task.date = @"21.11.2013";
//        [self.taskArray addObject:self.task];
//        
//        
//        [[NSUserDefaults standardUserDefaults] setObject:@"text to save" forKey:@"Key"];
//        
//        //NSMutableArray *test = [[NSMutableArray alloc] init];
//        
//        //[[NSUserDefaults standardUserDefaults] setObject:self.taskArray forKey:@"Key12"];
//        
//        
//        
//    }
    
    
    
    
    
	// Do any additional setup after loading the view.
    //Init objects
    //Move to model? Add Task
    //self.taskArray = [[NSMutableArray alloc] init];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStylePlain];
    
    self.tableView.rowHeight = 60;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.title = @"To-Do";
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(refreshClicked:)] ;
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    //Task *test = [self.taskArray objectAtIndex:1];
    //NSLog(@"hei %@",test.name);
    //NSLog(@"Number of elements: %lu", (unsigned long)[self.taskArray count]);
    NSLog(@"%@", [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys]);
}

- (void)addItemViewController:(NewTaskViewController *)controller didFinishEnteringItem:(Task *)item
{
    NSLog(@"This was returned from ViewControllerB %@",item.name);
    //not working
    [self.taskArray addObject:item];
    //NSLog(@"Number of elements: %lu", (unsigned long)[self.taskArray count]);
    [self.tableView reloadData];
    
    if([self.taskArray containsObject:item]){
        NSLog(@"yeyeee");
        //[self.taskArray removeObject:item];
    }
   
    
    
    //[[NSUserDefaults standardUserDefaults] setObject:@"hei" forKey:@"Key"];
    NSString *fromMem = [[NSString alloc] init];
    fromMem = [[NSUserDefaults standardUserDefaults] objectForKey:@"Key"];
    NSLog(@"from mem: %@",fromMem);
    
    [self saveToMemory];
    
    NSLog(@"%@", [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys]);
}

- (void) saveToMemory{
    [self resetDefaults];
    for (int i=0; i<[self.taskArray count]; i++) {
        NSString *counter = [NSString stringWithFormat:@"%d",i];
        NSString *name = @"Task";
        NSString *task = [name stringByAppendingString:counter];
        NSString *key1 = [task stringByAppendingString:@"name"];
        Task *taskObject = [self.taskArray objectAtIndex:i];
        [[NSUserDefaults standardUserDefaults] setObject:taskObject.name forKey:key1];
        NSString *key2 = [task stringByAppendingString:@"date"];
        [[NSUserDefaults standardUserDefaults] setObject:taskObject.date forKey:key2];
        NSString *key3 = [task stringByAppendingString:@"note"];
        [[NSUserDefaults standardUserDefaults] setObject:taskObject.note forKey:key3];
        NSLog(@"Saved to mem %@",key1);
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)resetDefaults {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}

- (void) loadFromMemory{
    NSString *key1 = [@"Task1" stringByAppendingString:@"name"];
    NSString *testing = [[NSUserDefaults standardUserDefaults] objectForKey:@"hei"];
    NSLog(@"dette er første mem:%@",testing);
    
    for (int i=0; i<20; i++) {
        NSString *counter = [NSString stringWithFormat:@"%d",i];
        NSString *name = @"Task";
        NSString *task = [name stringByAppendingString:counter];
        NSString *key1 = [task stringByAppendingString:@"name"];
        self.task = [[Task alloc] init];
        self.task.name = [[NSUserDefaults standardUserDefaults] objectForKey:key1];
        NSString *key2 = [task stringByAppendingString:@"date"];
        self.task.date = [[NSUserDefaults standardUserDefaults] objectForKey:key2];
        NSString *key3 = [task stringByAppendingString:@"note"];
        self.task.note = [[NSUserDefaults standardUserDefaults] objectForKey:key3];
        if ([self.task.name length]!=0){
            [self.taskArray addObject:self.task];

        }
        NSLog(@"Navn:%@",key1);
        NSLog(@"%lu",(unsigned long)[self.task.name length]);
        NSLog(@"Loaded from mem!");
    }
}

- (void)removeItemViewController:(ViewNoteController *)controller didFinishEnteringItem:(Task *)item
{
    if([self.taskArray containsObject:item]){
        NSLog(@"yeyeee");
        [self.taskArray removeObject:item];
    }
    [self.tableView reloadData];
    
    [self saveToMemory];
    
    NSLog(@"%@", [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys]);
    
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
