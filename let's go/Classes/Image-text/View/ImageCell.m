//
//  ImageCell.m
//  let's go
//
//  Created by qingyun on 16/8/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ImageCell.h"
#import "ImageModel.h"
#import "HeaderSeting.h"
@interface ImageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *btnHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIView *images;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcHeightView;

@end

@implementation ImageCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *strId = @"ImageCell";
    ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:strId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ImageCell" owner:nil options:nil] firstObject];
    }
    return cell;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.btnHeader.layer.cornerRadius = 25;
    self.btnHeader.layer.masksToBounds = YES;
}
- (IBAction)gitUp:(id)sender {
    if (self.ButtonBlock) {
        self.ButtonBlock(sender);
    }
}

- (void)setImageModel:(ImageModel *)imageModel
{
    _imageModel = imageModel;
    //设置头像
    self.btnHeader.image = imageModel.imageHeader;
    //设置昵称
    self.lblName.text = imageModel.userName;
    
    //设置时间
    self.lblTime.text = imageModel.strTimeDes;
    //设置标题内容
    self.lblTitle.text = imageModel.strTitle;
    //设置图片
    [self loadImages:imageModel.arrPicUrls forView:self.images];
}

- (void)loadImages:(NSArray *)arrs forView:(UIView *)view {
    // 清除之前添加的所有的ImageView
    [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger count = arrs.count;
    NSInteger lineCount= 3;
    CGFloat space = 8;
    CGFloat width = (QLScreenWidth - 4 * space) / lineCount;
    CGFloat height = width;
    NSInteger line = (count + lineCount - 1) / lineCount;
    
    CGFloat heightView = 0;
    if (line) {
        heightView = space + (space + height) * line;
    }
    if (view == self.images) {
        self.lcHeightView.constant = heightView;
    }
    
    // 如果图片的数量是0 直接返回
    if (count == 0) return;

    //设置图片
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger index = 0; index < count; index++) {
        UIImageView *imageView = [UIImageView new];
        
        imageView.image = self.imageModel.arrPicUrls[index];
        CGFloat X = space + (index % lineCount) * (width + space);
        CGFloat Y = space + (index / lineCount) * (height + space);
        imageView.frame = CGRectMake(X, Y, width, height);
        [view addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [images addObject:imageView.image];
    }
    
}

@end
