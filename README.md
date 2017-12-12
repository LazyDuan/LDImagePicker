## LDImagePicker

>本项目是使用系统的UIImagePickerController和自定制裁剪框VPImageCropperViewController来实现从手机相册取出图片或拍摄图片然后自定义尺寸剪切获取的图片。


### 使用方法：

    LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
	imagePicker.delegate = self;
	//设置宽高比，宽度固定位屏幕宽度
	[imagePicker showImagePickerWithType:buttonIndex InViewController:self Scale:0.75];

	- (void)imagePickerDidCancel:(LDImagePicker *)imagePicker{
    
	}
	- (void)imagePicker:(LDImagePicker *)imagePicker 	didFinished:(UIImage *)editedImage{
    self.imgeView.image = editedImage;
	}
  

### 支持使用pod管理

 ` pod 'LDImagePicker'`
  
  如果喜欢，请帮忙点颗星星✨
