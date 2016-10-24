//
//  SWTextView.h
//  textView
//
//  Created by imac on 15/6/23.
//  Copyright (c) 2015年 imac. All rights reserved.
//
/**
 *  注意 有导航栏的VC 可能textView会有显示下移的情况，可设置VC的self.edgesForExtendedLayout = UIRectEdgeNone;来修改
 */

#import <UIKit/UIKit.h>

@interface SWRemarkView : UIView

/*提示语句
 *
 *用70%的灰表示 placeholder
 *
 */
@property (nonatomic, copy) NSString *placeholder;

/*第一行的标示语句
 *
 *如：备注等
 *
 */
@property (nonatomic) NSString* headmark;
/**
 *  textView初始值（取值请使用下面text）
 */
@property (nonatomic, strong) NSString *title;
/**
 *  文字大小
 */
@property (assign,nonatomic) CGFloat fontSize;
/**
 *  读取输入框类容
 */
@property (readonly,nonatomic) NSString* text;
/**
 *  设置限制字数
 */
@property (nonatomic, assign) NSInteger sizeNumber;
/**
 *  设置限制数颜色
 */
@property (nonatomic, strong) UIColor *sizeColor;
/**
 *  设置textView的范围
 */
@property (nonatomic, assign) UIEdgeInsets textEdgeInset;
/**
 *  设置是否能够编辑
 */
@property (nonatomic, assign) BOOL editable;
/**
 *  设置textView的attributedText
 */
@property (nonatomic, strong) NSAttributedString *attributedText;

@end
