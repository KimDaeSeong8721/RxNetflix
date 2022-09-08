//
//  TabBarViewController.swift
//  RxNetflix
//
//  Created by DaeSeong on 2022/09/05.
//

import UIKit

class TabBarViewController: UITabBarController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
    }
    
    // MARK: - Func
    private func configureTabBar() {
        
        var homeVC = HomeViewController()
        homeVC.bindViewModel(HomeViewModel())
//        let upcomingVC = UpcomingViewController()
//        upcomingVC.bindViewModel(UpcomingViewModel())
//        let searchVC = SearchViewController()
//        homvVC.bindViewModel(SearchViewModel())
//        let downloadsVC = DownloadsViewController()
//        downloadsVC.bindViewModel(DownloadsViewModel())
        
        let vc1 =  UINavigationController(rootViewController: homeVC)
        let vc2 =  UINavigationController(rootViewController: UpcomingViewController())
        let vc3 =  UINavigationController(rootViewController: SearchViewController())
        let vc4 =  UINavigationController(rootViewController: DownloadsViewController())
        
        
        vc1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: nil)
        vc2.tabBarItem = UITabBarItem(title: "Coming Soon", image: UIImage(systemName: "play.circle"), selectedImage: nil)
        vc3.tabBarItem = UITabBarItem(title: "Top Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
        vc4.tabBarItem = UITabBarItem(title: "Coming Soon", image: UIImage(systemName: "arrow.down.to.line"), selectedImage: nil)
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1,vc2,vc3,vc4], animated: true)
    }



}
