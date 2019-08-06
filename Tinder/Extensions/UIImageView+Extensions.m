//
//  UIImageView+Extensions.m
//  PointWorld_tea
//
//  Created by Deng on 2019/7/24.
//  Copyright © 2019 LPzee. All rights reserved.
//

#import "UIImageView+Extensions.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>

#import "NSData+Extensions.h"

@implementation UIImageView (Extensions)
//获取视频第一帧图片优化（异步加载数据）
-(void)imageWithVideoURL:(NSURL *)path placeHolderImage:(UIImage *)placeHolder
{
  NSString *name = [[[path absoluteString] dataUsingEncoding:NSUTF8StringEncoding] MD5String];//视频链接转MD5作为图片的名字
  NSString *PATH = [NSString stringWithFormat:@"%@/Documents/videoFolder/%@.png",NSHomeDirectory(),name];
  UIImage *imagePath = [[UIImage alloc] initWithContentsOfFile:PATH];
  if (imagePath) {
    //本地有缓存图片，加载本地图片并return
    self.image = imagePath;
    return;
  } else{
    //本地没有缓存图片，先加载占位图
    self.image = placeHolder;
  }
  dispatch_group_t group = dispatch_group_create();
  __block UIImage *videoImage;
  dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    long long second = 0;
    
    second = asset.duration.value /asset.duration.timescale / 2;
    CMTime time = CMTimeMakeWithSeconds(second, 2);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    
    //创建文件夹
    NSString *folder = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/videoFolder"];
    [[NSFileManager defaultManager] createDirectoryAtPath:folder withIntermediateDirectories:NO attributes:nil error:nil];
    [UIImagePNGRepresentation(videoImage) writeToFile:PATH atomically:YES];
  });
  
  dispatch_group_notify(group, dispatch_get_main_queue(), ^{
    //主线程更新UI
    self.image = videoImage;
  });
}
@end


