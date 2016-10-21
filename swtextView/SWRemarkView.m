//
//  SWTextView.m
//  textView
//
//  Created by imac on 15/6/23.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SWRemarkView.h"
#define FontSize 15
@interface SWRemarkView ()<UITextViewDelegate>
{
    CGFloat placeholderX;
    CGFloat placeholderY;
    CGFloat placeholderW;
}

@property (nonatomic, strong) UILabel *sizeLab;

@property(nonatomic, strong) UITextView* textView;
//placeholder view
@property(nonatomic, strong) UILabel* placeholderLabel;

@end


@implementation SWRemarkView

-(void)setPlaceholder:(NSString *)placeholder
{
    self.placeholderLabel.text = placeholder;
}

-(void)setHeadmark:(NSString *)headmark
{
    _headmark = headmark;
    self.textView.text = _headmark;
}

-(void)setFontSize:(CGFloat )fontSize
{
    _fontSize = fontSize;
    self.textView.font = [UIFont systemFontOfSize:_fontSize];
    self.placeholderLabel.font = [UIFont systemFontOfSize:_fontSize];
    
}

- (void)setSizeNumber:(NSInteger)sizeNumber {
    _sizeNumber = sizeNumber;
    if (sizeNumber>0) {
        self.sizeLab.text = [NSString stringWithFormat:@"0/%ld",sizeNumber];
    }
}

- (void)setSizeColor:(UIColor *)sizeColor {
    self.sizeLab.textColor = sizeColor;
}

- (void)setTextEdgeInset:(UIEdgeInsets)textEdgeInset {
    self.textView.textContainerInset = textEdgeInset;
}

- (void)setTitle:(NSString *)title {
    self.textView.text = title;
    if (title.length) {
        self.placeholderLabel.hidden = YES;
    }
}

-(NSString *)text
{
    if ([[self.textView.text substringFromIndex:_headmark.length]isEqualToString:_placeholder]) {
        return @"";
    }
    return [self.textView.text substringFromIndex:_headmark.length];
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self loadView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadView];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadView];
    }
    return self;
}


-(void)loadView
{
    if ([self.backgroundColor isEqual:[UIColor clearColor]]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    _fontSize = FontSize;
    [self addSubview:self.textView];
    [self addSubview:self.placeholderLabel];
    [self addSubview:self.sizeLab];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.textView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self changePlaceholderFrame];
}


- (void)changePlaceholderFrame
{
    CGFloat width = _headmark.length?[self sizeWithString:_headmark].width+5:4;
    placeholderX = self.textView.textContainerInset.left+width;
    placeholderY = self.textView.textContainerInset.top;
    placeholderW = self.frame.size.width - placeholderX - self.textView.textContainerInset.right;
    CGRect frame = CGRectMake(placeholderX, placeholderY, placeholderW, 20);
    self.placeholderLabel.frame = frame;
    
    self.sizeLab.frame = CGRectMake(self.textView.textContainerInset.left, self.frame.size.height-20-self.textView.textContainerInset.top, self.frame.size.width-self.textView.textContainerInset.left-self.textView.textContainerInset.right, 20);
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location == _headmark.length) {
        if (textView.text.length - _headmark.length + text.length == text.length?0:1) {
            self.placeholderLabel.hidden = NO;
        }else{
            self.placeholderLabel.hidden = YES;
        }
    }
    
    if([self disable_emoji:text].length>0||text.length == 0)
    {
        if (range.location >= _headmark.length) {
            if (textView.text.length - _headmark.length + text.length > _sizeNumber && _sizeNumber) {
                return NO;
            }
        }else if (range.location+1 - _headmark.length == 0) {
            return NO;
        }
        if (text.length) {
            self.sizeLab.text = [NSString stringWithFormat:@"%lu/%ld",textView.text.length - _headmark.length + text.length,(long)_sizeNumber];
        }else {
            self.sizeLab.text = [NSString stringWithFormat:@"%lu/%ld",textView.text.length - _headmark.length - range.length,(long)_sizeNumber];
        }
        
        return YES;
        
    }else{
        return NO;
    }
}

#pragma mark - 放大镜选择
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (textView.selectedRange.location<_headmark.length) {
            NSRange range;
            range.location = _headmark.length;
            range.length  = textView.text.length - _headmark.length;
            textView.selectedRange = range;
        }
    });
}
#pragma mark - getter
- (UILabel *)sizeLab {
    if (!_sizeLab) {
        _sizeLab = [[UILabel alloc] init];
        _sizeLab.textColor = [UIColor redColor];
        _sizeLab.font = [UIFont systemFontOfSize:_fontSize-2];
        _sizeLab.textAlignment = NSTextAlignmentRight;
    }
    return _sizeLab;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textColor = [UIColor blackColor];
        _textView.font = [UIFont systemFontOfSize:_fontSize];
        _textView.delegate = self;
    }
    return _textView;
}

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.textColor = [UIColor blackColor];
        _placeholderLabel.textAlignment = NSTextAlignmentLeft;
        _placeholderLabel.font = [UIFont systemFontOfSize:_fontSize];
        _placeholderLabel.enabled = NO;
        _placeholderLabel.userInteractionEnabled = NO;
    }
    return _placeholderLabel;
}

#pragma mark textViewDelegate 禁止输入表情
//判断表情符号
- (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

-(CGSize)sizeWithString:(NSString *)string
{
    if (string.length == 0) {
        return CGSizeMake(0, MAXFLOAT);
    }
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:_fontSize]};
    return [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
