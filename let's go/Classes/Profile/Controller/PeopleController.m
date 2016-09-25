//
//  PeopleController.m
//  let's go
//
//  Created by qingyun on 16/8/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "PeopleController.h"

@interface PeopleController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnPassword;
@property (weak, nonatomic) IBOutlet UILabel *lblSex;
@property (weak, nonatomic) IBOutlet UIButton *btnSex;
@property (weak, nonatomic) IBOutlet UIButton *btnName;

@end

@implementation PeopleController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
}





@end
