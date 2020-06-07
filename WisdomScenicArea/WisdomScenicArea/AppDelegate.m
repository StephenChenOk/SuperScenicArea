//
//  AppDelegate.m
//  SmartScenicArea
//
//  Created by chen on 2020/5/19.
//  Copyright © 2020 chen. All rights reserved.
//

#import "AppDelegate.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // 创建底部导航栏
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    //tabBarController.navigationItem.title = @"测试";
    //tabBarController.navigationItem.

    //创建三个子视图
    //1.主页
    HomeViewController *homeViewController = [[HomeViewController alloc] init];

    //2.目的地
    LocationViewController *locationViewController = [[LocationViewController alloc] init];

    //3.我的
    MineViewController *mineViewController = [[MineViewController alloc] init];

    [tabBarController setViewControllers:@[homeViewController, locationViewController, mineViewController]];

    //创建跳转view
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:tabBarController];
    
    //将tabBarController设置为主的ControllerView
    self.window.rootViewController = navigation;
    //显示
    [self.window makeKeyAndVisible];

    [AMapServices sharedServices].enableHTTPS = YES;
    
    //初始化高德地图api
    [AMapServices sharedServices].apiKey = @"92c3b6c6ee318db2091c24998c5379e9";
    
    //避免键盘遮挡
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;  //点击背景，键盘收回
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemImage = [UIImage imageNamed:@"IQKeyboardImage"];
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 10.0f;    

    
    return YES;
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"WisdomScenicArea"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }

    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
