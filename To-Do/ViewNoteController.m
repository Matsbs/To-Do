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
    
//    self.dateView = [[UITextView alloc] initWithFrame:CGRectMake(20, 50, 50, 20)];
//    self.dateView.text = self.task.note;
//    self.dateView.editable = NO;
//    self.dateView.scrollEnabled = YES;
//    self.dateView.font = [UIFont fontWithName:@"Helvetica" size:14];
//    [self.view addSubview:self.dateView];
//   
//
//    self.noteView = [[UITextView alloc] initWithFrame:CGRectMake(20, 150, 50, 20)];
//    self.noteView.text = self.task.note;
//    self.noteView.editable = NO;
//    self.noteView.scrollEnabled = YES;
//    self.noteView.font = [UIFont fontWithName:@"Helvetica" size:14];
//    [self.view addSubview:self.noteView];
    
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStyleGrouped];
    
    self.tableView2.rowHeight = 60;
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    [self.view addSubview:self.tableView2];
    self.title = @"Details";
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(refreshClicked:)] ;
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    
    
 
    
}

- (IBAction)refreshClicked:(id)sender {
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView2{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView2 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
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
    
        
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = self.task.name;
        }else if (indexPath.row ==1){
            cell.textLabel.text = @"Date";
            cell.detailTextLabel.text = self.task.date;
        }
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Notes";
        }else{
            cell.textLabel.text = self.task.note;
        }
    }
        //cell.detailTextLabel.text = self.task.date;
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

@end
