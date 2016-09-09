//
//  PageCardCell.m
//  PageCardDemo
//
//  Created by lly on 16/9/1.
//  Copyright © 2016年 lly. All rights reserved.
//

#import "PageCardCell.h"

@interface PageCardCell()


@end

@implementation PageCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = true;

}

+ (NSString *)cellIdentifier{

    return @"PageCardCell";
}
@end
