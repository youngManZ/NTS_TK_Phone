//
//  UIImage+CircleImage.m
//  NTS_TK_PhoneViewController
//
//  Created by nrh on 2018/6/6.
//  Copyright © 2018年 zt. All rights reserved.
//

#import "UIImage+CircleImage.h"

@implementation UIImage (CircleImage)

- (UIImage *)drawCircleImageWithCornerRadius:(CGFloat)cornerRadius {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.size.width, self.size.height) cornerRadius:self.size.width / 2] addClip];
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
}

@end
