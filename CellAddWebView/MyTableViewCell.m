//
//  MyTableViewCell.m
//  CellAddWebView
//
//  Created by iOSDeveloper on 2017/4/1.
//  Copyright © 2017年 iOSDeveloper. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //NSLog(@"%@",NSStringFromCGRect(self.contentView.bounds));
        
        // 高度必须提前赋一个值 >0
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 1)];
        self.webView.backgroundColor = [UIColor clearColor];
        self.webView.opaque = NO;
        self.webView.userInteractionEnabled = NO;
        self.webView.scrollView.bounces = NO;
        self.webView.delegate = self;
        //self.webView.paginationBreakingMode = UIWebPaginationBreakingModePage;
        //self.webView.scalesPageToFit = YES;
        [self.contentView addSubview:self.webView];
    }
    return self;
}

// contentStr 用于更新值
-(void)setContentStr:(NSString *)contentStr
{
    _contentStr = contentStr;
    
    [self.webView loadHTMLString:contentStr baseURL:nil];
    
    //    NSString *path = [[NSBundle mainBundle] bundlePath];
    //    NSURL *baseURL = [NSURL fileURLWithPath:path];
    //    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"index1"
    //                                                          ofType:@"html"];
    //    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
    //                                                    encoding:NSUTF8StringEncoding
    //                                                       error:nil];
    //    [self.webView loadHTMLString:htmlCont baseURL:baseURL];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //    // 如果要获取web高度必须在网页加载完成之后获取
    //
    //    // 方法一
    //     CGSize fittingSize = [self.webView sizeThatFits:CGSizeZero];
    //
    //    // 方法二
    ////    CGSize fittingSize = webView.scrollView.contentSize;
    //    NSLog(@"webView:%@",NSStringFromCGSize(fittingSize));
    //    self.height = fittingSize.height;
    //
    //    self.webView.frame = CGRectMake(0, 0, fittingSize.width, fittingSize.height);
    
    
    //方法三
    CGRect frame = self.webView.frame;
    frame.size.width = 320;
    frame.size.height = 1;
    //    wb.scrollView.scrollEnabled = NO;
    self.webView.frame = frame;
    frame.size.height = self.webView.scrollView.contentSize.height;
    //NSLog(@"frame = %@", [NSValue valueWithCGRect:frame]);
    self.webView.frame = frame;
    
    CGFloat webViewH = CGRectGetMaxY(self.webView.frame);
    NSLog(@"webViewH的高:%f",webViewH);
    self.height = webViewH;
    
    // 用通知发送加载完成后的高度
    [[NSNotificationCenter defaultCenter] postNotificationName:WEBVIEW_HEIGHT object:self userInfo:nil];
}

@end
