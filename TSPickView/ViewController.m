//
//  ViewController.m
//  TSPickView
//
//  Created by QinChuancheng on 2020/7/27.
//  Copyright © 2020 Galanz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *tableView2;

@property (nonatomic, strong) NSMutableArray *tempListArray;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = UIColor.whiteColor;
	


//	CAGradientLayer *gradientLayer = CAGradientLayer.layer;
//	gradientLayer.colors = @[(id)[UIColor redColor].CGColor, (id)UIColor.greenColor.CGColor];
//	gradientLayer.startPoint = CGPointMake(0, 0);
//	gradientLayer.endPoint = CGPointMake(1, 0);
//	gradientLayer.frame = CGRectMake(10, 100, 200, 44);
//	//
//	[self.view.layer addSublayer:gradientLayer];
//
//
//	UIView *bgView = [UIView.alloc initWithFrame:CGRectMake(10, 100, 200, 44)];
//	bgView.backgroundColor = UIColor.clearColor;
//	[self.view addSubview:bgView];
//
//	UILabel *text = [UILabel.alloc initWithFrame:bgView.bounds];
//	text.textColor = UIColor.blackColor;
//	text.text = @"abdfasdfasf";
//	[bgView addSubview:text];
//
//	gradientLayer.mask = bgView.layer;
//	bgView.frame = gradientLayer.bounds;
	//text.frame = bgView.bounds;
//	UILabel *text = [UILabel.alloc initWithFrame:CGRectMake(10, 100, 200, 44)];
//	text.textColor = UIColor.blackColor;
//	text.text = @"abdfasdfasf";
//	[self.view addSubview:text];
//
//	gradientLayer.mask = text.layer;
	
	//这一步很重要
	//5. 一旦把label层设置为mask层，label层就不能显示了,会直接从父层中移除
	// 父层改了，坐标系也就改了，需要重新设置label的位置，才能正确的设置裁剪区域。
//	text.frame = gradientLayer.bounds;
	
	// Do any additional setup after loading the view.
//	self.view.backgroundColor = UIColor.whiteColor;
//	self.navigationItem.title = @"test";
	self.tempListArray = NSMutableArray.alloc.init;
	for (NSInteger index = 10; index <= 260; index = index + 5) {
		[self.tempListArray addObject:@(index).stringValue];
	}
//
	UIView *bgView = [UIView.alloc initWithFrame:CGRectMake(0, 55 + 64, self.view.frame.size.width, self.view.frame.size.height - 56 - 115 - 64 - 12)];
	bgView.backgroundColor = UIColor.clearColor;
	[self.view addSubview:bgView];
	
//	UILabel *text = [UILabel.alloc initWithFrame:bgView.bounds];
//	text.textColor = UIColor.blackColor;
//	text.text = @"abdfasdfasf";
//	text.font = [UIFont systemFontOfSize:60];
//	[bgView addSubview:text];

	self.tableView = [UITableView.alloc initWithFrame:bgView.bounds style:UITableViewStyleGrouped];
	self.tableView.backgroundColor = UIColor.clearColor;
	self.tableView.delegate = self;
	self.tableView.rowHeight = 60;
	self.tableView.estimatedRowHeight = 60;
	self.tableView.dataSource = self;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	self.tableView.userInteractionEnabled = NO;
	self.tableView.decelerationRate = UIScrollViewDecelerationRateNormal;
	[self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:UITableViewCell.description];
	[bgView addSubview:self.tableView];
//
	UIView *headView = [UIView.alloc initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 72 * 3)];
	headView.backgroundColor = UIColor.clearColor;
	self.tableView.tableHeaderView = headView;

	UIView *footView = [UIView.alloc initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 72 * 3)];
	footView.backgroundColor = UIColor.clearColor;
	self.tableView.tableFooterView = footView;
	
	self.tableView2 = [UITableView.alloc initWithFrame:CGRectMake(0, 55 + 64, self.view.frame.size.width, self.view.frame.size.height - 56 - 115 - 64 - 12) style:UITableViewStyleGrouped];
	self.tableView2.backgroundColor = UIColor.clearColor;
	self.tableView2.delegate = self;
	self.tableView2.rowHeight = 60;
	self.tableView2.estimatedRowHeight = 60;
	self.tableView2.dataSource = self;
	self.tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
	self.tableView2.decelerationRate = UIScrollViewDecelerationRateNormal;
	[self.tableView2 registerClass:UITableViewCell.class forCellReuseIdentifier:UITableViewCell.description];
	[self.view addSubview:self.tableView2];
	
	UIView *headView1 = [UIView.alloc initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 72 * 3)];
	headView.backgroundColor = UIColor.clearColor;
	self.tableView2.tableHeaderView = headView1;

	UIView *footView1 = [UIView.alloc initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 72 * 3)];
	footView.backgroundColor = UIColor.clearColor;
	self.tableView2.tableFooterView = footView1;

//	CAScrollLayer *maskLayer = CAScrollLayer.layer;
//	maskLayer.backgroundColor = UIColor.redColor.CGColor;
//	maskLayer.frame = self.tableView.bounds;
//	[self.tableView.layer addSublayer:maskLayer];

//	CAShapeLayer *layer = CAShapeLayer.layer;
//	layer.frame = bgView.bounds;
//	[bgView.layer addSublayer:layer];
//	layer.path = [UIBezierPath bezierPathWithRect:bgView.bounds].CGPath;
//	layer.fillColor = UIColor.clearColor.CGColor;
//	layer.strokeColor = UIColor.redColor.CGColor;
//	layer.lineWidth = 5;

	CAGradientLayer *gradientLayer = CAGradientLayer.layer;
	gradientLayer.colors = @[(id)[UIColor redColor].CGColor, (id)UIColor.greenColor.CGColor];
	gradientLayer.startPoint = CGPointMake(0, 0);
	gradientLayer.endPoint = CGPointMake(0, 1);
	gradientLayer.frame = CGRectMake(0, 55 + 64, self.view.frame.size.width, self.view.frame.size.height - 56 - 115 - 64 - 12);
	[self.view.layer addSublayer:gradientLayer];
	//[bgView.layer addSublayer:gradientLayer];
	//gradientLayer.mask = bgView.layer;
	gradientLayer.mask = bgView.layer;
	bgView.frame = gradientLayer.bounds;
}

#pragma mark - UITalbeViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.tempListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCell.description];
	cell.backgroundColor = UIColor.clearColor;
	cell.contentView.backgroundColor = UIColor.clearColor;
	cell.textLabel.text = self.tempListArray[indexPath.section];
	cell.textLabel.font = [UIFont systemFontOfSize:60];
	cell.textLabel.backgroundColor = UIColor.clearColor;
	cell.textLabel.textColor = UIColor.blackColor;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	if (tableView == self.tableView2) {
		cell.textLabel.textColor = UIColor.clearColor;
	}
	return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[self.tableView setContentOffset:scrollView.contentOffset];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	return;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return 0.001;
	}
	return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 0.001;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	return UIView.alloc.init;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	return nil;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//	NSArray *visiableCells = [self.tableView visibleCells];
//	NSInteger index = 0;
//	for (UITableViewCell *cell in visiableCells) {
//		CGRect frame = [cell convertRect:cell.bounds toView:self.tableView];
//		CGPoint point = self.tableView.contentOffset;
//
//		if (point.y < 0) {
//			if (index == 0) {
//				cell.textLabel.textColor = UIColor.redColor;
//			} else {
//				cell.textLabel.textColor = UIColor.grayColor;
//			}
//		} else if(point.y + self.tableView.frame.size.height > self.tableView.contentSize.height) {
//			if (index == visiableCells.count - 1) {
//				cell.textLabel.textColor = UIColor.redColor;
//			} else {
//				cell.textLabel.textColor = UIColor.grayColor;
//			}
//		} else {
//			CGRect currFrame = CGRectMake(0, frame.origin.y - point.y + 55 + 64, frame.size.width, 60);
//			if (CGRectContainsPoint(currFrame, self.tableView.center)) {
//				cell.textLabel.textColor = UIColor.redColor;
//			} else {
//				cell.textLabel.textColor = UIColor.grayColor;
//			}
//		}
//		index++;
//	}
//}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
	int verticalOffset = ((int)targetContentOffset->y % 72);
	if (velocity.y < 0) {
		targetContentOffset->y -= verticalOffset;
	} else if (velocity.y > 0) {
		targetContentOffset->y += (72 - verticalOffset);

	} else {
		if (verticalOffset < 72 / 2) {
			targetContentOffset->y -= verticalOffset;

		} else {
			targetContentOffset->y += (72 - verticalOffset);
		}
	}
}

@end
