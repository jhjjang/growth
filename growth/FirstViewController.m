//
//  FirstViewController.m
//  growth
//
//  Created by jungho jang on 12. 1. 30..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "UICustomSwitch.h"
#import "PageControlViewController.h"
#import "HeightViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize backScrollView;
@synthesize infoView;
@synthesize switchView;
@synthesize sex_switch;
@synthesize monthTextField;
@synthesize heightTextField;
@synthesize weightTextField;
@synthesize info;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    infoView = [[SecondViewController alloc] init];
    
    
    [self hideKeyboard];
    sex_switch = [UICustomSwitch switchWithLeftText:@"남" andRight:@"여"];
    [sex_switch setOn:YES];
    [switchView addSubview:sex_switch];
    
    
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"mainbg.png"]];

    
    
    //당신아이는?
    //유아성장체크
    
}

- (void)viewDidUnload
{
    
    [self setSwitchView:nil];
    [self setMonthTextField:nil];
    [self setHeightTextField:nil];
    [self setWeightTextField:nil];
    [self setInfo:nil];
    [self setBackScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)showGraph:(id)sender {
    NSString *sex = [[NSString alloc] init];
    if ([sex_switch isOn]) {
        sex = @"male";
    }else {
        sex = @"female";
    }
    
    if (monthTextField.text.length==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"아이의 개월수를 입력하세요"
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSUInteger month = [monthTextField.text intValue];
    
    if (month>36) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"최대 개월수는 36개월입니다"
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (heightTextField.text.length==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"아이의 키를 입력하세요"
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (weightTextField.text.length==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"아이의 몸무게를 입력하세요"
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    info = [[NSDictionary alloc] init];
    
    info = [NSDictionary dictionaryWithObjectsAndKeys:monthTextField.text,@"month",
            heightTextField.text, @"height",
            weightTextField.text, @"weight",
            sex, @"sex",
            nil];
    
    
    [self confirm:nil];
    /*
    HeightViewController *v = [[HeightViewController alloc] init];
    v.info = info;
    [self presentModalViewController:v animated:YES];
    */
    PageControlViewController *p = [[PageControlViewController alloc] init];
    p.info = info;
    [self presentModalViewController:p animated:YES];
}

- (IBAction)showInfo:(id)sender {
    [self presentModalViewController:infoView animated:YES];
}

#pragma mark - Keyboard hide
-(void)hideKeyboard
{

    UIToolbar *inputAccessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 20.0)];
    inputAccessoryView.barStyle = UIBarStyleBlackTranslucent;
    inputAccessoryView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [inputAccessoryView sizeToFit];
    CGRect frame = inputAccessoryView.frame;
    frame.size.height = 44.0f;
    inputAccessoryView.frame = frame;
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                             target:self
                                                                             action:@selector(confirm:)];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:self
                                                                                   action:nil];
    NSArray *array = [NSArray arrayWithObjects:flexibleSpace,doneBtn, nil];
    [inputAccessoryView setItems:array];
    
    
    
    monthTextField.inputAccessoryView = inputAccessoryView;
    heightTextField.inputAccessoryView = inputAccessoryView;
    weightTextField.inputAccessoryView = inputAccessoryView;
}

-(void)confirm:(id)sender
{
    [monthTextField resignFirstResponder];
    [heightTextField resignFirstResponder];
    [weightTextField resignFirstResponder];
    
    [backScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}


#pragma mark - textFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //NSLog(@"%f",textField.frame.origin.y);
    [backScrollView setContentOffset:CGPointMake(0, textField.frame.origin.y-50) animated:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
}

@end
