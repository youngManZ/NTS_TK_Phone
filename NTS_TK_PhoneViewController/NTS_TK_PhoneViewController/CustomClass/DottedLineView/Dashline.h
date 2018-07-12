//
//  Dashline.h
//  line
//
//  Created by nrh on 2017/2/22.
//  Copyright © 2017年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface Dashline : UIView
{
    NSInteger _lineLength;
    NSInteger _lineSpacing;
    NSInteger _directionType;
    UIColor *_lineColor;
    CGFloat _height;
    CGFloat _width;
}
- (instancetype)initWithFrame:(CGRect)frame withLineLength:(NSInteger)lineLength withLineSpacing:(NSInteger)lineSpacing withLineColor:(UIColor *)lineColor withDirectionType:(NSInteger)directionType;
@end
