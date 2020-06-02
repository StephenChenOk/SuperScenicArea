//
//  LoginRegisterUtil.h
//  WisdomScenicArea
//
//  Created by chen on 2020/5/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserUtil : NSObject

//新建用户
- (BOOL)addUserWithAccount:(NSString *)account AndPwd:(NSString *)pwd;
//查询数据,无过滤条件
- (NSArray *)queryUser;
//查询数据,有过滤条件
- (NSArray *)queryUserWithFilter:(NSString *)filter;

//判断两次密码是否相同
- (BOOL)isPwdSame:(NSString *)pwd1 andPwdTwo:(NSString *)pwd2;
//判断账号是否与密码相对应
- (BOOL)isPwdCorrected:(NSString *)account andPwd:(NSString *)password;
//登入时判断当前用户名是否已经存在
- (BOOL)isUserExisted:(NSString *)account;
//注册时判断当前用户名是否可用
- (BOOL)isUserAvailable:(NSString *)account;
//删除数据库中的所有数据
- (void)deleteAllUser;
//修改昵称
- (BOOL)modifyName:(NSString *)newName;
//修改手机号码
- (BOOL)modifyPhone:(NSString *)phone;
//修改用户头像
- (BOOL)modifyHeadIcon:(NSString *)imagePath;

@end

NS_ASSUME_NONNULL_END
