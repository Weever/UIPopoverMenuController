//
//  PMViewController.h
//  UIPopoverMenuController - 测试
//
//  Created by WeeverLu on 14-1-24.
//  Copyright (c) 2014年 Kinth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *resultLbl;
@property (strong, nonatomic) IBOutlet UITextField *tableField;
@property (strong, nonatomic) IBOutlet UITextField *dateField;

- (IBAction)iPadTableBarButtonAction:(UIBarButtonItem *)sender;
- (IBAction)iPadDateBarButtonAction:(UIBarButtonItem *)sender;
- (IBAction)iPadTableButtonPressAction:(UIButton *)sender;
- (IBAction)iPadDateButtonPressAction:(UIButton *)sender;

- (IBAction)iPhoneTableBarButtonAction:(UIBarButtonItem *)sender;
- (IBAction)iPhoneDateBarButtonAction:(UIBarButtonItem *)sender;
- (IBAction)iPhoneTableButtonPressAction:(UIButton *)sender;
- (IBAction)iPhoneDateButtonPressAction:(UIButton *)sender;

@end
