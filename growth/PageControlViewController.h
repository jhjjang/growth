//
//  PageControlViewController.h
//  growth
//
//  Created by jungho jang on 12. 2. 1..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PageControlViewController : UIViewController<UIScrollViewDelegate,UIWebViewDelegate>
{
    NSDictionary *info;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSDictionary *info;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;
- (IBAction)close:(id)sender;
@end
