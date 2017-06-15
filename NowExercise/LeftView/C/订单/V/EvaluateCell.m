//
//  EvaluateCell.m
//  NowExercise
//
//  Created by Suger on 17/6/1.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "EvaluateCell.h"

@interface EvaluateCell()<UITextViewDelegate>

@end

@implementation EvaluateCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
//        self.backgroundView = [[UIImageView alloc]init];
        
        self.textView = [[UITextView alloc]init];
        self.textView.backgroundColor = COLOR(198, 187, 175);
        self.textView.textColor = COLOR(111, 108, 106);
        self.textView.text = @"请留下您宝贵的建议...";
        self.textView.font = [UIFont systemFontOfSize:HEIGHT_6(15)];
        self.textView.delegate = self;
        [self addSubview:self.textView];
        
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(10);
            make.right.bottom.offset(-10);
        }];
    }
    return self;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (self.textView && [self.delegate respondsToSelector:@selector(Advise:)]) {
        [self.delegate Advise:textView.text];
    }
}
- (void)textViewDidChange:(UITextView *)textView{
    if (self.textView && [self.delegate respondsToSelector:@selector(Advise:)]) {
        [self.delegate Advise:textView.text];
    }

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textView resignFirstResponder];
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
