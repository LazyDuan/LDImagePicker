## LDImagePicker

>本项目是使用系统的UIImagePicker和自定制裁剪框VPImageCropperViewController来实现从手机相册取出图片或拍摄图片然后自定义尺寸剪切获取的图片。

###使用方法：
	LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
	imagePicker.delegate = self;
	[imagePicker showImagePickerWithType:buttonIndex InViewController:self Scale:0.75];

	- (void)imagePickerDidCancel:(LDImagePicker *)imagePicker{
    
	}
	- (void)imagePicker:(LDImagePicker *)imagePicker 	didFinished:(UIImage *)editedImage{
    self.imgeView.image = editedImage;
	}
    
     如果喜欢，请帮忙点颗星星✨
