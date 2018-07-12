//
//  Dashline.m
//  line
//
//  Created by nrh on 2017/2/22.
//  Copyright © 2017年 zt. All rights reserved.
//

#import "Dashline.h"

@implementation Dashline

- (instancetype)initWithFrame:(CGRect)frame withLineLength:(NSInteger)lineLength withLineSpacing:(NSInteger)lineSpacing withLineColor:(UIColor *)lineColor withDirectionType:(NSInteger)directionType{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _lineLength = lineLength;
        _lineSpacing = lineSpacing;
        _lineColor = lineColor;
        _height = frame.size.height;
        _width = frame.size.width;
        _directionType = directionType;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context,1);
    CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
    CGFloat lengths[] = {_lineLength,_lineSpacing};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, 0, 0);
    if (_directionType == 0) {
        CGContextAddLineToPoint(context, 0,_height);
    }else {
        CGContextAddLineToPoint(context, _width,0);
    }
    CGContextStrokePath(context);
    CGContextClosePath(context);
}

@end
