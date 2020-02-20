//
//  ViewController.swift
//  NBAlufe
//
//  Created by Alexey Meleshkevich on 30.01.2020.
//  Copyright © 2020 Alexey Meleshkevich. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UIViewController {
    
    //    internal let matches = [GameModel]()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var matchesView: UITableView!
    
    let button = UIButton(type: .roundedRect)
    
    let networker = NetworkingService(url: URLData(urlKey: "2020-02-14").url,
                                      headers: URLData.urlHeaders)
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        networker.requestData(tableView: self.matchesView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        self.matchesView.delegate = self
        self.matchesView.dataSource = self
    }
    
    
    
    fileprivate func setUI() {
        setNavBar()
        //        setGetButton(getButton: button)
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
    
    public func bindData(cell: CustomTableViewCell, for indexPath: IndexPath) {
        let match = networker.matches[indexPath.row]
        
        
        if let fullName1 = match.hTeam.fullName, let fullName2 = match.vTeam.fullName {
            cell.firstTeamTitle.text = fullName1
            cell.secondTeamTitle.text = fullName2
        }
        
        DispatchQueue.global().async {
            let dataFirstImage = self.getImage(url: match.hTeam.logo!)
            let dataSecondImage = self.getImage(url: match.vTeam.logo!)
            DispatchQueue.main.async {
                cell.firstTeamImage.image = UIImage(data: dataFirstImage)
                cell.secondTeamImage.image = UIImage(data: dataSecondImage)
            }
        }
        
        cell.firstTeamPoints.text = match.hTeam.score.points
        cell.secondTeamPoints.text = match.vTeam.score.points
    }
    
    public func getImage(url: String) -> Data {
        return self.dataCheck(self.validCheck(url))
    }
    
    public func validCheck(_ url: String) -> URL {
        guard let url = URL(string: url) else { fatalError() }
        return url
    }
    
    public func dataCheck(_ url: URL) -> Data {
        guard let imageData = try? Data(contentsOf: url) else { fatalError() }
        return imageData
    }
    
    @IBAction func segmentAction(_ sender: Any) {
    }
    
    @objc func getButtonPressed() {
        //        networker.requestData()
    }
}



