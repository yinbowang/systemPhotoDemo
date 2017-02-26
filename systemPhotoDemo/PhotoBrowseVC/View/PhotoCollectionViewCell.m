//
//  PhotoCollectionViewCell.m
//  sway
//
//  Created by wyb on 2017/2/15.
//  Copyright © 2017年 zhongtianyiguan. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "Masonry.h"

@interface PhotoCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *phothImage;



@end

@implementation PhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.phothImage.contentMode = UIViewContentModeScaleAspectFill;
    self.phothImage.clipsToBounds = YES;
    
    self.selectBtn = [[UIButton alloc]init];
    self.selectBtn.hidden = YES;
    [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"button_select_selected"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.selectBtn];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    
}

- (void)setImage:(UIImage *)image{
    _image = image;
    self.phothImage.image = image;
}

@end
