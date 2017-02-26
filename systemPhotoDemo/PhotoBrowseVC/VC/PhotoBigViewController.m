//
//  PhotoBigViewController.m
//  sway
//
//  Created by wyb on 2017/2/15.
//  Copyright © 2017年 zhongtianyiguan. All rights reserved.
//

#import "PhotoBigViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>


@interface PhotoBigViewController ()

@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation PhotoBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.userInteractionEnabled = YES;
    //不让图片变形
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.frame = self.view.bounds;
    [self.view addSubview:imageview];
    self.imageView = imageview;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [imageview addGestureRecognizer:tap];
    
    
}



- (void)setImage:(UIImage *)image{
    
    _image = image;
    self.imageView.image = image;
}



- (void)tapAction{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
