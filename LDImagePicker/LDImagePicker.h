//
//  LDImagePicker.h
//  ImageClipTool
//
//  Created by 段乾磊 on 16/7/6.
//  Copyright © 2016年 LazyDuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ImagePickerType){
    ImagePickerCamera = 0,
    ImagePickerPhoto = 1
};
@class LDImagePicker;
@protocol LDImagePickerDelegate <NSObject>

- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage;
- (void)imagePickerDidCancel:(LDImagePicker *)imagePicker;
@end
@interface LDImagePicker : NSObject
+ (instancetype) sharedInstance;
//delegate
@property (nonatomic, assign) id<LDImagePickerDelegate> delegate;
//choose original image
- (void)showOriginalImagePickerWithType:(ImagePickerType)type InViewController:(UIViewController *)viewController;
//Custom cut. Cutting box's scale(height/Width) 0~1.5 default is 1
- (void)showImagePickerWithType:(ImagePickerType)type InViewController:(UIViewController *)viewController Scale:(double)scale;
@end
