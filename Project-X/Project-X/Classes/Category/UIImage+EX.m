//
//  UIImage+EX.m
//  Project-X
//
//  Created by crfchina-mac-mini-1000 on 2017/3/7.
//  Copyright © 2017年 陈擎霄. All rights reserved.
//

#import "UIImage+EX.h"

@implementation UIImage (EX)
- (UIImage *)imageWithCornerRadius:(CGFloat)radius {
    CGRect rect = (CGRect){0.f, 0.f, self.size};
    
    
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
    
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    
    CGContextClip(UIGraphicsGetCurrentContext());
    
    
    
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    
    UIGraphicsEndImageContext();
    
    
    
    return image;
    

}
@end
