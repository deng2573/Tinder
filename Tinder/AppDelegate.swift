//
//  AppDelegate.swift
//  Tinder
//
//  Created by Deng on 2019/7/29.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .white
    window?.makeKeyAndVisible()
    WebServer.shared.start()
    setupJPush(launchOptions: launchOptions)
    setupMainViewController()
    return true
  }
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    //注册 DeviceToken
    JPUSHService.registerDeviceToken(deviceToken)
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    JPUSHService.resetBadge()
    application.applicationIconBadgeNumber = 0
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    JPUSHService.handleRemoteNotification(userInfo)
    completionHandler(UIBackgroundFetchResult.newData)
  }
}

extension AppDelegate {
  private func setupMainViewController() {
    if VestManager.showVest() {
      window?.rootViewController = VestViewController()
    } else {
      window?.rootViewController = TabBarController()
    }
  }
  
  func setupJPush(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
    JPUSHService.setup(withOption: launchOptions, appKey: AppKey.JPushAPP.key, channel: "App Store", apsForProduction: !AppConfig.isDebug)
    let entity = JPUSHRegisterEntity()
    entity.types = 1 << 0 | 1 << 1 | 1 << 2
    JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
  }
}

extension AppDelegate: JPUSHRegisterDelegate {
  @available(iOS 10.0, *)
  func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) {
    
  }
  
  @available(iOS 10.0, *)
  func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
    let userInfo = notification.request.content.userInfo
    if notification.request.trigger is UNPushNotificationTrigger {
      JPUSHService.handleRemoteNotification(userInfo)
    }else {
      //本地通知
    }
    print("=======\(userInfo)")
  
    completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
  }
  
  @available(iOS 10.0, *)
  func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
    let userInfo = response.notification.request.content.userInfo
    if response.notification.request.trigger is UNPushNotificationTrigger {
      JPUSHService.handleRemoteNotification(userInfo)
    }else {
      //本地通知
    }
    //处理通知 跳到指定界面等等
    print("=======\(userInfo)")
    completionHandler()
  }
}
