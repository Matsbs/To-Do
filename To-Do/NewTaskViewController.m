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
    
    self.title = @"New Task";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight+300) style:UITableViewStyleGrouped];
    self.tableView.scrollEnabled = YES;
    self.tableView.rowHeight = 60;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(doneClicked:)] ;
    self.navigationItem.rightBarButtonItem = doneButton;
    
    self.category = [[NSMutableArray alloc]initWithObjects:@"Cleaning",@"Reminder",@"Errand",@"Economy",@"Food",@"Activity",@"Work",@"School", nil];
    self.task = [[Task alloc] init];
    self.task.notes = [[NSMutableArray alloc]init];
    self.task.note = [[Note alloc] init];
}

- (void) hideKeyboard{
    [self.nameField resignFirstResponder];
    [self.descriptionField resignFirstResponder];
}

- (IBAction)doneClicked:(id)sender {
    if (self.nameField.text.length > 0) {
        self.task.name = self.nameField.text;
        self.task.description = self.descriptionField.text;
        self.task.category.name = self.categoryField.text;
        //Call the addItemViewController in mainView to add task to taskArray
        [self.delegate addItemViewController:self didFinishEnteringItem:self.task];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-( IBAction) resignPicker:(id)sender {
    [self.dateField resignFirstResponder];
    [self.categoryField resignFirstResponder];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    CGRect cellRect = [cell bounds];
    CGFloat cellWidth = cellRect.size.width;
    CGFloat cellHeight = cellRect.size.height;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, cellWidth,cellHeight)];
            self.nameField.placeholder = @"Title";
            self.nameField.delegate = self;
            [cell.contentView addSubview:self.nameField];
        }else if(indexPath.row == 1){
            self.descriptionField = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, cellWidth, cellHeight)];
            self.descriptionField.placeholder = @"Description";
            self.descriptionField.delegate = self;
            [cell.contentView addSubview:self.descriptionField];
        }else if(indexPath.row == 2){
            cell.textLabel.text = @"Date:";
            self.dateField = [[UITextField alloc] initWithFrame:CGRectMake(60, 10, cellWidth, cellHeight)];
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
            self.dateField.delegate= self;
            [self.dateField setInputView:self.picker];
            self.dateField.inputAccessoryView = pickerToolbar;
            [cell.contentView addSubview:self.dateField];
        }else if(indexPath.row == 3){
            cell.textLabel.text = @"Category:";
            self.categoryField = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, self.view.frame.size.width, 40)];
            
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
            self.pickerView.delegate = self;
            [self.categoryField setInputView:self.pickerView];
            self.categoryField.inputAccessoryView=pickerToolbar;
            [cell.contentView addSubview:self.categoryField];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0){
            cell.textLabel.text = @"Add Notes";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
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
    self.task.date = dateString;
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
        [self.navigationController pushViewController:noteView animated:YES];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component{
    NSString *title;
    title = [self.category objectAtIndex:row];
    self.categoryField.text = title;
    self.task.category.name = title;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.category count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    title = [self.category objectAtIndex:row];
    return title;
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
