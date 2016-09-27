//
//  FUTableViewIndexBar.h
//  FUTableViewIndexBar
//
//  Copyright (c) 2016 fujunzhi. All rights reserved.
//  change by fjz  Inspiration from ‘AIMTableViewIndexBar’
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
/**************************************************************
1.#import "FUTableViewIndexBar.h"
2.初始化FUTableViewIndexBar
3.在TableView的numberOfSectionsInTableView代理方法中为索引数组赋值（setIndexes:）
**************************************************************/


#import <UIKit/UIKit.h>
@class FUTableViewIndexBar;

typedef void(^ EffectBlock)(UIColor **borderColor,UIColor **indexTextColor,UIColor **animateColor,UIColor **selectIndexColor);

@protocol FUTableViewIndexBarDelegate <NSObject>
//选中索引
- (void)fu_TableViewIndexBar:(FUTableViewIndexBar*)indexBar  sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;

@end

@interface FUTableViewIndexBar : UIView

@property (nonatomic, assign) id <FUTableViewIndexBarDelegate> delegate;

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/**
 *  索引数组
 */
@property (nonatomic, strong) NSArray *indexes;
/**
 *  是否是默认的索引列表(defaule:NO；#、A-Z)
 */
@property (assign, nonatomic, getter=isDefaultIndextList) BOOL defaultIndextList;
/**
 *  选中字体是否变大（defaule:YES）
 */
@property (assign, nonatomic, getter=isSelectBig) BOOL selectBig;

/*- - - - - - - - - - - - - -方法 - - - - - - - - - - - - - - - */

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
+ (instancetype)fuTableViewIndexBarWithFrame:(CGRect)frame;
+ (instancetype)fuTableViewIndexBarWithFrame:(CGRect)frame effect:(EffectBlock)effect;
@end






