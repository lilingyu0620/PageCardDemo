//
//  PageCardFlowLayout.m
//  PageCardDemo
//
//  Created by lly on 16/9/1.
//  Copyright © 2016年 lly. All rights reserved.
//

#define kPageCardWidth 280
#define kLineSpace 10
#define kPageCardHeight 160

#import "PageCardFlowLayout.h"

@interface PageCardFlowLayout()
@property (nonatomic,assign) int pageNum;
@end


@implementation PageCardFlowLayout

- (void)prepareLayout{
    
    [super prepareLayout];
    //滑动方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //两个cell的间距
    self.minimumLineSpacing = kLineSpace;
    //计算cell超出显示的宽度
    CGFloat width = ((self.collectionView.frame.size.width - kPageCardWidth)-(kLineSpace*2))/2;
    //第一个cell和最后一个cell相对于屏幕的偏移
    self.sectionInset = UIEdgeInsetsMake(0, kLineSpace+width, 0, kLineSpace+width);
    //每个cell实际的大小
    self.itemSize = CGSizeMake(kPageCardWidth,kPageCardHeight);
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *superAttributes = [super layoutAttributesForElementsInRect:rect];
    NSArray *attributes = [[NSArray alloc] initWithArray:superAttributes copyItems:YES];
    
    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x,
                                    self.collectionView.contentOffset.y,
                                    self.collectionView.frame.size.width,
                                    self.collectionView.frame.size.height);
    CGFloat offset = CGRectGetMidX(visibleRect);
    
    [attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat distance = offset - attribute.center.x;
        // 越往中心移动，值越小，那么缩放就越小，从而显示就越大
        // 同样，超过中心后，越往左、右走，缩放就越大，显示就越小
        CGFloat scaleForDistance = distance / self.itemSize.width;
        // 0.1可调整，值越大，显示就越大
        CGFloat scaleForCell = 1 + 0.1 * (1 - fabs(scaleForDistance));
        
        //只在Y轴方向做缩放
        attribute.transform3D =  CATransform3DMakeScale(1, scaleForCell, 1);
        attribute.zIndex = 1;
        
        //渐变
        CGFloat scaleForAlpha = 1 - fabsf(scaleForDistance)*0.6;
        attribute.alpha = scaleForAlpha;
    }];
    
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    // 分页以1/3处
    if (proposedContentOffset.x > self.previousOffsetX + self.itemSize.width / 3.0) {
        self.previousOffsetX += kPageCardWidth+kLineSpace ;
        self.pageNum = self.previousOffsetX/(kPageCardWidth+kLineSpace);
        if ([self.delegate respondsToSelector:@selector(scrollToPageIndex:)]) {
            [self.delegate scrollToPageIndex:self.pageNum];
        }
    } else if (proposedContentOffset.x < self.previousOffsetX  - self.itemSize.width / 3.0) {
        self.previousOffsetX -= kPageCardWidth+kLineSpace;
        self.pageNum = self.previousOffsetX/(kPageCardWidth+kLineSpace);
        if ([self.delegate respondsToSelector:@selector(scrollToPageIndex:)]) {
            [self.delegate scrollToPageIndex:self.pageNum];
        }
    }
    //将当前cell移动到屏幕中间位置
    proposedContentOffset.x = self.previousOffsetX;
    
    return proposedContentOffset;
}

@end
