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
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneClicked:)] ;
    self.navigationItem.rightBarButtonItem = doneButton;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
}

- (void) hideKeyboard{
    [self.nameField resignFirstResponder];
    [self.dateField resignFirstResponder];
    [self.noteField resignFirstResponder];
}

- (IBAction)doneClicked:(id)sender {
    self.task = [[Task alloc] init];
    self.task.name = self.nameField.text;
    self.task.note = self.noteField.text;
    self.task.date = self.dateField.text;
    //Call the addItemViewController in mainView to add task to taskArray
    [self.delegate addItemViewController:self didFinishEnteringItem:self.task];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    CGRect cellRect = [cell bounds];
    CGFloat cellWidth = cellRect.size.width;
    CGFloat cellHeight = cellRect.size.height;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, cellWidth,cellHeight)];
            self.nameField.placeholder = @"Name";
            self.nameField.delegate = self;
            [cell.contentView addSubview:self.nameField];
        }else if(indexPath.row == 1){
            cell.textLabel.text = @"Date:";
            self.dateField = [[UITextField alloc] initWithFrame:CGRectMake(60, 10, cellWidth, cellHeight)];
            self.dateField.placeholder = @"";
            self.dateField.delegate = self;
            [cell.contentView addSubview:self.dateField];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Notes";
        }else{
            self.noteField = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, cellWidth, cellHeight)];
            self.noteField.placeholder = @"";
            self.noteField.delegate = self;
            self.noteField.tag = 1;
            [cell.contentView addSubview:self.noteField];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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

//Extra functions

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

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
