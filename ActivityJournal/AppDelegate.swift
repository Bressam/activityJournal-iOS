//
//  AppDelegate.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 04/02/24.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    // MARK: Properties needed for initializaation
    var analyticsService: AnalyticsService?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        analyticsService?.setup()
        return true
    }
}
