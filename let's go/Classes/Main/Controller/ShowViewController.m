//
//  ViewController.m
//  let's go
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ShowViewController.h"
#import "Masonry.h"
#import "HeaderSeting.h"
#import "LogRegistController.h"

@interface ShowViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pagCtrl;
@property (nonatomic, copy) NSArray *imageNames;
@property (nonatomic) NSInteger currentpage;

@end

@implementation ShowViewController

- (NSArray *)imageNames
{
    if (!_imageNames) {
        int count = 3;
        NSMutableArray *arrMimage = [NSMutableArray arrayWithCapacity:count];
        for (int index = 0; index < count; index ++) {
            NSString *str = [NSString stringWithFormat:@"new_feature_%d.jpg",index + 1];
            [arrMimage addObject:str];
        }
        _imageNames = [arrMimage copy];
    }
    return _imageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    //通过控制器的属性,隐藏navibar
    self.navigationController.navigationBarHidden = YES;

}

/**加载默认设置和UI*/
- (void)loadDefaultSetting
{
#pragma UIScrollView
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    scrollView.frame = self.view.bounds;
    self.scrollView = scrollView;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    CGFloat imageWidth = self.scrollView.frame.size.width;
    CGFloat imageHeight = self.scrollView.frame.size.height;
    NSUInteger count = self.imageNames.count;
    for (NSUInteger index = 0; index < count; index ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(index * imageWidth, 0, imageWidth, imageHeight);
        [imageView setImage:[UIImage imageNamed:self.imageNames[index]]];
        [scrollView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        if (index == count - 1) {
            [self loadEnjoyButton:imageView];
        }
    }
     //设置ScrollView的ContentSize
    scrollView.contentSize = CGSizeMake(count * imageWidth, 1);
    
#pragma UIPageControl
    UIPageControl *pageCtr = [[UIPageControl alloc] init];
    [pageCtr setNumberOfPages:3];
    [pageCtr setPageIndicatorTintColor:[UIColor whiteColor]];
    [pageCtr setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
    [self.view addSubview:pageCtr];
    self.pagCtrl = pageCtr;
    [pageCtr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@100);
        make.trailing.mas_equalTo(-100);
        make.bottom.equalTo(self.view).offset(-30);
        make.height.equalTo(@20);
    }];
    [pageCtr addTarget:self action:@selector(valuechanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pagCtrl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

- (void)valuechanged:(UIPageControl *)pageCtr
{
    NSInteger current = pageCtr.currentPage;
    CGPoint offset = CGPointMake(current * self.scrollView.frame.size.width, 0);
    [self.scrollView setContentOffset:offset];
}

- (void)loadEnjoyButton:(UIImageView *)imageView
{
    UIButton *btnEnjoy = [UIButton new];
    [btnEnjoy setTitle:@"点击进入" forState:UIControlStateNormal];
    [btnEnjoy setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btnEnjoy.titleLabel.font = [UIFont italicSystemFontOfSize:20];
    [self.scrollView addSubview:btnEnjoy];
//    CGFloat width = 150;
//    CGFloat X = (QLScreenWidth - width) * 0.5 +CGRectGetMinX(imageView.frame);
//    CGFloat Y = QLScreenHeight - 100;
//    btnEnjoy.frame = CGRectMake(X, Y, width, 40);
    [btnEnjoy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-100);
        make.centerX.mas_equalTo(imageView);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
    }];
    [btnEnjoy.layer setCornerRadius:5.0];
    [btnEnjoy.layer setBorderColor:[UIColor orangeColor].CGColor];
    [btnEnjoy.layer setBorderWidth:1.0];
    [btnEnjoy.layer setMasksToBounds:YES];
    [btnEnjoy addTarget:self action:@selector(chooseRegister) forControlEvents:UIControlEventTouchUpInside];
}

- (void)chooseRegister
{
    LogRegistController *registerVc = [LogRegistController new];
    [self.navigationController pushViewController:registerVc animated:YES];
}

//- (void)dealloc
//{
//    NSLog(@"dealloc");
//}

@end
