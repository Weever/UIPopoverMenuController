//
//  UIPopoverMenuViewController.h
//  UIPopoverMenuController - iPhone、iPad选择菜单、时间
//
//  Created by WeeverLu on 14-1-24.
//  Copyright (c) 2014年 Kinth. All rights reserved.
//

// 项目为非ARC使用ARC代码提示
#if !__has_feature(objc_arc)
#error This code is ARC only. Either turn on ARC for the project or use -fobjc-arc flag(这份代码只为ARC使用，请在项目中开启ARC或者加入-fobjc-arc标识)
#error Important note if your project doesn't use ARC: you must add the -fobjc-arc compiler flag to (UIPopoverMenuViewController.m, PMDateViewController.m, PMPickerViewController.m) in Target Settings > Build Phases > Compile Sources.(重要提示：如果你的项目没有使用ARC，你必须在Target Settings > Build Phases > Compile Sources中为以下文件(UIPopoverMenuViewController.m, PMDateViewController.m, PMPickerViewController.m)加入-fobjc-arc标识)
#endif

#import <UIKit/UIKit.h>

typedef void(^MenuSelectedBlock)(NSInteger index);
typedef void(^DateSelectedBlock)(NSString *dateString);
typedef void(^PickerSelectedBlock)(NSInteger index);

@interface UIPopoverMenuViewController : UIViewController

@property (nonatomic, copy) MenuSelectedBlock menuSelectedBlock;        // 列表选择block
@property (nonatomic, copy) DateSelectedBlock dateSelectedBlock;        // 时间选择block
@property (nonatomic, copy) PickerSelectedBlock pickerSelectedBlock;    // picker列表选择block

#pragma mark - 4iPad
#pragma mark 在iPad上显示下拉选择控件
/**
 *  在iPad上显示下拉选择列表
 *
 *  @param objects 传入数组
 *  @param sender  显示目标控件(UIBarButtonItem或UIButton等)
 *  @param inView  要显示的界面
 */
- (void)showPopoverTableMenu4iPad:(NSArray *)objects sender:(id)sender inView:(UIView *)inView;

#pragma mark 在iPad上显示时间控件
/**
 *  在iPad上显示时间选择框
 *
 *  @param sender 显示目标控件(UIBarButtonItem或UIButton等)
 *  @param inView 要显示的界面
 */
- (void)showPopoverDate4iPad:(id)sender inView:(UIView *)inView;
/**
 *  在iPad上显示时间选择框
 *
 *  @param sender         显示目标控件(UIBarButtonItem或UIButton等)
 *  @param inView         要显示的界面
 *  @param dateFormatter  返回日期格式(默认YYYY-MM-DD)
 */
- (void)showPopoverDate4iPad:(id)sender inView:(UIView *)inView dateFormatter:(NSString *)dateFormatter;
/**
 *  在iPad上显示时间选择框
 *
 *  @param sender         显示目标控件(UIBarButtonItem或UIButton等)
 *  @param inView         要显示的界面
 *  @param datePickerMode UIDatePicker模式
 */
- (void)showPopoverDate4iPad:(id)sender inView:(UIView *)inView datePickerMode:(UIDatePickerMode)datePickerMode;
/**
 *  在iPad上显示时间选择框
 *
 *  @param sender         显示目标控件(UIBarButtonItem或UIButton等)
 *  @param inView         要显示的界面
 *  @param dateFormatter  返回日期格式(默认YYYY-MM-DD)
 *  @param datePickerMode UIDatePicker模式
 */
- (void)showPopoverDate4iPad:(id)sender inView:(UIView *)inView dateFormatter:(NSString *)dateFormatter datePickerMode:(UIDatePickerMode)datePickerMode;

#pragma mark - 4iPhone
#pragma mark 在iPhone上显示滚轮控件
/**
 *  在iPhone上显示列表选择框
 *
 *  @param objects 传入数组
 *  @param inView  要显示的界面
 */
- (void)showPickerMenu4iPhone:(NSArray *)objects inView:(UIView *)inView;
/**
 *  在iPhone上显示列表选择框
 *
 *  @param objects   传入数组
 *  @param showTitle 显示标题
 *  @param inView    要显示的界面
 */
- (void)showPickerMenu4iPhone:(NSArray *)objects showTitle:(NSString *)showTitle inView:(UIView *)inView;
/**
 *  在iPhone上显示列表选择框
 *
 *  @param objects     传入数组
 *  @param selectedRow 默认显示哪一行
 *  @param showTitle   显示标题
 *  @param inView      要显示的界面
 */
- (void)showPickerMenu4iPhone:(NSArray *)objects selectedRow:(NSInteger)selectedRow showTitle:(NSString *)showTitle inView:(UIView *)inView;

#pragma mark 在iPhone上显示时间控件
/**
 *  在iPhone上显示时间选择框
 *
 *  @param inView 要显示的界面
 */
- (void)showPopoverDate4iPhoneInView:(UIView *)inView;
/**
 *  在iPhone上显示时间选择框
 *
 *  @param inView        要显示的界面
 *  @param dateFormatter 返回日期格式(默认YYYY-MM-DD)
 */
- (void)showPopoverDate4iPhoneInView:(UIView *)inView dateFormatter:(NSString *)dateFormatter;
/**
 *  在iPhone上显示时间选择框
 *
 *  @param inView         要显示的界面
 *  @param datePickerMode UIDatePicker模式
 */
- (void)showPopoverDate4iPhoneInView:(UIView *)inView datePickerMode:(UIDatePickerMode)datePickerMode;
/**
 *  在iPhone上显示时间选择框
 *
 *  @param inView         要显示的界面
 *  @param dateFormatter  返回日期格式(默认YYYY-MM-DD)
 *  @param datePickerMode UIDatePicker模式
 */
- (void)showPopoverDate4iPhoneInView:(UIView *)inView dateFormatter:(NSString *)dateFormatter datePickerMode:(UIDatePickerMode)datePickerMode;

@end
