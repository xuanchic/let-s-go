//
//  VedioViewCell.m
//  let's go
//
//  Created by qingyun on 16/9/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "VedioViewCell.h"
#import "VedioModel.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "VedioDataController.h"

@interface VedioViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *userImag;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UIImageView *simpleImage;
@property (weak, nonatomic) IBOutlet UILabel *playTime;


@end

@implementation VedioViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *strId = @"VedioViewCell";
    VedioViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"VedioViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.userImag.layer.cornerRadius = 25;
    self.userImag.layer.masksToBounds = YES;

}

- (void)setModel:(VedioModel *)model
{
    _model = model;
    NSURL *image = [NSURL URLWithString:model.profile_image];
    [self.userImag sd_setImageWithURL:image forState:UIControlStateNormal];
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.userImag.frame];
//    [imgView sd_setImageWithURL:image];
//    [self.userImag addSubview:imgView];
//    [self.userImag sd_setImageWithURL:[NSURL URLWithString:model.cdn_img] placeholderImage:[UIImage imageNamed:@"background"]];
    self.userName.text = model.name;
    self.createTime.text = model.create_time;
    self.comment.text = model.text;
    self.comment.font = [UIFont systemFontOfSize:14];
    [self.comment setNumberOfLines:0];
    [self.simpleImage sd_setImageWithURL:[NSURL URLWithString:model.cdn_img] placeholderImage:[UIImage imageNamed:@"background"]];
    self.playCount.text = [NSString stringWithFormat:@"%d",model.playcount];
    
    NSInteger minute = model.videotime.integerValue / 60;
    NSInteger second = model.videotime.integerValue % 60;
    
    if (minute) {
        NSString *strformat = minute < 10 ? @"%01zd分%02zd秒" : @"%02zd分%02zd秒";
        self.playTime.text = [NSString stringWithFormat:strformat, minute, second];
    }else {
        self.playTime.text = [NSString stringWithFormat:@"%02zd秒",second];
    }
}
- (IBAction)gitUp:(id)sender {
    if (self.ButtonBlock) {
        self.ButtonBlock(sender);
    }
}

- (IBAction)playVedioBtnClick:(UIButton *)sender
{
    VedioDataController *dataVC = [[VedioDataController alloc] init];
    
//    UIViewController *VedioDetailVC = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"VedioDetailVC"];
    
    [dataVC setValue:self.model.videouri forKey:@"urlStr"];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:dataVC animated:YES completion:nil];
    
}

@end
