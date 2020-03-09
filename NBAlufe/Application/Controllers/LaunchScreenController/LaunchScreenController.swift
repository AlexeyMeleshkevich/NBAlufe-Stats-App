//
//  LaunchScreenController.swift
//  NBAlufe
//
//  Created by Alexey Meleshkevich on 03.03.2020.
//  Copyright © 2020 Alexey Meleshkevich. All rights reserved.
//

import Foundation
import UIKit
import Gifu
import TinyConstraints

class LaunchScreenViewController: UIViewController {
    
    // MARK: UI components
    private let launchScreenGifView = GIFImageView()
    private let launchScreenLabel = UILabel()
    private let tabBar = TabBarController()
    
    // MARK: View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setUI(launchLabel: launchScreenLabel, launchGif: launchScreenGifView)
        
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                    let mainVC = MainViewController()
                    self.navigationController?.pushViewController(self.tabBar, animated: true)
                }
    }
    
    // MARK: Set UI methods
    
    fileprivate func setUI(launchLabel: UILabel, launchGif: GIFImageView) {
        setLabelstyle(label: launchLabel)
        setGifStyle(sender: launchGif)
    }
    
    // launch label
    
    fileprivate func setLabelstyle(label: UILabel) {
//        let frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 50)
//        label.frame = frame
        label.text = """
                        Copyright © 2020 Alexey Meleshkevich.
                        All rights reserved.
                     """
        label.numberOfLines = 2
        label.textAlignment = .center
        
        self.view.addSubview(label)
        setLabelConstraints(label: label)
    }
    
    fileprivate func setLabelConstraints(label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leftToSuperview(),
            label.rightToSuperview(),
            label.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30)
        ])
        
    }
    
    // lebron james gif
    
    fileprivate func setGifStyle(sender: GIFImageView) {
        sender.contentMode = .scaleAspectFit
        sender.animate(withGIFNamed: "james.gif")
        sender.startAnimatingGIF()
        self.view.addSubview(sender)
        setGifViewConstraints(sender: sender)
    }
    
    fileprivate func setGifViewConstraints(sender: GIFImageView) {
        sender.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sender.leftToSuperview(),
            sender.rightToSuperview(),
            sender.centerXToSuperview(),
            sender.centerYToSuperview(),
            sender.widthAnchor.constraint(equalToConstant: 260),
            sender.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    
}
