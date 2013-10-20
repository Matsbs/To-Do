//
//  NewTaskViewController.m
//  To-Do
//
//  Created by Mats Sandvoll on 13.10.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import "NewTaskViewController.h"


@interface NewTaskViewController ()

@end

@implementation NewTaskViewController 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //MAKE A TABLE VIEW
    
    self.title = @"New Task";
    
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
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    self.tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight+300) style:UITableViewStyleGrouped];
    self.tableView3.scrollEnabled = YES;
    self.tableView3.rowHeight = 60;
    self.tableView3.delegate = self;
    self.tableView3.dataSource = self;
    [self.view addSubview:self.tableView3];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(refreshClicked:)] ;
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    
    
}


- (IBAction)refreshClicked:(id)sender {
    //UITextField *test = (UITextField*) sender;
//Add task to memory
    //NSLog(@"hei %@",self.textField.text);
    self.task = [[Task alloc] init];
    self.task.name = self.nameField.text;
    self.task.note = self.noteField.text;
    self.task.date = self.dateField.text;
    //[taskArray addObject:self.task];
    
    //NSString *itemToPassBack = @"Pass this value back to ViewControllerA";
    [self.delegate addItemViewController:self didFinishEnteringItem:self.task];
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //if (section==0) {
        return 2;
    //}//else{
        //return 1;
    //}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView3 dequeueReusableCellWithIdentifier:CellIdentifier];
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
            self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(15, 15, 185, 40)];
            self.nameField.placeholder = @"Name";
            self.nameField.delegate = self;
            [cell.contentView addSubview:self.nameField];
            //cell.textLabel.text = @"";
        }else if(indexPath.row == 1){
            cell.textLabel.text = @"Date:";
            self.dateField = [[UITextField alloc] initWithFrame:CGRectMake(60, 10, 185, 40)];
            self.dateField.placeholder = @"01.01.2013";
            self.dateField.delegate = self;
            [cell.contentView addSubview:self.dateField];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Notes";
        }else{
            self.noteField = [[UITextField alloc] initWithFrame:CGRectMake(15, 15, 185, 40)];
            self.noteField.placeholder = @"";
            self.noteField.delegate = self;
            [cell.contentView addSubview:self.noteField];
        }
    }
    
    
    
    
    
    
    
    //[self.textField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
    //self.textField.adjustsFontSizeToFitWidth = YES;
    //playerTextField.textColor = [UIColor blackColor];
    
    //playerTextField.keyboardType = UIKeyboardTypeEmailAddress;
  //self.textField.returnKeyType = UIReturnKeyNext;

    //playerTextField.backgroundColor = [UIColor whiteColor];
    //playerTextField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
    //playerTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
    //playerTextField.textAlignment = UITextAlignmentLeft;
    //playerTextField.tag = 0;
    //playerTextField.delegate = self;
    
    //playerTextField.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
    //[playerTextField setEnabled: YES];
    
    
    //[self.textField addTarget:self action:@selector(editingEnded) forControlEvents:UIControlEventEditingDidEnd];

    //cell.detailTextLabel.text = @"Date";
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"Text field ended editing");
    
}

- (void) editingEnded{
    //NSLog(@"ENDED");
    //Nself.textField.text;
    //NSLog(sender.text);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"You entered %@",textField.text);
    [self.nameField resignFirstResponder];
    [self.dateField resignFirstResponder];
    [self.noteField resignFirstResponder];
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 100, 100)];
//    datePicker.datePickerMode = UIDatePickerModeDate;
//    datePicker.hidden = NO;
//    datePicker.date = [NSDate date];
//    [datePicker addTarget:self
//                   action:nil
//         forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:datePicker];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView3 dequeueReusableCellWithIdentifier:CellIdentifier];
  
        cell.textLabel.text = @"";
    //if (indexPath.section ==1) {
        //UIView *newFrame = [[UIView alloc] initWithFrame:CGRectMake(0, 400, 320,320)];
        //[self.view addSubview:newFrame];
        //NSLog(@"added view");
    //}
    
    
}




@end
