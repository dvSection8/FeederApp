//
//  AppDelegate.swift
//  FeedReader
//
//  Created by Ron Daryl Magno on 2/5/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import UIKit
import CoreData
import SwiftSoup

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Build feed vc
        let feedVC = FeedViewController()
        let repository = FeedRepository()
        let presenter = FeedPresenter(view: feedVC, repository: repository)
        
        feedVC.presenter = presenter
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = feedVC
        window?.makeKeyAndVisible()
        
        let html = "<div style=\"float:left;\"><a class=\"url\" href=\"https://www.amazon.co.uk/Close-Home-impossible-Richard-thriller-ebook/dp/B071Z3Z1KN/ref=pd_zg_rss_ts_b_72_1\"><img src=\"https://images-eu.ssl-images-amazon.com/images/I/61EHKtSVIDL._SL160_.jpg\" alt=\"Close to Home\" border=\"0\" hspace=\"0\" vspace=\"0\" /></a></div><span class=\"riRssTitle\"><a href=\"https://www.amazon.co.uk/Close-Home-impossible-Richard-thriller-ebook/dp/B071Z3Z1KN/ref=pd_zg_rss_ts_b_72_1\">Close to Home: The \'impossible to put down\' Richard & Judy Book Club thriller pick 2018 (DI Fawley)</a></span> <br /><span class=\"riRssContributor\">                                               <a href=\"https://www.amazon.co.uk/Cara-Hunter/e/B077YKNJGN/ref=ntt_athr_dp_pel_1\">Cara Hunter</a> <span class=\"byLinePipe\">(Author)</span></span> <br /> <img src=\"https://images-eu.ssl-images-amazon.com/images/G/02/detail/stars-4-5._CB192253866_.gif\" width=\"64\" height=\"12\" border=\"0\" style=\"margin: 0; padding: 0;\"/>(424)<br /><br /><a href=\"https://www.amazon.co.uk/Close-Home-impossible-Richard-thriller-ebook/dp/B071Z3Z1KN/ref=pd_zg_rss_ts_b_72_1\">Buy new: </a>  <font color=\"#990000\"><b>£0.99</b></font> <br /><br />(Visit the <a href=\"https://www.amazon.co.uk/Best-Sellers-Books-Crime-Thrillers-Mystery/zgbs/books/72/ref=pd_zg_rss_ts_b_72_1\">Bestsellers in Crime, Thrillers & Mystery</a> list for authoritative information on this product\'s current rank.)"
        let html2 = """
        <div style="float:left;"><a class="url" href="https://www.amazon.co.uk/Silent-Victim-Caroline-Mitchell-ebook/dp/B071G5W8HC/ref=pd_zg_rss_ts_b_72_2"><img src="https://images-eu.ssl-images-amazon.com/images/I/41%2BewdMevrL._SL160_.jpg" alt="Silent Victim" border="0" hspace="0" vspace="0" /></a></div><span class="riRssTitle"><a href="https://www.amazon.co.uk/Silent-Victim-Caroline-Mitchell-ebook/dp/B071G5W8HC/ref=pd_zg_rss_ts_b_72_2">Silent Victim</a></span> <br /><span class="riRssContributor"><a href="https://www.amazon.co.uk/Caroline-Mitchell/e/B00GUUATPU/ref=ntt_athr_dp_pel_1">Caroline Mitchell</a> <span class="byLinePipe">(Author)</span></span> <br /> <img src="https://images-eu.ssl-images-amazon.com/images/G/02/detail/stars-4-5._CB192253866_.gif" width="64" height="12" border="0" style="margin: 0; padding: 0;"/>(24)<br /><br /><a href="https://www.amazon.co.uk/Silent-Victim-Caroline-Mitchell-ebook/dp/B071G5W8HC/ref=pd_zg_rss_ts_b_72_2">Buy new: </a> <font color="#990000"><b>£3.99</b></font> <br /><br />(Visit the <a href="https://www.amazon.co.uk/Best-Sellers-Books-Crime-Thrillers-Mystery/zgbs/books/72/ref=pd_zg_rss_ts_b_72_2">Bestsellers in Crime, Thrillers & Mystery</a> list for authoritative information on this product's current rank.)
        """
        
        let document = try! SwiftSoup.parseBodyFragment(html2)
        
        return true
    }
}

