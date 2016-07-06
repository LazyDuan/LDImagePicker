//
//  LDActionSheet.h
//  LDActionSheetDemo
//
//  Created by 段乾磊 on 16/6/29.
//  Copyright © 2016年 LazyDuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDActionSheet;
@protocol LDActionSheetDelegate <NSObject>
@required
/**
 *  点击按钮
 */
- (void)actionSheet:(LDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
@optional
//取消按钮
- (void)actionSheetCancel:(LDActionSheet *)actionSheet;
@end
@interface LDActionSheet : UIView

/**
 *  type block
 *
 *  @param title                  title            (可以为空)
 *  @param delegate               delegate
 *  @param cancelButtonTitle      "取消"按钮         (默认有)
 *  @param destructiveButtonTitle "警示性"(红字)按钮  (可以为空)
 *  @param otherButtonTitles      otherButtonTitles
 */
- (instancetype)initWithTitle:(NSString *)title
                     delegate:(id<LDActionSheetDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@property(nonatomic,weak) id<LDActionSheetDelegate> delegate;
@property(nonatomic,copy) NSString *title;

- (void)showInView:(UIView *)view;
@end
