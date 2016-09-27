//
//  FUTableViewIndexBar.h
//  FUTableViewIndexBar
//
//  Copyright (c) 2016 fujunzhi. All rights reserved.
//  change by fjz  Inspiration from ‘AIMTableViewIndexBar’
//
/**************************************************************
1.服从代理<FUTableViewIndexBarDelegate>
2.#import "FUTableViewIndexBar.h"
3.初始化FUTableViewIndexBar
4.执行代理方法
 - (void)fu_TableViewIndexBar:(FUTableViewIndexBar *)indexBar didSelectSectionAtIndex:(NSInteger)index{
 if ([plainTableView numberOfSections] > index && index > -1){   // for safety, should always be YES
 [plainTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]
 atScrollPosition:UITableViewScrollPositionTop
 animated:YES];
 }
 }
5.在TableView的numberOfSectionsInTableView代理方法中为索引数组赋值（setIndexes:）
**************************************************************/


#import <UIKit/UIKit.h>

@class FUTableViewIndexBar;

@protocol FUTableViewIndexBarDelegate <NSObject>

- (void)fu_TableViewIndexBar:(FUTableViewIndexBar*)indexBar didSelectSectionAtIndex:(NSInteger)index;

@end

@interface FUTableViewIndexBar : UIView

//索引数组
@property (nonatomic, strong) NSArray *indexes;

//是否是默认的索引列表(defaule:NO；#、A-Z)
@property (assign, nonatomic, getter=isDefaultIndextList) BOOL defaultIndextList;
//选中字体是否变大（defaule:YES）
@property (assign, nonatomic, getter=isSelectBig) BOOL selectBig;

@property (nonatomic, weak) id <FUTableViewIndexBarDelegate> delegate;

/**
 *  初始化
 *
 *  @param frame              视图大小
 *  @param borderColor        边框的颜色
 *  @param indexTextColor     索引字体颜色
 *  @param animateColor       背景动画颜色（cleanColor：无动画）
 *  @param selectIndexColor   选中索引颜色
 *
 *  @return FUTableViewIndexBar(颜色为空则为默认颜色)
 */
- (instancetype)initWithFrame:(CGRect)frame borderColor:(UIColor *)borderColor indexTextColor:(UIColor *)indexTextColor animateColor:(UIColor *)animateColor selectIndexColor:(UIColor *)selectColor;

+ (instancetype)fuTableViewIndexBarWithFrame:(CGRect)frame borderColor:(UIColor *)borderColor indexTextColor:(UIColor *)indexTextColor animateColor:(UIColor *)animateColor selectIndexColor:(UIColor *)selectColor;



@end






