//
//  SWPPageFlowLayout.m
//  WallpaperTest4
//
//  Created by jzy on 2018/3/26.
//  Copyright © 2018年 SecretLisa. All rights reserved.
//  https://github.com/DamonHu/CollectionCircleDemo
//  https://blog.csdn.net/sinat_27706697/article/details/45869727

#import "SLCPageFlowLayout.h"

@implementation SLCPageFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

#pragma mark - delegate
// 当UICollectionView停止的那一刻ContentOffset的值(控制UICollectionView停止时，有一个Item一定居中显示)
// 1.proposedContentOffset默认的ContentOffset
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    if (self.isPage) {
        //1. 获取UICollectionView停止的时候的可视范围
        CGRect contentFrame;
        contentFrame.size = self.collectionView.frame.size;
        contentFrame.origin = proposedContentOffset;
        NSArray *array = [self layoutAttributesForElementsInRect:contentFrame];
        //2. 计算在可视范围的距离中心线最近的Item
        CGFloat collectionViewCenterX = proposedContentOffset.x + self.collectionView.frame.size.width*0.5;
        CGFloat minCenterX = [self getTheCenterAtt:array].center.x - collectionViewCenterX;
        //3. 补回ContentOffset，则正好将Item居中显示
        CGFloat minX = 0;
        CGFloat maxX = self.collectionView.contentSize.width-self.collectionView.bounds.size.width;
        if (proposedContentOffset.x>minX && proposedContentOffset.x<maxX) {
            return CGPointMake(proposedContentOffset.x + minCenterX, proposedContentOffset.y);
        } else {
            return proposedContentOffset;
        }
    } else {
        return proposedContentOffset;
    }
}

//设置放大动画
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    if (!self.transformBlock) {
        return [super layoutAttributesForElementsInRect:rect];
    }
    NSArray *arr = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:rect]];
    //屏幕中线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
    //刷新cell缩放
    for (UICollectionViewLayoutAttributes *attributes in arr) {
        CGFloat distance = fabs(attributes.center.x - centerX);
        //移动的距离和屏幕宽度的的比例
        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
        if (self.transformBlock) {
            CGAffineTransform transform = self.transformBlock(apartScale);
            attributes.transform = transform;
        }
        //        else {
        //            //把卡片移动范围固定到 -π/4到 +π/4这一个范围内
        //            CGFloat scale = fabs(cos(apartScale * M_PI/4));
        //            //设置cell的缩放 按照余弦函数曲线 越居中越趋近于1
        //            attributes.transform = CGAffineTransformMakeScale(1.2, scale);
        //        }
        //重置层级z轴
        attributes.zIndex = 0;
    }
    
    UICollectionViewLayoutAttributes *attrs = [self getTheCenterAtt:arr];
    attrs.zIndex = 100;
    
    return arr;
}

//是否需要重新计算布局
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return true;
}

#pragma mark - private
//防止报错 先复制attributes
- (NSArray *)getCopyOfAttributes:(NSArray *)attributes
{
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}

- (UICollectionViewLayoutAttributes *)getTheCenterAtt:(NSArray *)array
{
    CGFloat minCenterX = CGFLOAT_MAX;
    UICollectionViewLayoutAttributes *minAttrs = [UICollectionViewLayoutAttributes new];
    minAttrs.center = CGPointZero;
    CGFloat collectionViewCenterX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width*0.5;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if(ABS(attrs.center.x - collectionViewCenterX) < ABS(minCenterX)){
            minCenterX = attrs.center.x - collectionViewCenterX;
            minAttrs = attrs;
        }
    }
    return minAttrs;
}

@end
