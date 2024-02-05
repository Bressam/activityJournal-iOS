//
//  AppDelegate.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 04/02/24.
//

import Foundation
import UIKit
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
