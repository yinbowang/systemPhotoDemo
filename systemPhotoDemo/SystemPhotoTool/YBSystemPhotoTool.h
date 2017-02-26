//
//  YBSystemPhotoTool.h
//  sway
//
//  Created by wyb on 2017/2/16.
//  Copyright © 2017年 zhongtianyiguan. All rights reserved.
//

//此工具支持iOS8.0及以上
#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

//相册的model
@interface YBPhotoAblumModel : NSObject

@property (nonatomic, copy) NSString *title; //相册名字
@property (nonatomic, assign) NSInteger count; //该相册内相片数量
@property (nonatomic, strong) PHAsset *headImageAsset; //相册第一张图片缩略图
@property (nonatomic, strong) PHAssetCollection *assetCollection; //相册集，通过该属性获取该相册集下所有照片

@end

/*---------------------------------------分割线-------------------------------------------*/

@interface YBSystemPhotoTool : NSObject

+ (instancetype)sharePhotoTool;

/**
 * @brief 获取用户所有相册列表
 */
- (NSArray<YBPhotoAblumModel *> *)getPhotoAblumList;


/**
 * @brief 获取相册内所有图片资源
 * @param ascending 是否按创建时间正序排列 YES,创建时间正（升）序排列; NO,创建时间倒（降）序排列
 */
- (NSArray<PHAsset *> *)getAllAssetInPhotoAblumWithAscending:(BOOL)ascending;


/**
 * @brief 获取指定相册内的所有图片
 */
- (NSArray<PHAsset *> *)getAssetsInAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending;


/**
 * @brief 获取每个Asset对应的图片
 */
- (void)requestImageForAsset:(PHAsset *)asset size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void (^)(UIImage *image))completion;


/**
 删除系统相册中的照片，单个或者多个

 @param assets 要删除的照片数组
 @param completionHandler 成功的回调
 */
- (void)deleteSystemPhothWithPhotos:(NSArray<PHAsset *>*)assets successHandler:(dispatch_block_t)completionHandler;

#pragma mark - 判断软件是否有相册访问权限
+ (BOOL)judgeIsHavePhotoAblumAuthority;

#pragma mark - 判断软件是否有相机访问权限
+ (BOOL)judgeIsHaveCameraAuthority;

@end
