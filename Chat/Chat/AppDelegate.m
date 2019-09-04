//
//  AppDelegate.m
//  Chat
//
//  Created by 李世飞 on 2018/6/7.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "AppDelegate.h"
#import "TestModel.h"

#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    NSMutableArray * array =[[NSMutableArray alloc] initWithObjects:@{@"id":@"1",@"num":@"1"},@{@"id":@"2",@"num":@"2"},@{@"id":@"1",@"num":@"3"},@{@"id":@"3",@"num":@"1"},@{@"id":@"3",@"num":@"1"},@{@"id":@"4",@"num":@"1"},@{@"id":@"5",@"num":@"1"},@{@"id":@"2",@"num":@"1"},@{@"id":@"2",@"num":@"1"},@{@"id":@"2",@"num":@"1"},@{@"id":@"2",@"num":@"1"},@{@"id":@"2",@"num":@"1"},@{@"id":@"2",@"num":@"1"},@{@"id":@"2",@"num":@"1"},@{@"id":@"6",@"num":@"1"}, nil];
    
    
    NSMutableArray * dataArray =[[NSMutableArray alloc] init];
    
    for(NSDictionary * dic in array){
        
        TestModel * model =[[TestModel alloc] init];
        model.dishId=dic[@"id"];
        model.num=[dic[@"num"] integerValue];
        [dataArray addObject:model];
    }
    
    NSLog(@"start");
    
    NSMutableArray * tempArray =[[NSMutableArray alloc] init];
    
    for(NSInteger i=0;i<dataArray.count;i++){
        
        TestModel * i_model = dataArray[i];
        
        [tempArray addObject:i_model];
        
        for(NSInteger j=i+1;j<dataArray.count;j++){
            
            TestModel * j_model = dataArray[j];

            if([i_model.dishId isEqualToString:j_model.dishId]){
                
                i_model.num+=j_model.num;
                
                [tempArray replaceObjectAtIndex:i withObject:i_model];
                
                [dataArray removeObject:j_model];
                
                j-=1;
            }
            
        }
        
    }
    
    
    NSLog(@"-----%zi",tempArray.count);
    
    
    for(TestModel * model in tempArray){
        
        
        NSLog(@" id=%@ num=%zi",model.dishId,model.num);
    }
    
    
    NSLog(@"end");

    
    ViewController * kddChatTollbar =[[ViewController alloc] init];
    UINavigationController * navi =[[UINavigationController alloc] initWithRootViewController:kddChatTollbar];
    self.window.rootViewController=navi;
    

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
