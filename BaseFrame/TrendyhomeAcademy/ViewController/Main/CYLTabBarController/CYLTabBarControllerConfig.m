//
//  CYLTabBarControllerConfig.m
//  CYLTabBarController
//
//  v1.10.0 Created by 微博@iOS程序犭袁 ( http://weibo.com/luohanchenyilong/ ) on 10/20/15.
//  Copyright © 2015 https://github.com/ChenYilong . All rights reserved.
//
#import "CYLTabBarControllerConfig.h"
#import "FSLiveViewModel.h"


#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_X (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0f)



static CGFloat const CYLTabBarControllerHeight = 40.f;


@implementation CYLBaseNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        UINavigationBar *navBar = [UINavigationBar appearance];
        UIImage *navBarImage = [UIImage imageWithColor:[UIColor redColor]];
        [navBar setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
        [navBar setShadowImage:[UIImage new]];//去掉阴影线
        [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17]}];
        
    }
    return self;
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        if (!IS_IPHONE_X) {
            viewController.hidesBottomBarWhenPushed = YES;
        }
        if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"" forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"barbuttonicon_back_15x30"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"barbuttonicon_back_15x30"] forState:UIControlStateHighlighted];
            CGRect frame = CGRectMake(0, 0, 21, 39);
            button.frame = frame;
            // 让按钮内部的所有内容左对齐
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            //        [button sizeToFit];
            // 让按钮的内容往左边偏移10
//            button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
            viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
            // 隐藏tabbar
            viewController.hidesBottomBarWhenPushed = YES;
        }
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
        [vc navigationShouldPopOnBackButton];
    }
    [self popViewControllerAnimated:YES];
}

@end

//View Controllers
#import "FSHomeViewController.h"
#import "MyViewController.h"
#import "FSLiveViewController.h"

@interface CYLTabBarControllerConfig ()

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation CYLTabBarControllerConfig

/**
 *  lazy load tabBarController
 *
 *  @return CYLTabBarController
 */
- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                                   tabBarItemsAttributes:self.tabBarItemsAttributesForController];
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    
    FSHomeViewController *homeViewController = [[FSHomeViewController alloc] init];
    UIViewController *homeNavigationController = [[CYLBaseNavigationController alloc]
                                                   initWithRootViewController:homeViewController];
    
    FSLiveViewController *liveViewController = [[FSLiveViewController alloc] init];
    UIViewController *liveNavigationController = [[CYLBaseNavigationController alloc]
                                                initWithRootViewController:liveViewController];
   
    MyViewController *myViewController = [[MyViewController alloc] init];
    UIViewController *myNavigationController = [[CYLBaseNavigationController alloc]
                                                    initWithRootViewController:myViewController];
    
    /**
     * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
     * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
     * 更推荐后一种做法。
     */
//    self.tabBarController.imageInsets = UIEdgeInsetsMake(4.5, 0, -4.5, 0);
//    self.tabBarController.titlePositionAdjustment = UIOffsetMake(0, MAXFLOAT);
    NSArray *viewControllers = @[
                                 homeNavigationController,
                                 liveNavigationController,
                                 myNavigationController
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
//                                                 CYLTabBarItemImage : @"home_n",  /* NSString and UIImage are supported*/
//                                                 CYLTabBarItemSelectedImage : @"home_p", /* NSString and UIImage are supported*/
                                                 };
    
    NSDictionary *secondTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"直播",
//                                                 CYLTabBarItemImage : @"study_n",  /* NSString and UIImage are supported*/
//                                                 CYLTabBarItemSelectedImage : @"study_p", /* NSString and UIImage are supported*/
                                                 };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"我的",
                                                  //                                                 CYLTabBarItemImage : @"study_n",  /* NSString and UIImage are supported*/
                                                  //                                                 CYLTabBarItemSelectedImage : @"study_p", /* NSString and UIImage are supported*/
                                                  };
    
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
//#warning CUSTOMIZE YOUR TABBAR APPEARANCE
    // Customize UITabBar height
    // 自定义 TabBar 高度
     tabBarController.tabBarHeight = FSTabBarHeight;
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:168.0/255.0 green:168.0/255.0 blue:168.0/255.0 alpha:1];//RGBA(168, 168, 168, 1);
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    // [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
//    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
//    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
//    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tab_shadow"]];
    
    // set the bar background image
    // 设置背景图片
    // UITabBar *tabBarAppearance = [UITabBar appearance];
    // [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
    
    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    // [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    CGFloat tabBarHeight = CYLTabBarControllerHeight;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor yellowColor]
                             size:selectionIndicatorImageSize]];
}
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
