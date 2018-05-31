//
//  FSCollectionViewController.h
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/24.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSBaseViewController.h"

typedef NS_ENUM(NSUInteger, FSScrollDirection) {
    ScrollUp,
    ScrollDown
};


@interface FSCollectionViewController : FSBaseViewController

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) FSScrollDirection scrollDirection;

@end
