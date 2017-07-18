//
//  LDImagePicker.m
//  ImageClipTool
//
//  Created by 段乾磊 on 16/7/6.
//  Copyright © 2016年 LazyDuan. All rights reserved.
//

#import "LDImagePicker.h"
#import "VPImageCropperViewController.h"
#define ScreenWidth  CGRectGetWidth([UIScreen mainScreen].bounds)
#define ScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
@interface LDImagePicker()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,VPImageCropperDelegate>{
    BOOL isScale;
    double _scale;
}
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) VPImageCropperViewController *imageCropperController;
@end
@implementation LDImagePicker
#pragma  mark -- 单例 --
+ (instancetype)sharedInstance{
    static dispatch_once_t ETToken;
    static LDImagePicker *sharedInstance = nil;
    dispatch_once(&ETToken, ^{
        sharedInstance = [[LDImagePicker alloc] init];
        
    });
    return sharedInstance;
}
- (void)showOriginalImagePickerWithType:(ImagePickerType)type InViewController:(UIViewController *)viewController{
    if (type == ImagePickerCamera) {
        self.imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    }else{
        self.imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    }
    isScale = NO;
    self.imagePickerController.allowsEditing = YES;
    [viewController presentViewController:_imagePickerController animated:YES completion:nil];
}
- (void)showImagePickerWithType:(ImagePickerType)type InViewController:(UIViewController *)viewController Scale:(double)scale{
    if (type == ImagePickerCamera) {
        self.imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    }else{
        self.imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    }
    self.imagePickerController.allowsEditing = NO;
    isScale = YES;
    if(scale>0 &&scale<=1.5){
      _scale = scale;
    }else{
        _scale = 1;
    }
    
    [viewController presentViewController:_imagePickerController animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageOrientation imageOrientation=image.imageOrientation;
    if(imageOrientation!=UIImageOrientationUp)
    {
        // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
        // 以下为调整图片角度的部分
        UIGraphicsBeginImageContext(image.size);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // 调整图片角度完毕
    }
    if (isScale) {
        self.imageCropperController = [[VPImageCropperViewController alloc] initWithImage:image cropFrame:CGRectMake(0, (ScreenHeight-ScreenWidth*_scale)/2, ScreenWidth, ScreenWidth*_scale) limitScaleRatio:5];
        self.imageCropperController.delegate = self;
        [picker pushViewController:self.imageCropperController animated:YES];
    }else{
        [picker dismissViewControllerAnimated:YES completion:^{}];
        [self.delegate imagePicker:self didFinished:image];
    }
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    if (self.delegate) {
        [self.delegate imagePickerDidCancel:self];
    }
}
#pragma mark - VPImageCropperDelegate
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController{
    UIImagePickerController *picker = (UIImagePickerController *)cropperViewController.navigationController;
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        [cropperViewController.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else{
        [cropperViewController.navigationController popViewControllerAnimated:YES];
    }
}
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage{
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
    if (self.delegate) {
        [self.delegate imagePicker:self didFinished:editedImage];
    }
}
#pragma mark - Getters
- (UIImagePickerController *)imagePickerController{
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = NO;
    }
    return _imagePickerController;
}
@end
