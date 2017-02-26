//
//  PhotoBrowseViewController.m
//  sway
//
//  Created by wyb on 2017/2/15.
//  Copyright © 2017年 zhongtianyiguan. All rights reserved.
//

#import "PhotoBrowseViewController.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoBigViewController.h"
#import "Masonry.h"
#import "YBSystemPhotoTool.h"

#define KScreenHeight [UIScreen mainScreen].bounds.size.height

#define KScreenWidth [UIScreen mainScreen].bounds.size.width

#define loadNib(nibName) [UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]]



#define WS(weakSelf) __weak typeof(self) weakSelf = self;


@interface PhotoBrowseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate,PHPhotoLibraryChangeObserver>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UIImage *image;



@end

static CGFloat itemSpacing = 1;
static NSString *cellID = @"PhotoCollectionViewCellID";

@implementation PhotoBrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    //注册实施监听相册变化
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
    
    self.dataArray = [NSMutableArray array];
    
    
    [self loadUI];
    
    [self loadData];
    
}

#pragma mark- PHPhotoLibraryChangeObserver
- (void)photoLibraryDidChange:(PHChange *)changeInstance{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadData];
    });
}



- (void)loadUI{
    
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    NSInteger itemWidth = (KScreenWidth-itemSpacing*3)/4.0;
    flowlayout.itemSize = CGSizeMake(itemWidth,itemWidth);
    flowlayout.minimumLineSpacing = itemSpacing;
    flowlayout.minimumInteritemSpacing = 1;
    //上左下右
//    flowlayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowlayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.collectionView registerNib:loadNib(@"PhotoCollectionViewCell") forCellWithReuseIdentifier:cellID];
    
    
    
}

- (void)loadData{
    
    
    if (![YBSystemPhotoTool judgeIsHavePhotoAblumAuthority]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"此应用程序没有权限访问您的照片" message:@"在“设置-隐私-图片“中开启”" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
        
    }
    
    //相册列表
    NSArray *photoList = [[YBSystemPhotoTool sharePhotoTool] getPhotoAblumList];
    for (YBPhotoAblumModel *model in photoList) {
        if ([model.title isEqualToString:@"相机胶卷"]) {
            //相册集，通过该属性获取该相册集下所有照片
            PHAssetCollection *assetCollection = model.assetCollection;
            //获取某个相册的所有照片
           NSArray *assetArray = [[YBSystemPhotoTool sharePhotoTool] getAssetsInAssetCollection:assetCollection ascending:YES];
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:assetArray];
            
            [self.collectionView reloadData];
        }
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.selectBtn.hidden = YES;
    PHAsset *asset = self.dataArray[indexPath.item];
    CGSize size = cell.frame.size;
    size.width *= 4;
    size.height *= 4;
    [[YBSystemPhotoTool sharePhotoTool] requestImageForAsset:asset size:size resizeMode:PHImageRequestOptionsResizeModeExact completion:^(UIImage *image) {
        cell.image = image;
        
    }];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
        
        
        PhotoBigViewController *vc = [[PhotoBigViewController alloc]init];
        PHAsset *asset = self.dataArray[indexPath.item];
        vc.asset = asset;
        [[YBSystemPhotoTool sharePhotoTool] requestImageForAsset:asset size:PHImageManagerMaximumSize resizeMode:PHImageRequestOptionsResizeModeExact completion:^(UIImage *image) {
            
            vc.image = image;
            
        }];
        
        [self presentViewController:vc animated:YES completion:nil];
    
    

    
    
}


@end
