//
//  AppDelegate.swift
//  LoblawsProject
//
//  Created by Bill Zhao on 2021-02-07.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard
        let splitViewController = window?.rootViewController as? LPSplitViewController,
        let leftNavController = splitViewController.viewControllers.first as? UINavigationController,
        let masterViewController = leftNavController.viewControllers.first as? LPCartListTableViewController,
        let detailViewController = splitViewController.viewControllers.last as? LPCartItemDetailViewController
        else { fatalError() }

      masterViewController.delegate = detailViewController
      return true
    }
}

