//
//  FSHomeViewController.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/21.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSHomeViewController.h"
#import "FSBannerView.h"
#import "FSCollectionViewController.h"
#import "FSWebViewController.h"
#import "UIScrollView+FSRefresh.h"
#import "FSHomeModel.h"

@interface MyScrollView: UIScrollView

@end

@implementation MyScrollView

// 这个方法是支持多手势，当滑动子控制器中的scrollView时，TableView也能接收滑动事件
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

@end

@interface FSHomeViewController()<UIScrollViewDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) FSTabPageViewController *tabPageController;

@property (nonatomic, strong) FSBannerView *bannerView;

@property (nonatomic, strong) UISearchController *searchController;

@end


@implementation FSHomeViewController

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[MyScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (FSTabPageViewController *)tabPageController {
    if (!_tabPageController) {
        _tabPageController = [[FSTabPageViewController alloc] init];
    }
    return _tabPageController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    
    FSWeakSelf(self)
    RACSignal *currentSubScrollOffset = self.tabPageController.contentScrollSignal;
    [[currentSubScrollOffset filter:^BOOL(id  _Nullable value) {
        return [value isKindOfClass:UIScrollView.class];
    }] subscribeNext:^(UIScrollView  *subScrollView ) {
        FSStrongSelf(self)
        CGFloat offsetY = MAX(0, self.scrollView.contentOffset.y + subScrollView.contentOffset.y);
        if ((offsetY < self.bannerView.frame.size.height)) {
            subScrollView.contentOffset = CGPointZero;
            
        }else {
            self.scrollView.contentOffset = CGPointMake(0, self.bannerView.frame.size.height);
        }
    }] ;
    
    [Observe_RAC observe:self.bannerView.homeVM key:@"rac_resObj" block:^(id responseOject) {
        if (responseOject) {
            NSArray *data = (NSArray *)responseOject;
            if (data.count > 0) {
                [self initViewControllersWithData:data];
                
            }
        }
       
    }];

}



- (void)setupSubViews {
    self.title = @"热映";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    FSWeakSelf(self)
    [self.scrollView fs_addHeaderRefresh:^(MJRefreshNormalHeader *header) {
        [weakself.bannerView.homeVM requestHomeData:^(id responseObject) {
            [weakself.scrollView.mj_header endRefreshing];
        } failure:^(NSError *error) {
            [weakself.scrollView.mj_header endRefreshing];
        }];
    }];

    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, FSScreenWidth, 44)];//self.searchController.searchBar;
    searchBar.barStyle = UIBarStyleDefault;
    searchBar.translucent = YES;
    searchBar.barTintColor = FSColorWithRGB(248, 248, 248);
    searchBar.tintColor = FSColorWithRGB(0, 190, 12);
    searchBar.layer.borderColor = [UIColor redColor].CGColor;
    searchBar.showsBookmarkButton = YES;
    [searchBar setImage:[UIImage imageNamed:@"mb_search_head_24x24"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
    CGRect rect = searchBar.frame;
    rect.size.height = 44;
    searchBar.frame = rect;
    [self.scrollView addSubview:searchBar];
    
    [self.scrollView addSubview: self.bannerView];
    [self addChildViewController:self.tabPageController];
    [self.tabPageController didMoveToParentViewController:self];
    [self.scrollView addSubview:self.tabPageController.view];
    [self.tabPageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerX.bottom.equalTo(self.scrollView);
        make.top.mas_equalTo(self.bannerView.mas_bottom);
        make.height.equalTo(self.scrollView.mas_height);
    }];
    
    
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

- (void)viewDidLayoutSubviews {
    
    if (@available(iOS 11.0, *) && self.view.safeAreaInsets.bottom > 0) {
        self.scrollView.frame = self.view.safeAreaLayoutGuide.layoutFrame;
    }else {
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}

- (void)initViewControllersWithData:(NSArray *)data {
    NSMutableArray *vcArray = [NSMutableArray arrayWithCapacity:2];
    
    for (int i = 0; i < data.count; i++) {

        FSHomeModel *model = data [i];
        FSCollectionViewController *vc = [[FSCollectionViewController alloc] init];
        vc.yp_tabItemTitle = model.name;
        vc.dataSource = model.data;
        [vcArray addObject:vc];
    }
    self.tabPageController.viewControllers = vcArray;

}


- (FSBannerView *)bannerView {
    FSWeakSelf(self)
    if (!_bannerView) {
        _bannerView = [[FSBannerView alloc] initWithFrame:CGRectMake(0, 44, FSScreenWidth, Height9To16)];
        _bannerView.homeVM.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(FSMovieModel *model) {
            [weakself pushToMovieDetailViewWithURL:model.iconlinkUrl];
            return [RACSignal empty];
        }];
    }
   
    return _bannerView;
}

- (void)pushToMovieDetailViewWithURL:(NSString *)url {
    FSWebViewController *detailVc = [[FSWebViewController alloc] initWithUrl:url];
    [self.navigationController pushViewController:detailVc animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offsetY = MAX(0, self.scrollView.contentOffset.y);
    if (offsetY > self.bannerView.frame.size.height) {
        self.scrollView.contentOffset = CGPointMake(0, 44+self.bannerView.frame.size.height);
        
    }
}



@end
