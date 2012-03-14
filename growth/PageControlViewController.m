//
//  PageControlViewController.m
//  growth
//
//  Created by jungho jang on 12. 2. 1..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import "PageControlViewController.h"
#import "graphData.h"
#import "HeightViewController.h"
#import "WeightViewController.h"
#define kNumberOfPage 2

@interface PageControlViewController ()

@end

@implementation PageControlViewController
@synthesize scrollView;
@synthesize pageControl;
@synthesize info;
@synthesize activity;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    graphData *data = [[graphData alloc] init];
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 266, 318)];
    webView.delegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    NSMutableString *html = [data getGraphData:info :@"height"];
    
    NSString *str = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:str];
    
    [webView setOpaque:NO];
    [webView loadHTMLString:html baseURL:baseURL];
    [webView setUserInteractionEnabled:NO];
    [scrollView addSubview:webView];
    
    UIWebView *webView2 = [[UIWebView alloc] initWithFrame:CGRectMake(266, 0, 266, 318)];
    webView2.backgroundColor = [UIColor whiteColor];
    NSMutableString *html2 = [data getGraphData:info :@"weight"];
    
    //[webView setBackgroundColor:[UIColor clearColor]];
    [webView2 setOpaque:NO];
    [webView2 loadHTMLString:html2 baseURL:baseURL];
    [webView2 setUserInteractionEnabled:NO];
    [scrollView addSubview:webView2];
    
    /*
    HeightViewController *h = [[HeightViewController alloc] init];
    WeightViewController *w = [[WeightViewController alloc] init];
    
    h.info = info;
    h.view.frame = CGRectMake(0, 0, 283, 350);
    w.info = info;
    w.view.frame = CGRectMake(288, 0, 283, 350);
    [scrollView addSubview:h.view];
    [scrollView addSubview:w.view];
    */
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*kNumberOfPage, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    pageControl.numberOfPages = kNumberOfPage;
    pageControl.currentPage = 0;
    
    [pageControl addTarget:self action:@selector(pageChangeView:) forControlEvents:UIControlEventValueChanged];
    
    

     
}

- (void)viewDidUnload
{

    [self setPageControl:nil];
    [self setScrollView:nil];
    [self setActivity:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - 
-(void)pageChangeView:(id)sender
{
    UIPageControl *pControl = (UIPageControl *)sender;
    [scrollView setContentOffset:CGPointMake(pControl.currentPage*266, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth) + 1;
    pageControl.currentPage = page;
}

- (IBAction)close:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - UIWebviewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [activity setHidden:NO];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activity setHidden:YES];
}
@end
