//
//  QYCommentCell.m
//  青云微博
//
//  Created by qingyun on 16/7/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "CommentCell.h"
#import "CommentModel.h"
//#import "QYUserModel.h"
#import "UIImageView+WebCache.h"
#import "TextfildController.h"

@interface CommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imvHead;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (nonatomic, strong) TextfildController *textFild;

@end

@implementation CommentCell

/** 返回循环利用的cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *strId = @"CommentCell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:strId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:nil options:nil] firstObject];
        cell.textLabel.numberOfLines = 0;
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imvHead.layer.cornerRadius = 25.0;
    self.imvHead.layer.masksToBounds = YES;
}

- (void)setComment:(CommentModel *)comment {
    _comment = comment;
    //接收发表的评论的值
    __weak typeof(self) weakSelf = self;
    [_textFild setBlockComment:^(NSString *text) {
        weakSelf.lblContent.text = text;
    }];
    
//    self.lblName.text = comment.user.strName;
//    self.lblContent.text = comment.strText;
//    self.lblTime.text = comment.strTimeDes;
//    [self.imvHead sd_setImageWithURL:[NSURL URLWithString:comment.user.strProfileImageUrl] placeholderImage:[UIImage imageNamed:@"social-user"]];
}

- (void)setFrame:(CGRect)frame {
    
    frame.origin.y += CommentHeaderSpace;
    
    [super setFrame:frame];
}

@end
