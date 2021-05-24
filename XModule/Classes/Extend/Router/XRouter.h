//
//  XRouter.h
//  XModule
//
//  Created by 苏秋东 on 2021/5/24.
//

#import <Foundation/Foundation.h>
#import "CTMediator.h"

typedef enum : NSUInteger {
//    原生内跳转
    XUrlTypeNative = 0,
//    跳转到内部网页
    XUrlTypeWeb = 1,
//    连接解析错误
    XUrlTypeError = 2,
} XUrlType;


NS_ASSUME_NONNULL_BEGIN

@interface XRouter : CTMediator



+ (instancetype)sharedInstance;

/// 根据链接获取控制器并进行跳转
/// @param linkUrlStr fltrporganstudent://fltrp.com/words/enterController?classId=1&name=summer
- (void)routerWithLinkUrlStr:(NSString *)linkUrlStr;

/// 判断是否还有需要跳转的路由，有的话就进行跳转
- (void)judgeExistLinkUrlStr;

@end

NS_ASSUME_NONNULL_END
