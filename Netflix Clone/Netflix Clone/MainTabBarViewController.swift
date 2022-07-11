//
//  ViewController.swift
//  Netflix Clone
//
//  Created by eunji on 2022/07/11.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        let vc1 = UINavigationController(rootViewController: HomeViewController()) // home
        let vc2 = UINavigationController(rootViewController: UpcomingViewController()) //comingsoon
        let vc3 = UINavigationController(rootViewController: SearchViewController()) // top searches
        let vc4 = UINavigationController(rootViewController: DownloadsViewController()) //downloads
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        vc1.title = "Home"
        vc2.title = "Coming Soon"
        vc3.title = "Top Searches"
        vc4.title = "Downloads"
        
        tabBar.tintColor = .label
        /* .label: Mode에 따라 Text 색상 변경
         NormalMode: Black으로
         DarkMode: White로
         */
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }


}

