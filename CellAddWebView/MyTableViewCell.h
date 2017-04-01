//
//  MyTableViewCell.h
//  CellAddWebView
//
//  Created by iOSDeveloper on 2017/4/1.
//  Copyright © 2017年 iOSDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell<UIWebViewDelegate>

@property (nonatomic,strong) NSString *contentStr;
@property (nonatomic,assign) CGFloat height;
@property (strong, nonatomic) UIWebView *webView;

@end
