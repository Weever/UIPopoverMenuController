//
//  PMViewController.m
//  UIPopoverMenuController - 测试
//
//  Created by WeeverLu on 14-1-24.
//  Copyright (c) 2014年 Kinth. All rights reserved.
//

#import "PMViewController.h"
#import "UIPopoverMenuViewController.h"

@interface PMViewController ()

@property (nonatomic, strong) UITextField *currentField;

// 必须加，iPhone使用时，当前界面保留，防止对象被释放
@property (nonatomic, strong) UIPopoverMenuViewController *popoverMenuViewController;

@end

@implementation PMViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    // 必须加
    if (self.popoverMenuViewController) {
        self.popoverMenuViewController = nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.tableField]) {
        self.currentField = self.tableField;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [self showTableMenu4iPad:textField];
        }
        else {
            [self showTableMenu4iPhone:textField];
        }
    }
    else if ([textField isEqual:self.dateField]) {
        self.currentField = self.dateField;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [self showDateView4iPad:textField];
        }
        else {
            [self showDateView4iPhone:textField];
        }
    }
    return NO;
}

#pragma mark - Action
#pragma mark iPad
- (IBAction)iPadTableBarButtonAction:(UIBarButtonItem *)sender
{
    [self showTableMenu4iPad:sender];
}
- (IBAction)iPadDateBarButtonAction:(UIBarButtonItem *)sender
{
    [self showDateView4iPad:sender];
}
- (IBAction)iPadTableButtonPressAction:(UIButton *)sender
{
    [self showTableMenu4iPad:sender];
}
- (IBAction)iPadDateButtonPressAction:(UIButton *)sender
{
    [self showDateView4iPad:sender];
}

#pragma mark iPhone
- (IBAction)iPhoneTableBarButtonAction:(UIBarButtonItem *)sender
{
    [self showTableMenu4iPhone:sender];
}
- (IBAction)iPhoneDateBarButtonAction:(UIBarButtonItem *)sender
{
    [self showDateView4iPhone:sender];
}
- (IBAction)iPhoneTableButtonPressAction:(UIButton *)sender
{
    [self showTableMenu4iPhone:sender];
}
- (IBAction)iPhoneDateButtonPressAction:(UIButton *)sender
{
    [self showDateView4iPhone:sender];
}

#pragma mark - Method
// 显示列表4iPad
- (void)showTableMenu4iPad:(id)sender
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        [array addObject:[NSString stringWithFormat:@"测试数据-%d", i]];
    }
    if (array.count == 0) {
        // 显示无数据提示
        return;
    }
    UIPopoverMenuViewController *menuViewController = [[UIPopoverMenuViewController alloc] init];
    [menuViewController showPopoverTableMenu4iPad:array sender:sender inView:self.view];
    menuViewController.menuSelectedBlock = ^(NSInteger index) {
        NSLog(@"index %d %@", index, array[index]);
        self.resultLbl.text = array[index];
        self.tableField.text = array[index];
    };
}

// 显示时间4iPad
- (void)showDateView4iPad:(id)sender
{
    UIPopoverMenuViewController *menuViewController = [[UIPopoverMenuViewController alloc] init];
    [menuViewController showPopoverDate4iPad:sender inView:self.view];
    //[menuViewController showPopoverDate4iPad:sender inView:self.view dateFormatter:@"YYYY-MM-dd hh:mm:ss"];
    //[menuViewController showPopoverDate4iPad:sender inView:self.view datePickerMode:(UIDatePickerModeDateAndTime)];
    //[menuViewController showPopoverDate4iPad:sender inView:self.view dateFormatter:@"YYYY-MM-dd hh:mm:ss" datePickerMode:UIDatePickerModeDateAndTime];
    menuViewController.dateSelectedBlock = ^(NSString *dateString) {
        NSLog(@"dateString %@", dateString);
        self.resultLbl.text = dateString;
        self.dateField.text = dateString;
    };
}

// 显示列表4iPhone
- (void)showTableMenu4iPhone:(id)sender
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 50; i++) {
        [array addObject:[NSString stringWithFormat:@"测试数据-%d", i]];
    }
    if (array.count == 0) {
        // 显示无数据提示
        return;
    }
    UIPopoverMenuViewController *menuViewController = [[UIPopoverMenuViewController alloc] init];
    // 必须加
    self.popoverMenuViewController = menuViewController;
    [menuViewController showPickerMenu4iPhone:array showTitle:@"请选择协同办公" inView:self.view];
    menuViewController.pickerSelectedBlock = ^(NSInteger index) {
        NSLog(@"index %d %@", index, array[index]);
        self.resultLbl.text = array[index];
        self.tableField.text = array[index];
    };
}

// 显示时间4iPhone
- (void)showDateView4iPhone:(id)sender
{
    UIPopoverMenuViewController *menuViewController = [[UIPopoverMenuViewController alloc] init];
    // 必须加
    self.popoverMenuViewController = menuViewController;
    [menuViewController showPopoverDate4iPhoneInView:self.view];
    //[menuViewController showPopoverDate4iPhoneInView:self.view dateFormatter:@"YYYY-MM-dd hh:mm:ss"];
    //[menuViewController showPopoverDate4iPhoneInView:self.view datePickerMode:(UIDatePickerModeDateAndTime)];
    //[menuViewController showPopoverDate4iPhoneInView:self.view dateFormatter:@"YYYY-MM-dd hh:mm:ss" datePickerMode:(UIDatePickerModeDateAndTime)];
    menuViewController.dateSelectedBlock = ^(NSString *dateString) {
        NSLog(@"dateString %@", dateString);
        self.resultLbl.text = dateString;
        self.dateField.text = dateString;
    };
}

@end
