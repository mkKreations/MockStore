//
//  AppDelegate.swift
//  MockStore
//
//  Created by Marcus on 1/19/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// instantiate window
		window = UIWindow(frame: UIScreen.main.bounds)
		
		// rootVC & navVC setup
		let rootVC = AppsViewController()
		let navVC = UINavigationController(rootViewController: rootVC)
		
		window?.rootViewController = navVC
		window?.makeKeyAndVisible()
		
		return true
	}

}
