//
//  UITableView+FSExtention.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/26.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "UITableView+FSExtention.h"

@implementation UITableView (FSExtention)

- (void)fs_registerCell:(Class)cls {
    [self fs_registerCell:cls forCellReuseIdentifier:NSStringFromClass(cls)];
}

- (void)fs_registerCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIdentifier {
    [self registerClass:cls forCellReuseIdentifier:reuseIdentifier];
}

- (void)fs_registerNibCell:(Class)cls {
    [self fs_registerNibCell:cls forCellReuseIdentifier:NSStringFromClass(cls)];
}

- (void)fs_registerNibCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIdentifier {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(cls) bundle:nil] forCellReuseIdentifier:reuseIdentifier];
}


@end
