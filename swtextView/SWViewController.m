//
//  SWViewController.m
//  swtextView
//
//  Created by sunwei on 16/7/4.
//  Copyright © 2016年 sunwei. All rights reserved.
//

#import "SWViewController.h"
#import "SWRemarkView.h"
@interface SWViewController ()
@property (weak, nonatomic) IBOutlet SWRemarkView *textView;
@property (nonatomic, strong) SWRemarkView *textView2;
@end

@implementation SWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textView.headmark = @"备注：";
    _textView.placeholder = @"123123";
    _textView.sizeNumber = 10;
    
    _textView2 = [[SWRemarkView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _textView2.headmark = @"备注：";
    _textView2.placeholder = @"123123";
    _textView2.attributedText = [[NSAttributedString alloc] initWithString:@"备注：撒打算打算的" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    _textView2.sizeNumber = 10;
    [self.view addSubview:_textView2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
