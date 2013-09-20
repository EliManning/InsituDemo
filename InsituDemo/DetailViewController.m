//
//  DetailViewController.m
//  InsituDemo
//
//  Created by smart_parking on 9/20/13.
//  Copyright (c) 2013 codes. All rights reserved.
//

#import "DetailViewController.h"
@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize webView = _webView;
@synthesize wiki_url = _wiki_url;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _webView.delegate = self;
    NSLog(@"url %@",_wiki_url);
    NSURL *url = [NSURL URLWithString:_wiki_url];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestURL];
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading webview...";
    NSLog(@"start loading");

}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //web view finishes loading
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"finish loading");
}

-(void)setWiki_url:(NSString *)url{
    _wiki_url = [NSString stringWithFormat:@"http://%@",url];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
