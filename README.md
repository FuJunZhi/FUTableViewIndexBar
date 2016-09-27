# FUTableViewIndexBar
*自定义TableView索引栏


### CocoaPods

  1. Add `pod 'FUTableViewIndexBar', '~> 1.0.2'` to your Podfile.

  2. Run `pod install` or `pod update`.

  3. '#import "FUTableViewIndexBar.h"'.


#initialize
## <a id="initialize"></a>
```objc
1.初始化FUTableViewIndexBar
2.在TableView的numberOfSectionsInTableView代理方法中为索引数组赋值（setIndexes:）
```
#delegate
## <a id="delegate"></a>
```objc
@protocol FUTableViewIndexBarDelegate <NSObject>
//选中索引
- (void)fu_TableViewIndexBar:(FUTableViewIndexBar*)indexBar  sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;

@end
```
#setUp
## <a id="setUp"></a>
```objc
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
```




