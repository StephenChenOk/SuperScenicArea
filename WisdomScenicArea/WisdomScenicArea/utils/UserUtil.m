//
//  LoginRegisterUtil.m
//  WisdomScenicArea
//
//  Created by chen on 2020/5/26.
//

//有关用户操作的工具

#import "UserUtil.h"
#import "User+CoreDataClass.h"
#import "User+CoreDataProperties.h"
#import "AppDelegate.h"

@interface UserUtil ()

@property (nonatomic, strong, readwrite) NSManagedObjectContext *context;

@end

@implementation UserUtil

- (instancetype)init
{
    self = [super init];
    if (self) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _context = delegate.persistentContainer.viewContext;
    }
    return self;
}

#pragma mark 登入注册判断
//注册时判断当前用户名是否可用
- (BOOL)isUserAvailable:(NSString *)account {
    if (account.length == 0) {
        NSLog(@"请先输入用户名");
        return false;
    }
    NSArray *users = [self queryUser];
    for (User *user in users) {
        if ([user.account isEqualToString:account]) {
            NSLog(@"此用户已存在");
            return true;
        }
    }
    NSLog(@"当前账号可以注册");
    return false;
}

//登入时判断当前用户名是否已经存在
- (BOOL)isUserExisted:(NSString *)account {
    if (account.length == 0) {
        NSLog(@"请先输入用户名");
        return false;
    }
    NSArray *users = [self queryUser];
    for (User *user in users) {
        if ([user.account isEqualToString:account]) {
            NSLog(@"此用户存在");
            return true;
        }
    }
    NSLog(@"用户不存在，无法进行登入");
    return false;
}

//判断账号是否与密码相对应
- (BOOL)isPwdCorrected:(NSString *)account andPwd:(NSString *)password {
    if (password.length == 0) {
        NSLog(@"请先输入密码");
        return false;
    }
    NSArray *users = [self queryUserWithFilter:[NSString stringWithFormat:@"account = %@", account]];
    for (User *user in users) {
        if ([user.password isEqualToString:password]) {
            NSLog(@"账号与密码对应");
            return true;
        }
    }
    NSLog(@"账号或密码错误");
    return false;
}

//判断两次密码是否相同
- (BOOL)isPwdSame:(NSString *)pwd1 andPwdTwo:(NSString *)pwd2 {
    if (pwd1.length == 0 || pwd2.length == 0) {
        NSLog(@"请输入密码");
        return false;
    }
    if ([pwd1 isEqualToString:pwd2]) {
        NSLog(@"两次密码相同");
        return true;
    } else {
        NSLog(@"两次密码不相同");
        return false;
    }
}

#pragma mark 数据库操作
//新建用户
- (BOOL)addUserWithAccount:(NSString *)account AndPwd:(NSString *)pwd {
    NSError *error = nil;

    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:_context];

    user.account = account;
    user.password = pwd;
    user.name = @"游客";
    user.phoneNum = @"";

    [_context save:&error];
    if (error) {
        NSLog(@"%@", error.userInfo);
        return false;
    }
    return true;
}

//查询用户,无过滤条件
- (NSArray *)queryUser {
    NSError *error = nil;

    // NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSFetchRequest *request = [User fetchRequest];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]; //为请求设置排序实例
    request.sortDescriptors = @[descriptor];

    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like '?il?'"];  //设置过滤条件
    //request.predicate = predicate;

    NSArray *array = [_context executeFetchRequest:request error:&error];

    if (error) {
        NSLog(@"%@", error.userInfo);
        return nil;
    }

    return array;
}

//查询用户,有过滤条件
- (NSArray *)queryUserWithFilter:(NSString *)filter {
    NSError *error = nil;

    // NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSFetchRequest *request = [User fetchRequest];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]; //为请求设置排序实例
    request.sortDescriptors = @[descriptor];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:filter];  //设置过滤条件
    request.predicate = predicate;

    NSArray *array = [_context executeFetchRequest:request error:&error];

    if (error) {
        NSLog(@"%@", error.userInfo);
        return nil;
    }

    return array;
}

//删除数据库中的所有数据
- (void)deleteAllUser {
    //1先查询所有数据，在一一进行删除
    NSError *error = nil;

    NSFetchRequest *request = [User fetchRequest];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]; //为请求设置排序实例
    request.sortDescriptors = @[descriptor];

    NSArray *array = [_context executeFetchRequest:request error:&error];

    for (User *user in array) {
        [_context deleteObject:user];
    }
    if (error) {
        NSLog(@"%@", error.userInfo);
    } else {
        NSLog(@"已删除所有User数据");
    }
}

//修改昵称
- (BOOL)modifyName:(NSString *)newName {
    //1 获取当前用户账号
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *account = [userDefaults objectForKey:@"account"];
    //2 查找到用户
    NSArray *users = [self queryUserWithFilter:[NSString stringWithFormat:@"account = %@", account]];
    //3 修改昵称
    for (User *user in users) {
        user.name = newName;
    }
    //4 更新到数据库
    NSError *error = nil;
    [_context save:&error];
    if (error) {
        NSLog(@"%@", error.userInfo);
        return false;
    } else {
        return true;
    }
}

//修改手机号码
- (BOOL)modifyPhone:(NSString *)phone {
    //1 获取当前用户账号
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *account = [userDefaults objectForKey:@"account"];
    //2 查找到用户
    NSArray *users = [self queryUserWithFilter:[NSString stringWithFormat:@"account = %@", account]];
    //3 修改昵称
    for (User *user in users) {
        user.phoneNum = phone;
    }
    //4 更新到数据库
    NSError *error = nil;
    [_context save:&error];
    if (error) {
        NSLog(@"%@", error.userInfo);
        return false;
    } else {
        return true;
    }
}

//修改用户头像
- (BOOL)modifyHeadIcon:(NSString *)imagePath {
    //NSURL *url = [NSURL URLWithString:@""];   //string -> url

    //NSString *headURLString = [url absoluteString];  //url -> string

    //1 获取当前用户账号
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *account = [userDefaults objectForKey:@"account"];
    //2 查找到用户
    NSArray *users = [self queryUserWithFilter:[NSString stringWithFormat:@"account = %@", account]];
    //3 修改头像路径
    for (User *user in users) {
        user.headURL = imagePath;
    }
    //4 更新到数据库
    NSError *error = nil;
    [_context save:&error];
    if (error) {
        NSLog(@"%@", error.userInfo);
        return false;
    } else {
        return true;
    }
}

@end
