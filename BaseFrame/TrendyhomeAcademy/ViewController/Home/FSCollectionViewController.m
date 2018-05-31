//
//  FSCollectionViewController.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/24.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSCollectionViewController.h"
#import "FSMovieModel.h"
#import "FSHomeCollectionViewCell.h"
#import "FSWebViewController.h"

@interface FSCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation FSCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self.view addSubview:self.collectionView];

   
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemW = (FSScreenWidth - 20) / 2;
        CGFloat itemH = (250.0 / 188.0) * itemW;
        flowLayout.itemSize = CGSizeMake(itemW, itemH);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 10, FSScreenWidth - 10, self.view.frame.size.height - 44 - FSTopHeight - FSTabBarHeight - 10) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"FSHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FSHomeCollectionViewCell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    
    return _collectionView;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FSHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FSHomeCollectionViewCell" forIndexPath:indexPath];

    FSMovieModel *model = self.dataSource[indexPath.item];
    cell.model = model;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FSMovieModel *model = self.dataSource[indexPath.item];
    FSWebViewController *detailVc = [[FSWebViewController alloc] initWithUrl:model.iconlinkUrl];
    [self.parentViewController.parentViewController.navigationController pushViewController:detailVc animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
