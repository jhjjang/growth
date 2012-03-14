//
//  WeightViewController.m
//  growth
//
//  Created by jungho jang on 12. 2. 1..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import "WeightViewController.h"
#import "graphData.h"

@interface WeightViewController ()

@end

@implementation WeightViewController
@synthesize webView;
@synthesize info;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    graphData *data = [[graphData alloc] init];
    
    NSMutableString *html = [data getGraphData:info :@"weight"];
    
    NSString *str = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:str];
    
    //[webView setBackgroundColor:[UIColor clearColor]];
    [webView setOpaque:NO];
    [webView loadHTMLString:html baseURL:baseURL];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
