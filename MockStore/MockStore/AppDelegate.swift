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
	
		// create tab bar item for AppsVC
		let item = UITabBarItem()
		item.title = "Apps"
		item.image = UIImage(systemName: "square.stack.3d.up.fill")
		
		// instantiate AppsVC and set tabBarItem & navController
		let rootVC = AppsViewController()
		rootVC.tabBarItem = item
		let rootNavVC = UINavigationController(rootViewController: rootVC)
		
		// set up tabBarController
		let tabBarController = UITabBarController()
		tabBarController.viewControllers = [rootNavVC]
		tabBarController.selectedIndex = 0
		
		window?.rootViewController = tabBarController
		window?.makeKeyAndVisible()
		
		return true
	}
		
}
