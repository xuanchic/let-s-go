//
//  StatusCell.m
//  let's go
//
//  Created by qingyun on 16/8/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "StatusCell.h"
#import "StatusModel.h"

@interface StatusCell ()
/** 头像按钮 */
@property (weak, nonatomic) IBOutlet UIImageView *btnHeader;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;
/** 创建时间 */
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
/** 主要内容 */
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@end

@implementation StatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *strId = @"StatusCell";
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:strId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StatusCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btnHeader.layer.cornerRadius = 25;
    self.btnHeader.layer.masksToBounds = YES;
}
- (IBAction)gitUp:(UIButton *)sender {
    
    if (self.ButtonBlock) {
        self.ButtonBlock(sender);
    }
    
}

- (void)setStatus:(StatusModel *)status
{
    _status = status;
    self.lblTitle.text = status.strTitle;
    self.lblContent.text = status.strText;
    self.lblName.text = status.strScreenName;
    self.btnHeader.image = status.imgHeader;
    self.lblTime.text = status.strTimeDes;
}

@end
