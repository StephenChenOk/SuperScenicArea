//
//  AppDelegate.h
//  SmartScenicArea
//
//  Created by chen on 2020/5/19.
//  Copyright © 2020 chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "LocationViewController.h"
#import "MineViewController.h"
#import "UIColor+TransformColor.h"
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

@end
