//
//  DottedLineView.m
//  NTS_TK_PhoneViewController
//
//  Created by nrh on 2018/6/5.
//  Copyright © 2018年 zt. All rights reserved.
//

#import "DottedLineView.h"
#import "Dashline.h"

@implementation DottedLineView

- (instancetype)initWithFrame:(CGRect)frame verLineNum : (NSInteger) verLineNum horLineNum : (NSInteger) horLineNum{
    if (self = [super initWithFrame:frame]) {
        [self initViwWithFrame:frame verLineNum:verLineNum horLineNum:horLineNum];
    }
    return self;
}

- (void) initViwWithFrame : (CGRect) frame verLineNum : (NSInteger) verLineNum horLineNum : (NSInteger) horLineNum {
    
    for (int i = 0; i < verLineNum; i++) {
        Dashline *verLine = [[Dashline alloc] initWithFrame:CGRectMake(frame.size.width / (verLineNum + 1) * (i + 1), 0, 1, frame.size.height) withLineLength:3 withLineSpacing:2 withLineColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1] withDirectionType:0];
        [self addSubview:verLine];
    }
    for (int i = 0; i < horLineNum; i++) {
        Dashline *verLine = [[Dashline alloc] initWithFrame:CGRectMake(0, frame.size.height / horLineNum * (i + 1), frame.size.width, 1) withLineLength:3 withLineSpacing:2 withLineColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1] withDirectionType:1];
        [self addSubview:verLine];
    }
}

@end
