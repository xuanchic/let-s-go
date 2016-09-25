//
//  PhotoGraphController.h
//  let's go
//
//  Created by qingyun on 16/9/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>

@interface PhotoGraphController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImagePickerController *_imgPickerController;//拍照/照片库要要调用的对象
    UIImageView *_imgView;
}

@end
