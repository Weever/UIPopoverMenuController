//
//  PMDateViewController.m
//  UIPopoverMenuController - UIDatePicker选择
//
//  Created by WeeverLu on 14-1-24.
//  Copyright (c) 2014年 Kinth. All rights reserved.
//

#import "PMDateViewController.h"
#import "PMHeader.h"

@interface PMDateViewController ()

@end

@implementation PMDateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 设置控件属性
    // ...
    
    self.title = @"请选择时间";

    // 设置UIDatePicker模式
    if (self.datePickerMode) {
        self.datePicker.datePickerMode = self.datePickerMode;
    }
    self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_cn"];
    // iPad为导航状态
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // 左边取消按钮
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStyleBordered) target:self action:@selector(cancleAction:)];
        leftItem.tintColor = [UIColor blackColor];
        self.navigationItem.leftBarButtonItem = leftItem;
        
        // 右边确定按钮
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:(UIBarButtonItemStyleDone) target:self action:@selector(doneAction:)];
        rightItem.tintColor = [UIColor blackColor];
        self.navigationItem.rightBarButtonItem = rightItem;
        
        // 增加self.view高度，修改pickerFrame.origin.y
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+44);
        CGRect pickerFrame = self.datePicker.frame;
        pickerFrame.size.height += 44;
        self.datePicker.frame = pickerFrame;
    }
    else {
        // 左边取消按钮
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStyleBordered) target:self action:@selector(cancleAction:)];
        // 右边确定按钮
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:(UIBarButtonItemStyleDone) target:self action:@selector(doneAction:)];
        
        // 中间提示
        //UIBarButtonItem *tipsItem = [[UIBarButtonItem alloc] initWithTitle:@"请选择时间" style:(UIBarButtonItemStylePlain) target:self action:nil];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"请选择时间";
        label.textColor = (kOVER_iOS7)?[UIColor blackColor]:[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:17];
        UIBarButtonItem *tipsItem = [[UIBarButtonItem alloc] initWithCustomView:label];
        
        // 间距
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];
        
        // toolbar
        NSArray *toolItems = @[ leftItem, space, tipsItem, space, rightItem ];
        UIToolbar *tool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        tool.tintColor = [UIColor blackColor];
        tool.items = toolItems;
        self.toolbar = tool;
        [self.view addSubview:tool];
        
        // 增加self.view高度，修改pickerFrame.origin.y
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+44);
        CGRect pickerFrame = self.datePicker.frame;
        pickerFrame.origin.y = 44;
        self.datePicker.frame = pickerFrame;
    }
}

- (IBAction)cancleAction:(UIBarButtonItem *)sender
{
    if (self.dateSelectedBlock) {
        self.dateSelectedBlock(nil, NO);
    }
}

- (IBAction)doneAction:(UIBarButtonItem *)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置日期显示格式
    if (self.dateFormatter) {
        formatter.dateFormat = self.dateFormatter;
    }
    else {
        formatter.dateFormat = kDEFAULT_DATEFORMAT;
    }
    
    // 当前时间转为字符串
    NSString *dateString = [formatter stringFromDate:self.datePicker.date];
    
    if (self.dateSelectedBlock) {
        self.dateSelectedBlock(dateString, YES);
    }
}

@end
