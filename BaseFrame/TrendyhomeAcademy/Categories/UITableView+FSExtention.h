//
//  UITableView+FSExtention.h
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/26.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (FSExtention)

- (void)fs_registerCell:(Class)cls;

- (void)fs_registerCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIdentifier;

- (void)fs_registerNibCell:(Class)cls;

- (void)fs_registerNibCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIdentifier;



@end
