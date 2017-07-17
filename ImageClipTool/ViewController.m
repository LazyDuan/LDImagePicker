//
//  ViewController.m
//  ImageClipTool
//
//  Created by 段乾磊 on 16/7/6.
//  Copyright © 2016年 LazyDuan. All rights reserved.
//

#import "ViewController.h"
#import "LDActionSheet.h"
#import "LDImagePicker.h"
@interface ViewController ()<LDActionSheetDelegate,LDImagePickerDelegate>
@property (nonatomic, strong) LDActionSheet *originSheet;
@property (nonatomic, strong) LDActionSheet *customSheet;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@property (weak, nonatomic) IBOutlet UIImageView *imgeView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)originUpload_Click:(id)sender {
    self.originSheet = [[LDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄",@"相册", nil];
    [self.originSheet showInView:self.view];
}
- (IBAction)upload_Click:(id)sender {
    self.customSheet = [[LDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄",@"相册", nil];
    [self.customSheet showInView:self.view];
}
- (void)actionSheet:(LDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([actionSheet isEqual:self.customSheet]) {
        LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
        imagePicker.delegate = self;
        [imagePicker showImagePickerWithType:buttonIndex InViewController:self Scale:0.75];
        self.height.constant = 200*0.75;
    }else{
        LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
        imagePicker.delegate = self;
        [imagePicker showOriginalImagePickerWithType:buttonIndex InViewController:self];
    }
    
}
- (void)imagePickerDidCancel:(LDImagePicker *)imagePicker{
    
}
- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage{
    self.height.constant = editedImage.size.height/editedImage.size.width*200;
    self.imgeView.image = editedImage;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
