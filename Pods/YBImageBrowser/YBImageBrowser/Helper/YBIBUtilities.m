//
//  YBIBUtilities.m
//  YBImageBrowserDemo
//
//  Created by 杨少 on 2018/4/11.
//  Copyright © 2018年 杨波. All rights reserved.
//

#import "YBIBUtilities.h"
#import <sys/utsname.h>


UIWindow *YBIBGetNormalWindow(void) {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *temp in windows) {
            if (temp.windowLevel == UIWindowLevelNormal) {
                window = temp; break;
            }
        }
    }
    return window;
}

UIViewController *YBIBGetTopController(void) {
    UIWindow *window = YBIBGetNormalWindow();
    if (!window) return nil;
    
    UIViewController *top = nil;
    id nextResponder;
    if (window.subviews.count > 0) {
        UIView *frontView = [window.subviews objectAtIndex:0];
        nextResponder = frontView.nextResponder;
    }
    if (nextResponder && [nextResponder isKindOfClass:UIViewController.class]) {
        top = nextResponder;
    } else {
        top = window.rootViewController;
    }
    
    while ([top isKindOfClass:UITabBarController.class] || [top isKindOfClass:UINavigationController.class] || top.presentedViewController) {
        if ([top isKindOfClass:UITabBarController.class]) {
            top = ((UITabBarController *)top).selectedViewController;
        } else if ([top isKindOfClass:UINavigationController.class]) {
            top = ((UINavigationController *)top).topViewController;
        } else if (top.presentedViewController) {
            top = top.presentedViewController;
        }
    }
    return top;
}

BOOL YBIBLowMemory(void) {
    static BOOL lowMemory = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        unsigned long long physicalMemory = [[NSProcessInfo processInfo] physicalMemory];
        lowMemory = physicalMemory > 0 && physicalMemory < 1024 * 1024 * 1500;
    });
    return lowMemory;
}


@implementation YBIBUtilities

+ (BOOL)isIphoneX {
    static BOOL isIphoneX = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSSet *platformSet = [NSSet setWithObjects:@"iPhone10,3", @"iPhone10,6", @"iPhone11,8", @"iPhone11,2", @"iPhone11,4", @"iPhone11,6", nil];
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        if ([platform isEqualToString:@"x86_64"] || [platform isEqualToString:@"i386"]) {
            platform = NSProcessInfo.processInfo.environment[@"SIMULATOR_MODEL_IDENTIFIER"];
        }
        isIphoneX = [platformSet containsObject:platform];
    });
    return isIphoneX;
}

+ (UIImage *)snapsHotView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)screenShotLayer:(CALayer *)layer {
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, NO, [UIScreen mainScreen].scale);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    for (CALayer *subLayer in layer.sublayers) {
        [subLayer renderInContext:UIGraphicsGetCurrentContext()];
    }
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
