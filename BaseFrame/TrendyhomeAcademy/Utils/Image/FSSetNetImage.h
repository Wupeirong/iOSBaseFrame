//
//  FSSetNetImage.h
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/24.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PlaceholderOption) {
    DefaultUserHeader,
    DefaultPlaceholder
};

@interface FSSetNetImage : NSObject

+ (void)setNetImageWithImageView:(UIImageView *)imageView
                        imageURL:(NSString *)url
                          option:(PlaceholderOption)option;


@end
