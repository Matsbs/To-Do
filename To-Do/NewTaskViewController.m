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

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    self.dbManager = [[DBManager alloc]init];
    [self.dbManager setDbPath];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight+300) style:UITableViewStyleGrouped];
    self.tableView.scrollEnabled = YES;
    self.tableView.rowHeight = 50;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    if (self.isEditingExistingTask) {
        self.title = @"Edit Task";
    }else{
        self.title = @"New Task";
    }
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(doneClicked:)] ;
    self.navigationItem.rightBarButtonItem = doneButton;
    
    self.categories = [self.dbManager getAllCategories];
}

- (void) hideKeyboard{
    [self.nameField resignFirstResponder];
    [self.descriptionField resignFirstResponder];
}

- (IBAction)doneClicked:(id)sender {
     LogManager *logMan = [[LogManager alloc] init];
    if (self.isEditingExistingTask==YES) {
//        NSMutableArray *notes = [[NSMutableArray alloc]init];
//        notes = [self.dbManager getNotesByTask:self.task];
//        [self.dbManager deleteAllNotesToTask:self.task];
//        [self.dbManager deleteTask:self.task];
        self.task.name = self.nameField.text;
        self.task.description = self.descriptionField.text;
        self.task.category = self.categoryField.text;
        self.task.date = self.dateField.text;
        [self.dbManager updateTask:self.task];
        [logMan writeToLog:UpdateTask :self.task];
//        for(int i=0; i<notes.count; i++){
//            [self.dbManager insertNote:[notes objectAtIndex:i]];
//        }
        self.delegate = [self.navigationController.viewControllers objectAtIndex:0];
    }else{
        if (self.nameField.text.length > 0) {
            self.task = [[Task alloc]init];
            self.task.name = self.nameField.text;
            self.task.description = self.descriptionField.text;
            self.task.date = self.dateField.text;
            self.task.category = self.categoryField.text;
            self.task.taskID = [self.dbManager insertTask:self.task];
            [logMan writeToLog:CreateTask :self.task];
        }
    }
    [self.delegate reloadTableData:self];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-( IBAction)resignPicker:(id)sender {
    [self.dateField resignFirstResponder];
    [self.categoryField resignFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.isEditingExistingTask) {
        return 2;
    }else{
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isEditingExistingTask) {
        if (section == 0) {
            return 4;
        }else {
            return 1;
        }
    }else{
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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
            self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, cellWidth,cellHeight)];
            if (self.isEditingExistingTask==YES) {
                self.nameField.text = self.task.name;
            }else{
                self.nameField.placeholder = @"Title";
            }
            self.nameField.delegate = self;
            [cell.contentView addSubview:self.nameField];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else if(indexPath.row == 1){
            self.descriptionField = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, cellWidth, cellHeight)];
            if (self.isEditingExistingTask==YES) {
                self.descriptionField.text = self.task.debugDescription;
            }else{
                self.descriptionField.placeholder = @"Description";
            }
            self.descriptionField.delegate = self;
            [cell.contentView addSubview:self.descriptionField];
        }else if(indexPath.row == 2){
            cell.textLabel.text = @"Date:";
            self.dateField = [[UITextField alloc] initWithFrame:CGRectMake(60, 4, cellWidth, cellHeight)];
            self.picker = [[UIDatePicker alloc]init];
            self.picker.datePickerMode = UIDatePickerModeDate;
            [self.picker addTarget:self action:@selector(LabelChange:) forControlEvents:UIControlEventValueChanged];
            
            UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
            pickerToolbar.barStyle = UIBarStyleDefault;
            [pickerToolbar sizeToFit];
            NSMutableArray *barItems = [[NSMutableArray alloc] init];
            
            UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(resignPicker:)];
            [barItems addObject:btnCancel];
            
            UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
            [barItems addObject:flexSpace];
            
            flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
            [barItems addObject:flexSpace];
            
            UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignPicker:)];
            [barItems addObject:doneBtn];
            
            [pickerToolbar setItems:barItems animated:YES];
            if (self.isEditingExistingTask==YES) {
                self.dateField.text = self.task.date;
            }
            self.dateField.delegate= self;
            [self.dateField setInputView:self.picker];
            self.dateField.inputAccessoryView = pickerToolbar;
            [cell.contentView addSubview:self.dateField];
        }else if(indexPath.row == 3){
            cell.textLabel.text = @"Category:";
            self.categoryField = [[UITextField alloc] initWithFrame:CGRectMake(100, 7, self.view.frame.size.width, 40)];
            
           self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
            self.pickerView.delegate = self;
            self.pickerView.dataSource = self;
            self.pickerView.showsSelectionIndicator = YES;

            UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
            pickerToolbar.barStyle = UIBarStyleDefault;
            [pickerToolbar sizeToFit];
            NSMutableArray *barItems = [[NSMutableArray alloc] init];
            
            UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(resignPicker:)];
            [barItems addObject:btnCancel];
            
            UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
            [barItems addObject:flexSpace];
            
            flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
            [barItems addObject:flexSpace];
            
            UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignPicker:)];
            [barItems addObject:doneBtn];
            
            [pickerToolbar setItems:barItems animated:YES];
            if (self.isEditingExistingTask==YES) {
                self.categoryField.text = self.task.category;
            }
            self.pickerView.delegate = self;
            [self.categoryField setInputView:self.pickerView];
            self.categoryField.inputAccessoryView=pickerToolbar;
            [cell.contentView addSubview:self.categoryField];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0){
            if (self.isEditingExistingTask==YES) {
                cell.textLabel.text = @"Manage Notes";
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
            }else{
                //cell.textLabel.text = @"Add Notes";
                //cell.textLabel.textAlignment = NSTextAlignmentCenter;
            }
        }
    }
    return cell;
}

-(void)LabelChange:(id)sender{
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter1 setTimeStyle:NSDateFormatterNoStyle];
    NSString *dateString = [dateFormatter1 stringFromDate: self.picker.date];
    NSLog(@"Date:,%@",dateString);
    self.dateField.text = dateString;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"You entered %@",textField.text);
    [self hideKeyboard];
    if (textField.tag == 1){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.35f];
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        [self.view setFrame:frame];
        [UIView commitAnimations];
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==1) {
        NotesViewController *noteView = [[NotesViewController alloc] init];
        noteView.canEdit = YES;
        if (self.isEditingExistingTask==YES){
            noteView.task = self.task;
        }else{
//            self.task = [[Task alloc]init];
//            self.task.name = self.nameField.text;
//            self.task.description = self.descriptionField.text;
//            self.task.date = self.dateField.text;
//            self.task.category = self.categoryField.text;
//            [self.dbManager insertTask:self.task];
//            noteView.task = self.task;
        }
        [self.navigationController pushViewController:noteView animated:YES];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component{
    self.categoryField.text = [[self.categories objectAtIndex:row] name];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.categories count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[self.categories objectAtIndex:row] name];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    return screenWidth;
}


//Extra functions

/*
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    //Notes field started being edited
    if (textField.tag == 1){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.35f];
        CGRect frame = self.view.frame;
        frame.origin.y = -120;
        [self.view setFrame:frame];
        [UIView commitAnimations];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 1){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.35f];
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        [self.view setFrame:frame];
        [UIView commitAnimations];
    }
}*/

/*
-(IBAction)test:(id)sender{
    self.task.note.description = @"hello";
    [self.task.notes addObject:self.task.note];
    NSLog(@"Number of notes %i",self.task.notes.count);
    NSIndexSet *section1 = [NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:section1 withRowAnimation:UITableViewRowAnimationAutomatic];
    //[self.tableView reloadData];
}*/

/*
-(IBAction)removeNote:(id)sender{
    NSLog(@"Remove sender tag: %i", [sender tag]);
    [self.task.notes removeObjectAtIndex:0];
    NSIndexSet *section1 = [NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:section1 withRowAnimation:UITableViewRowAnimationAutomatic];
}*/

//    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
//    [self.tableView addGestureRecognizer:gestureRecognizer];

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
