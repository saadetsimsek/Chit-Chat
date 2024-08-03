//
//  TabBarViewController.swift
//  ChitChat
//
//  Created by Saadet Şimşek on 03/08/2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let chatList: UIViewController
    
    init(chatList: UIViewController) {
        self.chatList = chatList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
    }
    

    private func setupViewController(){
        
        let settings = SettingsViewController()
        let nav1 = UINavigationController(rootViewController: chatList)
        let nav2 = UINavigationController(rootViewController: settings)
        
        nav1.tabBarItem = UITabBarItem(title: "Chat",
                                       image: UIImage(systemName: "message"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Settings",
                                       image: UIImage(systemName: "gear"),
                                       tag: 2)
        
        setViewControllers([nav1, nav2], animated: true)
    }


}
