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
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        rightUrlTask()
//    }                                                  !!!!!!!!!!!!!!!!!!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var matchesView: UITableView!
    
    let networker = NetworkingService(url: URLData(urlKey: CalendarData.stringCurrentDay).url,
                                      header: URLData.httpHeader)
    
    
    // MARK: View lifecycle methods
    
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
        
        print(CalendarData.stringCurrentDay)
        
        
        self.matchesView.delegate = self
        self.matchesView.dataSource = self 
    }
    
    
    
    fileprivate func setUI() {
        setNavBar()
        //        setGetButton(getButton: button)
    }
    
//    func rightUrlTask() {
//        if CalendarData.month < 10 {
//            CalendarData.stringCurrentDay = "\(CalendarData.year)-0\(CalendarData.month)-\(CalendarData.day)"
//        }
//    }
    
    func setNavBar() {
        self.title = "NBA matches"
        self.navigationController?.navigationBar.barTintColor = Constants.blueAppColor
        self.navigationController?.navigationBar.titleTextAttributes = Constants.whiteColor
    }
    
    
    /*func setGetButton() {
     let getButton = UIButton(type: .roundedRect)
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
     } */
    
    
    // MARK:  Binding cell
    
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
    
    // MARK: Set image funcs
    
    public func getImage(url: String) -> Data {
        return self.dataCheck(self.validCheck(url))
    }
    
    public func validCheck(_ url: String) -> URL {
        guard let url = URL(string: url) else { guard let errorUrl = URL(string: Constants.cavsLogoUrl) else { fatalError() }
            return errorUrl
        }
        return url
    }
    
    public func dataCheck(_ url: URL) -> Data {
        guard let imageData = try? Data(contentsOf: url) else { fatalError() }
        return imageData
    }
    
    
    
    
    
    
    
    @IBAction func segmentAction(_ sender: Any) {
    }
    
    @objc func getButtonPressed() {
        //            networker.requestData()
    }
}



