//
//  GHStarView.m
//  GHome
//
//  Created by Qincc on 2021/1/11.
//

#import "GHStarView.h"

@interface GHStarShowView : UIView

@property (nonatomic, strong) GHStarViewConfig *config;

- (instancetype)initWithFrame:(CGRect)frame config:(GHStarViewConfig *)config;

- (CGRect)rectFromStar:(NSInteger)star;

@end

@implementation GHStarViewConfig


@end

@interface GHStarView ()

@property (nonatomic, strong) GHStarViewConfig *config;
@property (nonatomic, strong) GHStarShowView *starShowView;

@end

@implementation GHStarView

+ (instancetype)starViewWithSize:(CGSize)size config:(GHStarViewConfig *)config {
	GHStarView *view = [GHStarView.alloc initWithFrame:CGRectMake(0, 0, size.width, size.height) config:config];
	view.backgroundColor = UIColor.whiteColor;
	return view;
}

- (instancetype)initWithFrame:(CGRect)frame config:(GHStarViewConfig *)config
{
	self = [super initWithFrame:frame];
	if (self) {
		self.config = config;
		[self viewsLayout];
	}
	return self;
}

- (void)viewsLayout {
	NSMutableArray *imageViewsArray = NSMutableArray.alloc.init;
	for (NSInteger index = 0; index < self.config.starCount; ++index) {
		UIImageView *imageView = [UIImageView.alloc initWithFrame:CGRectMake(0 + 12 * index + self.config.itemSpace * index, (self.frame.size.height - 12) * 0.5, 12, 12)];
		imageView.backgroundColor = UIColor.whiteColor;
		imageView.image = ASImage(self.config.starEmptyImageName);
		imageView.tag = 100 + index;
		[self addSubview:imageView];
		[imageViewsArray addObject:imageView];
	}
	
	self.starShowView = [[GHStarShowView alloc] initWithFrame:self.bounds config:self.config];
	self.starShowView.clipsToBounds = YES;
	self.starShowView.frame = CGRectMake(0, 0, 72, self.bounds.size.height);
	[self addSubview:self.starShowView];
}

- (void)updateStar:(CGFloat)starValue {
	NSInteger index = (NSInteger)starValue;
	CGRect frame = [self.starShowView rectFromStar:index];
	CGFloat width = CGRectGetMaxX(frame);
	if (starValue - index > 0) {
		CGFloat distance = 12 * (starValue - index);
		width = index > 0 ? width + distance + self.config.itemSpace : distance;
	}
	[self.starShowView setFrame:CGRectMake(0, 0, width, self.frame.size.height)];
}

@end



@implementation GHStarShowView

- (instancetype)initWithFrame:(CGRect)frame config:(GHStarViewConfig *)config {
	if (self = [super initWithFrame:frame]) {
		self.config = config;
		[self viewsLayout];
	}
	return self;
}

- (void)viewsLayout {
	NSMutableArray *imageViewsArray = NSMutableArray.alloc.init;
	for (NSInteger index = 0; index < self.config.starCount; ++index) {
		UIImageView *imageView = [UIImageView.alloc initWithFrame:CGRectMake(0 + 12 * index + self.config.itemSpace * index, (self.frame.size.height - 12) * 0.5, 12, 12)];
		imageView.backgroundColor = UIColor.whiteColor;
		imageView.image = ASImage(self.config.starFillImageName);
		imageView.tag = 100 + index;
		[self addSubview:imageView];
		[imageViewsArray addObject:imageView];
	}
}

- (CGRect)rectFromStar:(NSInteger)star {
	if (star == 0) {
		return CGRectMake(0, 0, 0, self.frame.size.height);
	}
	
	UIImageView *image = [self viewWithTag:100 + star - 1];
	return image.frame;
}

@end

