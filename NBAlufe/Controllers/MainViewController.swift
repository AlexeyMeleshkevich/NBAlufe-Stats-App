//
//  ViewController.swift
//  NBAlufe
//
//  Created by Alexey Meleshkevich on 30.01.2020.
//  Copyright © 2020 Alexey Meleshkevich. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class MainViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var matchesView: UITableView!
    
    let button = UIButton(type: .roundedRect)
    
    let networker = NetworkingService()
    
    let url = "https://api-basketball.p.rapidapi.com/games"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setGetButton(getButton: button)
        }
    
    
    func setNavBar() {
        self.title = "NBA matches"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 20.0 / 255.0, green: 78.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func setGetButton(getButton: UIButton) {
        let height = 30
               
               getButton.layer.cornerRadius = CGFloat(height / 2)
               getButton.setTitle("Get json", for: .normal)
               getButton.setTitleColor(.white, for: .normal)
               getButton.backgroundColor = UIColor(red: 20.0 / 255.0, green: 78.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
               
               //taskButton.sizeToFit()
               view.addSubview(getButton)
               
               getButton.translatesAutoresizingMaskIntoConstraints = false
               
               NSLayoutConstraint.activate([
                   getButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 240),
                   getButton.heightAnchor.constraint(equalToConstant: CGFloat(height)),
                   getButton.widthAnchor.constraint(equalToConstant: 140),
                   getButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
               ])
        getButton.addTarget(self, action: #selector(getButtonPressed), for: .touchUpInside)
    }
    
    @IBAction func segmentAction(_ sender: Any) {
    }
    
    @objc func getButtonPressed() {
        networker.request(url: url)
    }
}



