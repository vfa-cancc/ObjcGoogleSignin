//
//  AppDelegate.m
//  ObjcGoogleSignin
//
//  Created by Can on 2/24/21.
//  Copyright © 2021 Can. All rights reserved.
//

#import "AppDelegate.h"
#import <NCMB/NCMB.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NCMB setApplicationKey:@"" clientKey:@""];

    [FIRApp configure];

//    [GIDSignIn sharedInstance].clientID = @"YOUR_CLIENT_ID";
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].clientID = [FIRApp defaultApp].options.clientID;
    
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [[GIDSignIn sharedInstance] handleURL:url];
}


- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    if (error == nil) {
        GIDAuthentication *authentication = user.authentication;

        NSDictionary *googleInfo = @{@"id":authentication.idToken,
                                     @"access_token":authentication.accessToken};

        //会員のインスタンスを作成
        NCMBUser *mbUser = [NCMBUser user];

        //Googleの認証情報を利用して会員登録を行う
        [mbUser signUpWithGoogleToken:googleInfo withBlock:^(NSError *error) {
            if (error){
                //mobile backendの会員登録に失敗した場合の処理
            } else {
                //会員登録に成功した場合の処理
            }
        }];
        
    } else {
        //Googleへのログインに失敗した場合の処理
    }
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error {
  // Perform any operations when the user disconnects from app here.
}


@end

