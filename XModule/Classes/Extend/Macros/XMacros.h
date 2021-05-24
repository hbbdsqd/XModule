//
//  XMacros.h
//  Pods
//
//  Created by 苏秋东 on 2021/5/24.
//

#ifndef XMacros_h
#define XMacros_h

#pragma mark ---------判断字符串、数组、字典、对象为空
//字符串是否为空
#define FLStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define FLArrayIsEmpty(array) ((array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0) ? YES : NO)
//字典是否为空
#define FLDictIsEmpty(dic) ((dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0) ? YES : NO)
//是否是空对象
#define FLObjectIsEmpty(_object) ((_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0)) ? YES : NO)


#pragma mark  ---------字体
#define XGetFont(fontSize) [UIFont systemFontOfSize:fontSize]

#define XGetBoldFont(fontSize) [UIFont boldSystemFontOfSize:fontSize]

#define XGetMediumFont(fontSize) [UIFont boldSystemFontOfSize:fontSize]


#pragma mark ---------MBProgressHUD
#define XShowMessage(message) [XToast showMessage:message];
#define XShowError(error) [XToast showError:error];
#define XShowSuccess(success) [MBProgressHUD showSuccess:success];
#define XShowWarn(warn) [XToast showWarning:warn];
#define XShowLoading [MBProgressHUD showActivityMessage:@"加载中..."];
#define XShowCustomLoading(text) [XToast showActivityMessage:text];
#define XHideHud [XToast hideHUD];

#endif /* XMacros_h */
