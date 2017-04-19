//
//  UILabel+Suger.m
//  NowExercise
//
//  Created by mac on 17/4/6.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "UILabel+Suger.h"

@implementation UILabel (Suger)

- (instancetype)initWithtitle:(NSString *)title{
    if (self = [super init]) {
        self.font = [UIFont systemFontOfSize:HEIGHT_6(14)];
        if ([title containsString:@"("]) {
            NSMutableAttributedString * str = [[NSMutableAttributedString alloc]initWithString:title];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:HEIGHT_6(12)] range:NSMakeRange([title rangeOfString:@"("].location , title.length - [title rangeOfString:@"("].location)];
            self.attributedText = str;
        }else{
            //没有
            self.text = title;

        }
        self.backgroundColor = THEMECOLOR;
        self.textColor = MAKA_JIN_COLOR;
        self.numberOfLines = 10;
    }
    return self;
}
- (instancetype)initDatalabel{
    if (self = [super init]) {
        self.textColor = [UIColor grayColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.numberOfLines = 0;
        self.text = @"0cm";
    }
    return self;
}
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

@end
