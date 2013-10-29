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
    
    self.task = [[Task alloc] init];
    
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
    
 self.category = [[NSMutableArray alloc]initWithObjects:@"Sport",@"Nightlife",@"Monuments", nil];
    //NSLog(@"object at 1%@",[self.category objectAtIndex:0]);
    //[self.view addSubview:myPickerView];
    
//    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
//    [self.tableView addGestureRecognizer:gestureRecognizer];
    
    self.task = [[Task alloc] init];
    self.task.notes = [[NSMutableArray alloc]init];
    self.task.note = [[Note alloc] init];
   
}

- (void) hideKeyboard{
    [self.nameField resignFirstResponder];
    [self.descriptionField resignFirstResponder];
    //[self.noteField resignFirstResponder];
    //[self.categoryField resignFirstResponder];
}

- (IBAction)doneClicked:(id)sender {
    if (self.nameField.text.length > 0) {
        //self.task = [[Task alloc] init];
        self.task.name = self.nameField.text;
        self.task.description = self.descriptionField.text;
        self.task.category.name = self.categoryField.text;
        //self.task.note.description = self.noteField.text;
        //self.task.date = self.dateField.text;
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
//        if (self.task.notes.count>0) {
//            return self.task.notes.count+1;
//        }else{
//            return 1;
//        }
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
            //cell.textLabel.text = @"Description:";
            self.descriptionField = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, cellWidth, cellHeight)];
            self.descriptionField.placeholder = @"Description";
            self.descriptionField.delegate = self;
            [cell.contentView addSubview:self.descriptionField];
        }else if(indexPath.row == 2){
            cell.textLabel.text = @"Date:";
            
            self.dateField = [[UITextField alloc] initWithFrame:CGRectMake(60, 10, cellWidth, cellHeight)];
            //self.dateField.placeholder = @"";
            //self.dateField.delegate = self;ini
            //[cell.contentView addSubview:self.dateField];
//            self.myPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, cellWidth)];
//            self.myPicker.delegate = self;
//            self.myPicker.showsSelectionIndicator = YES;
//            [cell.contentView addSubview:self.myPicker];
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
            
            //[self.picker addSubview:pickerToolbar];
            
            //datePicker.tag = indexPath.row;
            self.dateField.delegate= self;
            [self.dateField setInputView:self.picker];
            self.dateField.inputAccessoryView = pickerToolbar;
            //[cell.contentView addSubview:datePicker];
            [cell.contentView addSubview:self.dateField];
        }else if(indexPath.row == 3){
            cell.textLabel.text = @"Category:";
            self.categoryField = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, self.view.frame.size.width, 40)];
            
           self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
            self.pickerView.delegate = self;
            self.pickerView.dataSource = self;
            self.pickerView.showsSelectionIndicator = YES;
            

            //[self.view addSubview:self.pickerView];
            
            //self.picker.datePickerMode = UIDatePickerModeDate;
            //[self.picker addTarget:self action:@selector(LabelChange:) forControlEvents:UIControlEventValueChanged];
            
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
            
            //[self.pickerView addSubview:pickerToolbar];
            
            [self.categoryField setInputView:self.pickerView];
            self.categoryField.inputAccessoryView=pickerToolbar;
            [cell.contentView addSubview:self.categoryField];
            
            
            //datePicker.tag = indexPath.row;
            //self.categoryField.delegate= self;
            //[self.categoryField setInputView:self.pickerView];
            //[cell.contentView addSubview:datePicker];
            //[cell.contentView addSubview:self.categoryField];
            
//            cell.textLabel.text = @"Category:";
//            self.categoryField = [[UITextField alloc] initWithFrame:CGRectMake(95, 10, cellWidth, cellHeight)];
//            self.categoryField.placeholder = @"";
//            self.categoryField.delegate = self;
//            [cell.contentView addSubview:self.categoryField];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0){
            cell.textLabel.text = @"Add Notes";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//            //button.titleLabel.text = @"Add note";
//            //set the position of the button
//            button.frame = CGRectMake(cell.frame.origin.x + 200, cell.frame.origin.y, 100, 60);
//            [button setTitle:@"Add note" forState:UIControlStateNormal];
//            [button addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
//            button.backgroundColor= [UIColor clearColor];
//            [cell.contentView addSubview:button];
            
//        }else{
////            self.noteField = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, cellWidth, cellHeight)];
////            self.noteField.placeholder = @"";
////            self.noteField.delegate = self;
////            self.noteField.tag = 1;
////            [cell.contentView addSubview:self.noteField];
//            UITextField *noteField = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, cellWidth, cellHeight)];
//            noteField.placeholder = @"";
//            noteField.delegate = self;
//            noteField.tag = 1;
//            [cell.contentView addSubview:noteField];
//            
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//            //set the position of the button
//            button.frame = CGRectMake(cell.frame.origin.x + 200, cell.frame.origin.y, 100, 60);
//            [button setTitle:@"Remove note" forState:UIControlStateNormal];
//            [button addTarget:self action:@selector(removeNote:) forControlEvents:UIControlEventTouchUpInside];
//            button.backgroundColor= [UIColor clearColor];
//            [button setTag:indexPath.row];
//            [cell.contentView addSubview:button];
            
        }
    }
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    //PRINT ALL TAGS AND UPDATE!
}

-(void)LabelChange:(id)sender{
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter1 setTimeStyle:NSDateFormatterNoStyle];
    
    NSString *dateString = [dateFormatter1 stringFromDate: self.picker.date];
    NSLog(@"Date:,%@",dateString);
    self.dateField.text = dateString;
    self.task.date = dateString;
    //[self.tableView reloadData];
}

-(IBAction)removeNote:(id)sender{
    NSLog(@"Remove sender tag: %i", [sender tag]);
    [self.task.notes removeObjectAtIndex:0];
    NSIndexSet *section1 = [NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:section1 withRowAnimation:UITableViewRowAnimationAutomatic];
    //[self.tableView reloadData];
}
-(IBAction)test:(id)sender{
    self.task.note.description = @"hello";
    [self.task.notes addObject:self.task.note];
    
    NSLog(@"Number of notes %i",self.task.notes.count);
    
    NSIndexSet *section1 = [NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:section1 withRowAnimation:UITableViewRowAnimationAutomatic];
    //[self.tableView reloadData];
}

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
        //noteView.delegate = self;
        [self.navigationController pushViewController:noteView animated:YES];
    }else if (indexPath.section==0){
        
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    NSString *title;
    //title = [@"" stringByAppendingFormat:@"%d",row];
    //NSLog(@"test:%@",title);
    title = [self.category objectAtIndex:row];
    self.categoryField.text = title;
    self.task.category.name = title;
    //[self.tableView reloadData];
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    //NSUInteger numRows = 5;
    return [self.category count];
    //return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    //title = [@"" stringByAppendingFormat:@"%d",row];
    title = [self.category objectAtIndex:row];
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}


//Extra functions



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
