//
//  PhotoBigViewController.h
//  sway
//
//  Created by wyb on 2017/2/15.
//  Copyright © 2017年 zhongtianyiguan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>


@interface PhotoBigViewController : UIViewController

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)PHAsset *asset;

@end
