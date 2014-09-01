//
//  PMTableMenuViewController.h
//  UIPopoverMenuController - 表格
//
//  Created by WeeverLu on 14-1-24.
//  Copyright (c) 2014年 Kinth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMTableMenuViewController : UITableViewController

@property (nonatomic, strong) NSArray *objets;
@property (nonatomic, copy) void(^tableMenuSelectedBlock)(NSInteger index);

@end
