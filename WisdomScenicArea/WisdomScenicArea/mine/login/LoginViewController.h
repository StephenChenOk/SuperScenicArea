//
//  LoginViewController.h
//  SmartScenicArea
//
//  Created by chen on 2020/5/23.
//  Copyright © 2020 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//定义一个检查用户是否已经登入的block类型
typedef void(^checkLoginState)(BOOL,NSString *);

@interface LoginViewController : UIViewController

@property(nonatomic,strong,readwrite) checkLoginState loginState;

@end

NS_ASSUME_NONNULL_END
