//
//  TransactListingGraph.m
//  Transact
//
//  Created by Trsoft Developer on 05/09/14.
//  Copyright (c) 2014 TrSoft. All rights reserved.
//

#import "TransactListingGraph.h"

@implementation TransactListingGraph

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawBar:(CGRect)rect context:(CGContextRef)ctx
{
    CGContextBeginPath(ctx);
    CGContextSetGrayFillColor(ctx, 0.2, 0.7);
    CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));
    
    
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
    
    
}


- (void)drawRect:(CGRect)rect
{
    
    CGContextRef Our_View_Context = UIGraphicsGetCurrentContext();
    // CGContextSetTextMatrix(Our_View_Context, CGAffineTransformRotate(CGAffineTransformMake(1.0, 0.0, 0.0, -0.5, 1.0, 1.0), M_PI / 2));
    CGContextSetLineWidth(Our_View_Context, 0.6);
    CGContextSetStrokeColorWithColor(Our_View_Context, [[UIColor lightGrayColor] CGColor]);
    
    //--------->BackGroudLines
    //For Vertical Lines
    int howManyLinesOnBackGroundVertical = (kDefaultGraphWidth - kOffsetX) / kStepX;
    
    for (int i = 0; i < (howManyLinesOnBackGroundVertical+1); i++)
    {
        CGContextMoveToPoint(Our_View_Context, kOffsetX + i * kStepX, kGraphTop);
        if (i==0) {
            CGContextAddLineToPoint(Our_View_Context, kOffsetX + i * (kStepX), kGraphBottom);
        }
        else
        {
            CGContextAddLineToPoint(Our_View_Context, kOffsetX + i * kStepX, kGraphBottom);
        }
        
    }
    
    CGContextStrokePath(Our_View_Context);
    
    
    //For Horizontal Lines
    int howManyHorizontalLinesOnBackGround = (kGraphBottom - kGraphTop - kOffsetY) / kStepY;
    
    int Scale ;
    
    
    NSString *str = [NSString stringWithFormat: (@"%@"),barHeight];
    
    int FirstCharacterOfString;
    NSString *FirstCharacterinString ;
    int LengthOfZeros = [str length];
    
    FirstCharacterinString = [str substringToIndex:1];
    
    FirstCharacterOfString = [FirstCharacterinString integerValue];
    
    FirstCharacterOfString = FirstCharacterOfString+1;
    Scale = FirstCharacterOfString * pow(10,(LengthOfZeros-1));
    data2 = [[NSMutableArray alloc] initWithCapacity:[data count]];
    
    for (int i = 1;i<([data count]);i++) {
        NSNumber *num = [NSNumber numberWithFloat:([[data objectAtIndex:i] floatValue]/Scale)];
        
        float Dat2 =[num floatValue];
        [data2 addObject:[NSNumber numberWithFloat:Dat2]];
        
    }
    for (int i= 0 ; i<[data2 count]; i++) {
        NSLog(@"%@",data2[i]);
    }
    
    
    
    
    int interval;
    interval= Scale/5;
    for (int i = 1; i <= howManyHorizontalLinesOnBackGround; i++)
    {
        CGContextMoveToPoint(Our_View_Context, kOffsetX, kGraphBottom - kOffsetY - i * kStepY);
        CGContextAddLineToPoint(Our_View_Context, kDefaultGraphWidth, kGraphBottom - kOffsetY - i * kStepY);
        CGContextSelectFont(Our_View_Context, "Helvetica", 10, kCGEncodingMacRoman);
        CGContextSetTextDrawingMode(Our_View_Context, kCGTextFill);
        CGContextSetFillColorWithColor(Our_View_Context, [[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] CGColor]);
        CGContextSetTextMatrix (Our_View_Context, CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0));
        NSString *theText = [NSString stringWithFormat:@"%d",Scale];
        NSString *InitialPiont = @"0";
        
        
        CGContextShowTextAtPoint(Our_View_Context, 5, (kStepY*i), [theText cStringUsingEncoding:NSUTF8StringEncoding], [theText length]);
        
        Scale = Scale-interval;
        
    }
    CGContextStrokePath(Our_View_Context);
    
    //--------->UptoHere
    //float data[] = {0.7, 0.9, 0.9, 0.4, 0.2, 0.85,0.35,0.8,0.21};
    
    CGFloat dash[] = {2.0, 2.0};
    CGContextSetLineDash(Our_View_Context, 0, dash, 0);
    startXArray = [[NSMutableArray alloc] initWithCapacity:keyCountofReturnedData];
    barHeightArray = [[NSMutableArray alloc] initWithCapacity:keyCountofReturnedData];
    startYArray = [[NSMutableArray alloc] initWithCapacity:keyCountofReturnedData];
    
    
    
    
    
    
    float maxBarHeight = (kGraphHeight - kBarTop - kOffsetY);
    NSLog(@"%d",[data count]);
    NSLog(@"%d",[data2 count]);
    int j =0;
    for (int i = 0; i <([data count]); i++)
    {
        //;
        if (j<([data2 count])) {
            float barX = (kOffsetX + kStepX + i * kStepX - kBarWidth / 2)+10;
            float barXValue =[[data2 objectAtIndex:j] floatValue];
            
            float barY = (kBarTop + maxBarHeight - maxBarHeight *barXValue);
            float barHeight = maxBarHeight * [[data2 objectAtIndex:j] floatValue];
            
            [startXArray addObject:[NSNumber numberWithFloat:(barX + 44)]];
            [barHeightArray addObject:[NSNumber numberWithFloat:barHeight]];
            [startYArray addObject:[NSNumber numberWithFloat:(barY + 45)]]; //replace "36" by "86" if navigation bar is present on top of view
            
            NSLog(@"%@",startYArray[i]);
            
            
            CGRect barRect = CGRectMake(barX, barY, kBarWidth, barHeight);
            
            // NSLog(@"%f And %f And barWidth %f",barX,barY,kBarWidth);
            [self drawBar:barRect context:Our_View_Context];
            j++;
        }
        CGContextSetTextMatrix(Our_View_Context, CGAffineTransformMake(0.8, 0.0, 0.1, -1.0, 0.0, 0.0));
        CGContextSelectFont(Our_View_Context, "Helvetica", 15, kCGEncodingMacRoman);
        CGContextSetTextDrawingMode(Our_View_Context, kCGTextFill);
        CGContextSetFillColorWithColor(Our_View_Context, [[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] CGColor]);
        
        NSString *theText = [NSString stringWithFormat:@"%@", stringArray[i]];
        CGContextShowTextAtPoint(Our_View_Context, kOffsetX + i * kStepX, kGraphBottom - 35, [theText cStringUsingEncoding:NSUTF8StringEncoding], [theText length]);
        
    }
    
    
    
}

@end
