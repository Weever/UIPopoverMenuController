//
//  UIPopoverMenuViewController.m
//  UIPopoverMenuController - iPhone、iPad选择菜单、时间
//
//  Created by WeeverLu on 14-1-24.
//  Copyright (c) 2014年 Kinth. All rights reserved.
//

#import "UIPopoverMenuViewController.h"
#import "PMHeader.h"
#import "PMTableMenuViewController.h"
#import "PMDateViewController.h"
#import "PMPickerViewController.h"

@interface UIPopoverMenuViewController ()
{
    UIPopoverController *popver;    // iPad当前PopoverController
    
    UIBarButtonItem *currentItem;   // 当前导航的BarButtonItem
    id itemTarget;                  // 当前导航BarButtonItem的事件
}

@property (nonatomic, strong) UIViewController *currentViewController;

@end

@implementation UIPopoverMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 4iPad
#pragma mark 在iPad上显示下拉选择控件
- (void)showPopoverTableMenu4iPad:(NSArray *)objects sender:(id)sender inView:(UIView *)inView
{
    [self hidePopover];
    
    PMTableMenuViewController *tableMenuViewController = [[PMTableMenuViewController alloc] initWithStyle:UITableViewStylePlain];
    tableMenuViewController.objets = objects;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tableMenuViewController];
    
    // 事件传递给当前Block
    __weak UIPopoverMenuViewController *weakSelf = self;
    tableMenuViewController.tableMenuSelectedBlock = ^(NSInteger index) {
        if (weakSelf.menuSelectedBlock) {
            weakSelf.menuSelectedBlock(index);
            //NSLog(@"index %d %@", index, objects[index]);
            
            [self hidePopover];
        }
    };
    
    popver = [[UIPopoverController alloc] initWithContentViewController:nav];
    popver.delegate = (id<UIPopoverControllerDelegate>)self;
    int popverHeight = (objects.count<5) ? (objects.count*kTabelViewCellHeight) : (kTabelViewCellHeight*5);
    popver.popoverContentSize = CGSizeMake(200, popverHeight+44);
    
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        // 处理UIBarButtonItem重复点击情况，先保存点击的UIBarButtonItem和对应的事件，然后取消对应事件
        UIBarButtonItem *item = (UIBarButtonItem*)sender;
        itemTarget = item.target;
        currentItem = item;
        item.target = nil;
        [popver presentPopoverFromBarButtonItem:item permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    else {
        UIView *view = sender;
        CGRect popverRect = [inView convertRect:view.frame fromView:view.superview];
        [popver presentPopoverFromRect:popverRect inView:inView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}

#pragma mark 在iPad上显示时间控件
- (void)showPopoverDate4iPad:(id)sender inView:(UIView *)inView
{
    [self showPopoverDate4iPad:sender inView:inView dateFormatter:nil];
}

- (void)showPopoverDate4iPad:(id)sender inView:(UIView *)inView dateFormatter:(NSString *)dateFormatter
{
    [self showPopoverDate4iPad:sender inView:inView dateFormatter:dateFormatter datePickerMode:(UIDatePickerModeDate)];
}

- (void)showPopoverDate4iPad:(id)sender inView:(UIView *)inView datePickerMode:(UIDatePickerMode)datePickerMode
{
    [self showPopoverDate4iPad:sender inView:inView dateFormatter:nil datePickerMode:datePickerMode];
}

- (void)showPopoverDate4iPad:(id)sender inView:(UIView *)inView dateFormatter:(NSString *)dateFormatter datePickerMode:(UIDatePickerMode)datePickerMode
{
    [self hidePopover];
    
    PMDateViewController *dateViewController = [[PMDateViewController alloc] initWithNibName:nil bundle:nil];
    dateViewController.dateFormatter = dateFormatter;
    dateViewController.datePickerMode = datePickerMode;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateViewController];
    
    // 事件传递给当前Block
    __weak UIPopoverMenuViewController *weakSelf = self;
    dateViewController.dateSelectedBlock = ^(NSString *dateString, BOOL isDone) {
        if (weakSelf.dateSelectedBlock && isDone) {
            weakSelf.dateSelectedBlock(dateString);
        }
        [self hidePopover];
    };
    
    popver = [[UIPopoverController alloc] initWithContentViewController:nav];
    popver.delegate = (id<UIPopoverControllerDelegate>)self;
    popver.popoverContentSize = dateViewController.view.frame.size;
    
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        // 处理UIBarButtonItem重复点击情况，先保存点击的UIBarButtonItem和对应的事件，然后取消对应事件
        UIBarButtonItem *item = (UIBarButtonItem*)sender;
        itemTarget = item.target;
        currentItem = item;
        item.target = nil;
        [popver presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    else {
        UIView *view = sender;
        CGRect popverRect = [inView convertRect:view.frame fromView:view.superview];
        [popver presentPopoverFromRect:popverRect inView:inView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}

#pragma mark UIPopoverControllerDelegate
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    // UIPopoverController隐藏的时候，重新对当前的UIBarButtonItem赋值事件
    currentItem.target = itemTarget;
}

// 隐藏控件
- (void)hidePopover
{
    if (popver && [popver isPopoverVisible]) {
        currentItem.target = itemTarget;
        [popver dismissPopoverAnimated:NO];
        popver = nil;
    }
}

#pragma mark - 4iPhone
#pragma mark 在iPhone上显示滚轮控件
- (void)showPickerMenu4iPhone:(NSArray *)objects inView:(UIView *)inView
{
    [self showPickerMenu4iPhone:objects showTitle:nil inView:inView];
}

- (void)showPickerMenu4iPhone:(NSArray *)objects showTitle:(NSString *)showTitle inView:(UIView *)inView
{
    [self showPickerMenu4iPhone:objects selectedRow:-1 showTitle:showTitle inView:inView];
}

- (void)showPickerMenu4iPhone:(NSArray *)objects selectedRow:(NSInteger)selectedRow showTitle:(NSString *)showTitle inView:(UIView *)inView
{
    UIView *hideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    hideView.alpha = 0;
    hideView.backgroundColor = [UIColor colorWithWhite:.5 alpha:.6];
    // 加点击手势
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapRecognizer:)];
    [hideView addGestureRecognizer:tapRecognizer];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:hideView];
    
    PMPickerViewController *pickerViewController = [[PMPickerViewController alloc] initWithNibName:nil bundle:nil];
    pickerViewController.objects = objects;
    pickerViewController.currentRow = selectedRow;
    pickerViewController.showTitle = showTitle;
    pickerViewController.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    CGRect dateViewFrame = pickerViewController.view.frame;
    dateViewFrame.origin.y = window.frame.size.height;
    pickerViewController.view.frame = dateViewFrame;
    [window addSubview:pickerViewController.view];
    self.currentViewController = pickerViewController;
    
    // 动画弹出
    [UIView animateWithDuration:0.3 animations:^{
        hideView.alpha = 1;
        CGRect dateViewFrame = pickerViewController.view.frame;
        dateViewFrame.origin.y = window.frame.size.height - dateViewFrame.size.height;
        pickerViewController.view.frame = dateViewFrame;
    }];
    
    // 事件传递给当前Block
    __weak UIPopoverMenuViewController *weakSelf = self;
    pickerViewController.pickerSelectedBlock = ^(NSInteger index, BOOL isDone) {
        if (weakSelf.pickerSelectedBlock && isDone) {
            weakSelf.pickerSelectedBlock(index);
        }
        // 隐藏控件
        [weakSelf removeHideView:hideView];
    };
}

#pragma mark 在iPhone上显示时间控件
- (void)showPopoverDate4iPhoneInView:(UIView *)inView;
{
    [self showPopoverDate4iPhoneInView:inView dateFormatter:nil];
}

- (void)showPopoverDate4iPhoneInView:(UIView *)inView dateFormatter:(NSString *)dateFormatter
{
    [self showPopoverDate4iPhoneInView:inView dateFormatter:dateFormatter datePickerMode:UIDatePickerModeDate];
}

- (void)showPopoverDate4iPhoneInView:(UIView *)inView datePickerMode:(UIDatePickerMode)datePickerMode
{
    [self showPopoverDate4iPhoneInView:inView dateFormatter:nil datePickerMode:datePickerMode];
}

- (void)showPopoverDate4iPhoneInView:(UIView *)inView dateFormatter:(NSString *)dateFormatter datePickerMode:(UIDatePickerMode)datePickerMode
{
    UIView *hideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    hideView.alpha = 0;
    hideView.backgroundColor = [UIColor colorWithWhite:.5 alpha:.6];
    // 加点击手势
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapRecognizer:)];
    [hideView addGestureRecognizer:tapRecognizer];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:hideView];
    
    PMDateViewController *dateViewController = [[PMDateViewController alloc] initWithNibName:nil bundle:nil];
    dateViewController.dateFormatter = dateFormatter;
    dateViewController.datePickerMode = datePickerMode;
    dateViewController.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    CGRect dateViewFrame = dateViewController.view.frame;
    dateViewFrame.origin.y = window.frame.size.height;
    dateViewController.view.frame = dateViewFrame;
    [window addSubview:dateViewController.view];
    self.currentViewController = dateViewController;
    
    // 动画弹出
    [UIView animateWithDuration:0.3 animations:^{
        hideView.alpha = 1;
        CGRect dateViewFrame = dateViewController.view.frame;
        dateViewFrame.origin.y = window.frame.size.height - dateViewFrame.size.height;
        dateViewController.view.frame = dateViewFrame;
    }];
    
    // 事件传递给当前Block
    __weak UIPopoverMenuViewController *weakSelf = self;
    dateViewController.dateSelectedBlock = ^(NSString *dateString, BOOL isDone) {
        if (weakSelf.dateSelectedBlock && isDone) {
            weakSelf.dateSelectedBlock(dateString);
        }
        // 隐藏控件
        [weakSelf removeHideView:hideView];
    };
}

#pragma mark - 手势处理
- (void)handleTapRecognizer:(UITapGestureRecognizer *)tapRecognizer
{
    UIView *view = tapRecognizer.view;
    [self removeHideView:view];
}

- (void)removeHideView:(UIView *)hideView
{
    __block UIView *view = hideView;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [UIView animateWithDuration:0.3 animations:^{
        hideView.alpha = 0;
        self.currentViewController.view.transform = CGAffineTransformMakeTranslation(0.0f, window.frame.size.height);
    } completion:^(BOOL finished) {
        [self.currentViewController.view removeFromSuperview];
        self.currentViewController = nil;
        [view removeFromSuperview];
        view = nil;
    }];
}

@end
