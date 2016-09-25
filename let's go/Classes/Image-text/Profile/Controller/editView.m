//
//  editView.m
//  let's go
//
//  Created by qingyun on 16/9/10.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "editView.h"
#import "Masonry.h"

@interface editView ()
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UIButton *button;
@end

@implementation editView

+(instancetype) addItems{
    editView *view = [[editView alloc]init];
    
    return view;
}

- (instancetype)init{
    if (self = [super init]) {
        [self loadDefaultSetting];
    }
    return self;
}
/**加载默认设置和UI*/
- (void)loadDefaultSetting
{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UITextField *textField = [[UITextField alloc]init];
    [self addSubview: textField];
//    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.borderStyle = UITextBorderStyleLine;
    textField.backgroundColor = [UIColor whiteColor];
    self.textField = textField;
    UIButton *button = [[UIButton alloc]init];
    self.button = button;
    [self addSubview:button];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(self).offset(10);
        make.trailing.mas_equalTo(self).offset(-10);
        make.height.equalTo(@44);
        
    }];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.bottom.equalTo(self).offset(-10);
        make.width.equalTo(@60);
        make.height.equalTo(@40);
    }];
    [button addTarget:self action:@selector(blockValue:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

- (void)blockValue:(UIButton *)button {
    if (_editOkBlock) {
        _editOkBlock(_textField.text, _btnTag);
    }
    __weak typeof(self) editView = self;
    [UIView animateWithDuration:0.25 animations:^{
        editView.alpha = 0;
    }];
}


@end
