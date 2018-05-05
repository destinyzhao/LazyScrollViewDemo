//
//  View4.m
//  LazyScrollViewDemo
//
//  Created by Destiny on 2018/5/5.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import "View4.h"

@implementation View4

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)sharedView
{
    View4 *view =  [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].firstObject;
    
    return view;
}


@end
