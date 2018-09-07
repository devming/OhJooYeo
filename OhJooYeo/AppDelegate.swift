//
//  AppDelegate.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 4. 28..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        DbManager.shared.setup(with: "OhJooYeo")    // OhJooYeo.xcdatamodeld의 이름
        
        App.api.getWorshipIdList { (worshipIdDates) in
            guard var worshipIdDates = worshipIdDates else {
                print("Error")
                return
            }
            worshipIdDates.sort {
                return $0.worshipId > $1.worshipId
            }
            guard let worshipIdDate = worshipIdDates.first else {
                return
            }
            GlobalState.shared.recentWorshipId = worshipIdDate.worshipId
        }
        App.api.getRecentDatas(worshipId: GlobalState.shared.recentWorshipId, version: GlobalState.shared.version) { (worshipData) in
            guard let worshipData = worshipData else {
                return
            }
            WorshipCellData.shared.setWorship(worshipData)
            DbManager.shared.addWorship(mainPresenter: worshipData.mainPresenter, worshipOrder: worshipData.worshipOrders, nextPresenter: worshipData.nextPresenter)
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }

}

