//
//  FSLiveModel.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/28.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSLiveModel.h"

@implementation FSLiveModel

- (void)setStarlevel:(NSUInteger)starlevel {
    _starlevel = starlevel;
    self.girlStar = [NSString stringWithFormat:@"girl_star%zd_40x19",_starlevel];
    
}

- (void)setAllnum:(NSUInteger)allnum {
    _allnum = allnum;
    
    NSMutableAttributedString *allNumAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d人在看",_allnum]];
//    allNumAttr.yy_font = FSSystemFont(17);
//    allNumAttr.yy_color = [UIColor colorWithHexString:@"999999"];
//    allNumAttr.yy_alignment = NSTextAlignmentRight;
//    [allNumAttr yy_setColor:MHColorFromHexString(@"#F14F94") range:NSMakeRange(0, liveRoom.allnum.length)];
    self.allNumAttr = allNumAttr.copy;
    
}


@end
