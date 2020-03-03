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

class LaunchScreenViewController: UIViewController {
    
    let mainVC = MainNavigationController()
    
    private lazy var gifView: GIFImageView = {
        let view = GIFImageView()
        
        view.contentMode = .scaleAspectFit
        view.animate(withGIFNamed: "tenor.gif")
        view.startAnimatingGIF()

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.addSubview(gifView)
        
        setGifViewConstraints(sender: gifView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.navigationController?.pushViewController(self.mainVC, animated: true)
        }
    }
    
    private func setGifViewConstraints(sender: GIFImageView) {
        sender.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sender.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            sender.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0),
            sender.widthAnchor.constraint(equalToConstant: 260),
            sender.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
