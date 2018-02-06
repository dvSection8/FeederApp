//
//  AppDelegate.swift
//  FeedReader
//
//  Created by Ron Daryl Magno on 2/5/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Build feed vc
        let feedVC = FeedViewController()
        let repository = FeedRepository()

        // Just add in the plist the desired rss urls
        if let urls: [String] = Environment().configuration(PlistKey.urls) {
            repository.urls = urls
        }

        let presenter = FeedPresenter(view: feedVC, repository: repository)
        feedVC.presenter = presenter
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = feedVC
        window?.makeKeyAndVisible()

        return true
    }
}

