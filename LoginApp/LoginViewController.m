//
//  LoginViewController.m
//  LoginApp
//
//  Created by User on 3/16/16.
//  Copyright © 2016 Lilit Khachatryan. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *remeberPassword;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginToButtomDistance;
@property (nonatomic) CGFloat loginToButtomDistanceFromStoryBoard;
@property (weak, nonatomic) IBOutlet UIButton *rememberMeCheckBox;
@property (weak, nonatomic) IBOutlet UIButton *rememberMeButton;

@end




@implementation LoginViewController

@synthesize loginToButtomDistanceFromStoryBoard;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //check-box setup
    UIColor *colorStateSelected = [UIColor colorWithRed:172/255.0 green:30/255.0 blue:30/255.0 alpha:1];
    UIColor *colorStateNormal = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:186/255.0 alpha:1];
    
    [self.rememberMeCheckBox setTitle:@"✓" forState:UIControlStateSelected];
    [self.rememberMeCheckBox setTitle:@"" forState:UIControlStateNormal];
    [[self.rememberMeCheckBox layer] setBorderWidth:1];
    [[self.rememberMeCheckBox layer] setBorderColor:[colorStateSelected CGColor]];
    
    [self.rememberMeButton setTitleColor:colorStateSelected forState:UIControlStateSelected];
    [self.rememberMeButton setTitleColor:colorStateNormal forState:UIControlStateNormal];
    
    // for keyboard hide-show
    self.loginToButtomDistanceFromStoryBoard = self.loginToButtomDistance.constant;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                  initWithTarget:self
                                  action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    //NSString *savedUsername = [defaults objectForKey:@"username"];
    //NSString *savedPassword = [defaults objectForKey:@"password"];
    //self.usernameTextField.text = savedUsername;
    //self.passwordTextField.text = savedPassword;
}


- (void)dismissKeyboard {
    [self.view endEditing:YES];
}
- (IBAction)rememberMeCheckBoxToggle:(UIButton *)sender {
    //sender.titleLabel.text = [sender.titleLabel.text isEqualToString:@"✓"] ? @"" : @"✓";
    self.rememberMeCheckBox.selected = !self.rememberMeCheckBox.selected;
    self.rememberMeButton.selected = !self.rememberMeButton.selected;
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    self.loginToButtomDistance.constant = keyboardHeight+2;
    [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];

    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    self.loginToButtomDistance.constant = self.loginToButtomDistanceFromStoryBoard;
    [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        [self.view layoutIfNeeded];
    }];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (IBAction)login {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    if (self.remeberPassword.on) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:username forKey:@"username"];
        [defaults setObject:password forKey:@"password"];
        
        [defaults synchronize];
    }
}

@end
