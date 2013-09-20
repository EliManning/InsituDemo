//
//  DetailViewController.h
//  InsituDemo
//
//  Created by smart_parking on 9/20/13.
//  Copyright (c) 2013 codes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface DetailViewController : UIViewController <UIWebViewDelegate>{
    UIWebView *webView;
    NSString *wiki_url;
    MBProgressHUD *hud ;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic) NSString *wiki_url;
-(void)setWiki_url:(NSString *)url;
@end
