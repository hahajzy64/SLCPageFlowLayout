//
//  SWPPageFlowLayout.h
//  WallpaperTest4
//
//  Created by jzy on 2018/3/26.
//  Copyright © 2018年 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLCPageFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) BOOL isPage;

// 如果需要卡片重叠，设置X轴放大倍数大于1.0到卡片重叠即可。
// apartScale: cell中心距离collectionview中心差的绝对值/collectionview宽度
@property (nonatomic, copy) CGAffineTransform (^transformBlock)(CGFloat apartScale);

@end
