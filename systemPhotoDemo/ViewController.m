//
//  ViewController.m
//  systemPhotoDemo
//
//  Created by wyb on 2017/2/26.
//  Copyright © 2017年 中天易观. All rights reserved.
//

#import "ViewController.h"
#import "PhotoBrowseViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (IBAction)btnAction:(id)sender {
    
    PhotoBrowseViewController *vc = [[PhotoBrowseViewController alloc]init];
    
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:vc];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
