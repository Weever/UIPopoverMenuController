//
//  PMDateViewController.h
//  UIPopoverMenuController - UIDatePicker选择
//
//  Created by WeeverLu on 14-1-24.
//  Copyright (c) 2014年 Kinth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMDateViewController : UIViewController

@property (nonatomic, strong) NSString *dateFormatter;  // 返回时间格式
@property (nonatomic) UIDatePickerMode datePickerMode;  // UIDatePicker模式

// 选择回调
@property (nonatomic, copy) void (^dateSelectedBlock)(NSString *dateString, BOOL isDone);

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;

- (IBAction)cancleAction:(UIBarButtonItem *)sender;
- (IBAction)doneAction:(UIBarButtonItem *)sender;

@end
