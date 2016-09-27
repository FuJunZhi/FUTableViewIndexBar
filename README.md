# FUTableViewIndexBar
*自定义TableView索引栏


### CocoaPods

  1. Add `pod 'FUTableViewIndexBar', '~> 1.0.0'` to your Podfile.

  2. Run `pod install` or `pod update`.

  3. '#import "FUTableViewIndexBar.h"'.


#initialize
## <a id="initialize"></a>
```objc
1.服从代理<FUTableViewIndexBarDelegate>
2.#import "FUTableViewIndexBar.h"
3.初始化FUTableViewIndexBar
4.执行代理方法
- (void)tableViewIndexBar:(FUTableViewIndexBar *)indexBar didSelectSectionAtIndex:(NSInteger)index{
if ([plainTableView numberOfSections] > index && index > -1){   // for safety, should always be YES
[plainTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]
atScrollPosition:UITableViewScrollPositionTop
animated:YES];
}
}
5.在TableView的numberOfSectionsInTableView代理方法中为索引数组赋值（setIndexes:）
@end
```
```