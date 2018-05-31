//
//  FontAndColorMacros.h
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/20.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#ifndef FontAndColorMacros_h
#define FontAndColorMacros_h


#define FSWhiteColor                                [UIColor whiteColor]
#define FSBlackColor                                [UIColor blackColor]
#define FSGrayColor                                 [UIColor grayColor]
#define FSBlueColor                                 [UIColor blueColor]
#define FSRedColor                                  [UICOlor redColor]


#define FSColorWithRGB(r, g, b)                              [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define FSColorWithRGBA(r, g, b, a)                              [UIColor colorWithRed:r green:g blue:b alpha:a]

//随机色生成
#define FSRandomColor                               [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]

//主体颜色
//导航栏颜色
#define FSNavBarBgColor                             [UIColor colorWithHexString:@"00AE68"]
#define FSNavBarFontColor                           [UIColor colorWithHexString:@"ffffff"]
//默认页面背景色
#define FSViewBgColor                               [UIColor colorWithHexString:@"f2f2f2"]
//分割线颜色
#define FSLineColor                                 [UIColor colorWithHexString:@"ededed"]
//背景颜色
#define FSBackgroundColor                           [UIColor colorWithHexString:@"#EFEFF4"]

//字体颜色
#define FSFontColor                                 [UIColor colorWithHexString:@"1f1f1f"]

//字体
#define FSBoldSystemFont(fontSize)                  [UIFont boldSystemFontOfSize:fontSize]
#define FSSystemFont(fontSize)                      [UIFont systemFontOfSize:fontSize]
#define FSFont(fontName, fontSize)                  [UIFont fontWithName:fontName size:fontSize]

#define FSMainFont                                  FSSystemFont(12.0f)





#endif /* FontAndColorMacros_h */
