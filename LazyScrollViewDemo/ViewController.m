//
//  ViewController.m
//  LazyScrollViewDemo
//
//  Created by Destiny on 2018/5/5.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import "ViewController.h"
#import <LazyScroll/LazyScroll.h>
#import <TMUtils/TMUtils.h>
#import "View1.h"
#import "View2.h"
#import "View3.h"
#import "View4.h"

@interface ViewController ()<TMLazyScrollViewDataSource>

@property (strong, nonatomic) NSMutableArray *rectArray;
@property (strong, nonatomic) TMLazyScrollView *scrollView;
@property (strong, nonatomic)  View1 *view1;
@property (strong, nonatomic)  View2 *view2;
@property (strong, nonatomic)  View3 *view3;
@property (strong, nonatomic)  View4 *view4;

@end

@implementation ViewController

- (NSMutableArray *)rectArray
{
    if (!_rectArray) {
        _rectArray = [NSMutableArray array];
    }
    return _rectArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupLazyScrollView];
    [self setupContentViewRect];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupLazyScrollView
{
    _scrollView = [[TMLazyScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.dataSource = self;
    _scrollView.autoAddSubview = YES;
    _scrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_scrollView];
}

- (void)setupContentViewRect
{
    CGFloat maxY = 0;
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    
    [self addRect:CGRectMake(0, maxY, viewWidth, 300) andUpdateMaxY:maxY];
    maxY += 300;
    [self addRect:CGRectMake(0, maxY, viewWidth, 500) andUpdateMaxY:maxY];
    maxY += 500;
    [self addRect:CGRectMake(0, maxY, viewWidth, 200) andUpdateMaxY:maxY];
    maxY += 200;
    [self addRect:CGRectMake(0, maxY, viewWidth, 400) andUpdateMaxY:maxY];
    maxY += 400;
    
    _scrollView.contentSize = CGSizeMake(viewWidth, maxY + 10);
    [_scrollView reloadData];
}

- (void)addRect:(CGRect)newRect andUpdateMaxY:(CGFloat)maxY
{
    if (CGRectGetMaxY(newRect) >maxY) {
        maxY = CGRectGetMaxY(newRect);
    }
    [self.rectArray addObject:[NSValue valueWithCGRect:newRect]];
}

#pragma mark - 返回View个数
- (NSUInteger)numberOfItemsInScrollView:(TMLazyScrollView *)scrollView
{
    return _rectArray.count;
}

#pragma mark - 返回RectModel
- (TMLazyItemModel *)scrollView:(TMLazyScrollView *)scrollView itemModelAtIndex:(NSUInteger)index
{
    CGRect rect = [(NSValue *)[_rectArray objectAtIndex:index] CGRectValue];
    TMLazyItemModel *rectModel = [[TMLazyItemModel alloc] init];
    rectModel.absRect = rect;
    rectModel.muiID = [NSString stringWithFormat:@"%zd", index];
    return rectModel;
}

- (UIView *)scrollView:(TMLazyScrollView *)scrollView itemByMuiID:(NSString *)muiID
{
    // Find view that is reuseable first.
    
    UIView *view = nil;
    switch (muiID.intValue) {
        case 0:
        {
            View1 *view1 = (View1 *)[scrollView dequeueReusableItemWithIdentifier:@"View1"];
            NSInteger index = [muiID integerValue];
            if (!view1) {
                view1 = [View1 sharedView];
                view1.reuseIdentifier = @"View1";
            }
            view1.frame = [(NSValue *)[_rectArray objectAtIndex:index] CGRectValue];
            self.view1 = view1;
            view = view1;
        }
            break;
        case 1:
        {
            View2 *view2 = (View2 *)[scrollView dequeueReusableItemWithIdentifier:@"View2"];
            NSInteger index = [muiID integerValue];
            if (!view2) {
                view2 = [View2 sharedView];
                view2.reuseIdentifier = @"View2";
            }
            view2.frame = [(NSValue *)[_rectArray objectAtIndex:index] CGRectValue];
            self.view2 = view2;
            view = view2;
        }
            break;
        case 2:
        {
            View3 *view3 = (View3 *)[scrollView dequeueReusableItemWithIdentifier:@"View3"];
            NSInteger index = [muiID integerValue];
            if (!view3) {
                view3 = [View3 sharedView];
                view3.reuseIdentifier = @"View3";
            }
            view3.frame = [(NSValue *)[_rectArray objectAtIndex:index] CGRectValue];
            self.view3 = view3;
            view = view3;
        }
            break;
        case 3:
        {
            View4 *view4 = (View4 *)[scrollView dequeueReusableItemWithIdentifier:@"View4"];
            NSInteger index = [muiID integerValue];
            if (!view4) {
                view4 = [View4 sharedView];
                view4.reuseIdentifier = @"View4";
            }
            view4.frame = [(NSValue *)[_rectArray objectAtIndex:index] CGRectValue];
            self.view4 = view4;
            view = view4;
        }
            break;
            
        default:
            break;
    }
    
    return view;
}

@end
