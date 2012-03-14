//
//  WeightViewController.h
//  growth
//
//  Created by jungho jang on 12. 2. 1..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeightViewController : UIViewController
{
    NSDictionary *info;
}

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSDictionary *info;
@end
