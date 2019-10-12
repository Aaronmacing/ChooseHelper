//
//  StockSingleResultVO.h
//  stockHelper
//
//  Created by Apple on 2019/8/7.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Gopicture,DataSingle,Hengsheng_Data;
@interface StockSingleResultVO : NSObject

@property (nonatomic, strong) Gopicture *gopicture;

@property (nonatomic, strong) DataSingle *data;

//@property (nonatomic, strong) Hengsheng_Data *hengsheng_data;

@end
@interface Gopicture : NSObject

@property (nonatomic, copy) NSString *dayurl;

@property (nonatomic, copy) NSString *monthurl;

@property (nonatomic, copy) NSString *minurl;

@property (nonatomic, copy) NSString *weekurl;

@end

@interface DataSingle : NSObject

@property (nonatomic, copy) NSString *buyThree;

@property (nonatomic, copy) NSString *traNumber;

@property (nonatomic, copy) NSString *buyFive;

@property (nonatomic, copy) NSString *buyTwo;

@property (nonatomic, copy) NSString *sellOne;

@property (nonatomic, copy) NSString *sellThreePri;

@property (nonatomic, copy) NSString *yestodEndPri;

@property (nonatomic, copy) NSString *nowPri;

@property (nonatomic, copy) NSString *gid;

@property (nonatomic, copy) NSString *buyOnePri;

@property (nonatomic, copy) NSString *sellFive;

@property (nonatomic, copy) NSString *sellTwo;

@property (nonatomic, copy) NSString *buyOne;

@property (nonatomic, copy) NSString *buyThreePri;

@property (nonatomic, copy) NSString *todayMin;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *todayMax;

@property (nonatomic, copy) NSString *buyFivePri;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *sellOnePri;

@property (nonatomic, copy) NSString *competitivePri;

@property (nonatomic, copy) NSString *sellTwoPri;

@property (nonatomic, copy) NSString *buyTwoPri;

@property (nonatomic, copy) NSString *increase;

@property (nonatomic, copy) NSString *buyFourPri;

@property (nonatomic, copy) NSString *traAmount;

@property (nonatomic, copy) NSString *sellFour;

@property (nonatomic, copy) NSString *increPer;

@property (nonatomic, copy) NSString *sellFivePri;

@property (nonatomic, copy) NSString *buyFour;

@property (nonatomic, copy) NSString *sellThree;

@property (nonatomic, copy) NSString *reservePri;

@property (nonatomic, copy) NSString *sellFourPri;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *todayStartPri;



@property (nonatomic,copy) NSString *lastestpri;



@property (nonatomic,copy) NSString *cname;

@property (nonatomic, copy) NSString *market;

@property (nonatomic, copy) NSString *symbol;

@property (nonatomic, copy) NSString *min52;



@property (nonatomic, copy) NSString *maxpri;

@property (nonatomic, copy) NSString *inpic;

@property (nonatomic, copy) NSString *formpri;

@property (nonatomic, copy) NSString *minpri;



@property (nonatomic, copy) NSString *outpic;

@property (nonatomic, copy) NSString *priearn;

@property (nonatomic, copy) NSString *ename;

@property (nonatomic, copy) NSString *uppic;

@property (nonatomic, copy) NSString *limit;



@property (nonatomic, copy) NSString *openpri;



@property (nonatomic, copy) NSString *max52;

@property (nonatomic, copy) NSString *trade;

@property (nonatomic, copy) NSString *lasttrade;

@property (nonatomic, copy) NSString *pricechange;

@property (nonatomic, copy) NSString *diff;

@property (nonatomic, copy) NSString *low;

@property (nonatomic, copy) NSString *settlement;

@property (nonatomic, copy) NSString *prevclose;

@property (nonatomic, copy) NSString *amount;

@property (nonatomic, copy) NSString *changepercent;

@property (nonatomic, copy) NSString *chg;

@property (nonatomic, copy) NSString *high;

@property (nonatomic, copy) NSString *open;

@property (nonatomic, copy) NSString *volume;

@end

@interface Hengsheng_Data : NSObject

@property (nonatomic, copy) NSString *maxpri;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *formpri;

@property (nonatomic, copy) NSString *minpri;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *limit;

@property (nonatomic, copy) NSString *uppic;

@property (nonatomic, copy) NSString *max52;

@property (nonatomic, copy) NSString *min52;

@property (nonatomic, copy) NSString *lastestpri;

@property (nonatomic, copy) NSString *openpri;

@property (nonatomic, copy) NSString *traAmount;

@end



NS_ASSUME_NONNULL_END
