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
@property (weak, nonatomic) IBOutlet SWTextView *textView;

@end

@implementation SWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textView.headmark = @"备注：";
    _textView.placeholder = @"123123";
    _textView.sizeNumber = 10;
    
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
