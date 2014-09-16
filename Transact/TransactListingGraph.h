//
//  TransactListingGraph.h
//  Transact
//
//  Created by Trsoft Developer on 05/09/14.
//  Copyright (c) 2014 TrSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define kGraphHeight 300
//#define kDefaultGraphWidth 900
//#define kOffsetX 10
//#define kStepX 70
//#define kGraphBottom 300
//#define kGraphTop 0
//
//#define kStepY 50
//#define kOffsetY 10
//
//#define kBarTop 10
//#define kBarWidrh 40



#define kGraphHeight 300
#define kDefaultGraphWidth 900
#define kOffsetX 10
#define kStepX 54
#define kGraphBottom 350
#define kGraphTop 0
#define kStepY 50
#define kOffsetY 10
#define kBarTop 10
#define kBarWidth 25

NSMutableArray *startXArray;
NSMutableArray *barHeightArray;
NSMutableArray *startYArray;
NSArray *myArray;
NSMutableArray *stringArray;
NSMutableArray *data;
NSUInteger keyCountofReturnedData;
NSMutableArray *data2;
__strong NSNumber *barHeight;
@interface TransactListingGraph : UIView

@end
