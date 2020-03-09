//
//  TabBarController.swift
//  NBAlufe
//
//  Created by Alexey Meleshkevich on 03.03.2020.
//  Copyright © 2020 Alexey Meleshkevich. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        setTabBar()
    }
    
    func setTabBar() {
        let mainVC = UINavigationController(rootViewController: MainViewController())
        let matchReviewVC = UINavigationController(rootViewController: MatchReviewController())
        
        mainVC.tabBarItem.image = .actions
        matchReviewVC.tabBarItem.image = .checkmark
        
        tabBar.barTintColor = UIColor(red: 20.0 / 255.0, green: 78.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        
        mainVC.navigationBar.barTintColor = UIColor(red: 20.0 / 255.0, green: 78.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
        mainVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        matchReviewVC.navigationBar.barTintColor = UIColor(red: 20.0 / 255.0, green: 78.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
        matchReviewVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        matchReviewVC.tabBarItem.title = "Results list"
        
        
        viewControllers = [mainVC, matchReviewVC]
    }
    
}
