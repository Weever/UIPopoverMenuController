//
//  PMPickerViewController.m
//  UIPopoverMenuController - UIPickerView滚轮
//
//  Created by WeeverLu on 14-1-26.
//  Copyright (c) 2014年 Kinth. All rights reserved.
//

#import "PMPickerViewController.h"
#import "PMHeader.h"

@interface PMPickerViewController ()
{
    NSInteger selectRow;    // 当前选择的行
    BOOL isLoading;         // 是否在滚动中
}

@end

@implementation PMPickerViewController

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
    
    // [0 - self.objects.count] 范围内滚动到某一行
    if (self.currentRow >= 0 && self.currentRow < self.objects.count) {
        selectRow = self.currentRow;
        [self.pickerView selectRow:selectRow inComponent:0 animated:YES];
        isLoading = NO;
    }
    
    // 左边取消按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStyleBordered) target:self action:@selector(cancleAction:)];
    leftItem.tintColor = [UIColor blackColor];
    // 右边确定按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:(UIBarButtonItemStyleDone) target:self action:@selector(doneAction:)];
    rightItem.tintColor = [UIColor blackColor];
    
    // 中间提示-标题
    //UIBarButtonItem *tipsItem = [[UIBarButtonItem alloc] initWithTitle:@"请选择时间" style:(UIBarButtonItemStylePlain) target:self action:nil];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.text = self.showTitle?self.showTitle:@"请选择";
    label.numberOfLines = 2;
    label.textColor = (kOVER_iOS7)?[UIColor blackColor]:[UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:17];
    UIBarButtonItem *tipsItem = [[UIBarButtonItem alloc] initWithCustomView:label];
    
    // 间距
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];
    
    // toolbar
    NSArray *toolItems = @[ leftItem, space, tipsItem, space, rightItem ];
    self.toolbar.tintColor = [UIColor blackColor];
    self.toolbar.items = toolItems;
}


#pragma mark - UIPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.objects.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // isLoading = YES; // 测试失败，无法判断是否滚动中
    id title = self.objects[row];
    if ([title isKindOfClass:[NSString class]]) {
        return self.objects[row];
    }
    return @"必须是字符串数据！";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectRow = row;
    isLoading = NO;
}

#pragma mark - Action
- (IBAction)cancleAction:(UIBarButtonItem *)sender
{
    if (self.pickerSelectedBlock) {
        self.pickerSelectedBlock(-1, NO);
    }
}

- (IBAction)doneAction:(UIBarButtonItem *)sender
{
    // 当前不在滚动时，可以操作下一步
    if (!isLoading) {
        if (self.pickerSelectedBlock) {
            self.pickerSelectedBlock(selectRow, YES);
        }
    }
}

@end
