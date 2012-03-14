//
//  FirstViewController.h
//  growth
//
//  Created by jungho jang on 12. 1. 30..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UICustomSwitch;
@class SecondViewController;
@interface FirstViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate>
{
    SecondViewController *infoView;
    UICustomSwitch *sex_switch;
    NSDictionary *info;
}
@property (strong, nonatomic) IBOutlet UIScrollView *backScrollView;
@property (strong, nonatomic) SecondViewController *infoView;
@property (strong, nonatomic) UICustomSwitch *sex_switch;
@property (strong, nonatomic) NSDictionary *info;
@property (strong, nonatomic) IBOutlet UIView *switchView;
@property (strong, nonatomic) IBOutlet UITextField *monthTextField;
@property (strong, nonatomic) IBOutlet UITextField *heightTextField;
@property (strong, nonatomic) IBOutlet UITextField *weightTextField;

- (IBAction)showGraph:(id)sender;
- (IBAction)showInfo:(id)sender;
-(void)hideKeyboard;
-(void)confirm:(id)sender;
@end
