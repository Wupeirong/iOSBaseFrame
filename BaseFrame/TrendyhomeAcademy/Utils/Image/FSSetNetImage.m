//
//  FSSetNetImage.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/24.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSSetNetImage.h"

@implementation FSSetNetImage

+ (void)setNetImageWithImageView:(UIImageView *)imageView
                        imageURL:(NSString *)url
                          option:(PlaceholderOption)option {
    if (option == DefaultUserHeader) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default_head.png"]];
    }else if (option == DefaultPlaceholder) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"holderPlace.png"]];
    }
   
}

@end
