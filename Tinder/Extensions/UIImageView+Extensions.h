//
//  UIImageView+Extensions.h
//  PointWorld_tea
//
//  Created by Deng on 2019/7/24.
//  Copyright © 2019 LPzee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Extensions)
-(void)imageWithVideoURL:(NSURL *)path placeHolderImage:(UIImage *)placeHolder;
@end

NS_ASSUME_NONNULL_END
