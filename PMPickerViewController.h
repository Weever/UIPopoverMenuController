//
//  PMPickerViewController.h
//  UIPopoverMenuController - UIPickerView滚轮
//
//  Created by WeeverLu on 14-1-26.
//  Copyright (c) 2014年 Kinth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMPickerViewController : UIViewController

@property (nonatomic, strong) NSArray *objects;     // 字符串数组数据
@property (nonatomic, strong) NSString *showTitle;  // 显示标题
@property (nonatomic) NSInteger currentRow;         // 默认现在的行

// 选择回调
@property (nonatomic, copy) void (^pickerSelectedBlock)(NSInteger index, BOOL isDone);

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;

- (IBAction)cancleAction:(UIBarButtonItem *)sender;
- (IBAction)doneAction:(UIBarButtonItem *)sender;

@end
