//
//  SWTextView.h
//  textView
//
//  Created by imac on 15/6/23.
//  Copyright (c) 2015年 imac. All rights reserved.
//

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

@property (assign,nonatomic) CGFloat fontSize;

@property (readonly,nonatomic) NSString* text;

@property (nonatomic, assign) NSInteger sizeNumber;

@property (nonatomic, strong) UIColor *sizeColor;

@property(nonatomic, assign) UIEdgeInsets textEdgeInset;

@end
