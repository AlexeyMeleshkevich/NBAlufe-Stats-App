//
//  ViewController.swift
//  NBAlufe
//
//  Created by Alexey Meleshkevich on 30.01.2020.
//  Copyright © 2020 Alexey Meleshkevich. All rights reserved.
//

import UIKit
import Foundation
import TinyConstraints

class MainViewController: UIViewController {
    
    // MARK: UI components
    
    @IBOutlet weak var segmentedControl: UISegmentedControl! // Constraints: left right top(navBar)
    @IBOutlet weak var matchesView: UITableView!             // Constraints: left right top(segmentedControl)
    
    private let activityIndicator = UIActivityIndicatorView() // Constraints: center(matchesView(Y X))
    private let pickerView = UIView()                         // OK
    private let toolbar = UIToolbar()                         // OK
    private let picker = UIDatePicker()                       // OK
    private var searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonAction)) // No
    
    // MARK: Date for set UI
    
    let months = ["January",
                  "February",
                  "March",
                  "April",
                  "May",
                  "June",
                  "July",
                  "August",
                  "September",
                  "October",
                  "November",
                  "December"]
    
    
    let currentMonth = CalendarData.month
    
    let networker = NetworkingService(url: URLData(urlKey: CalendarData.stringCurrentDay).url,
                                      header: URLData.httpHeader)
    
    
    // MARK: View lifecycle methods
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.matchesView.delegate = self
        self.matchesView.dataSource = self
        
        networker.requestData(tableView: self.matchesView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("View will appear")
        //        setUI(matchesView)
        setNavBar()
        setPicker()
        setHeaderView(tableView: self.matchesView)
        
        setActivityIndicator()
        startActivityInticator()
    }
    
    
    // MARK: Main set UI func
    
    fileprivate func setUI(_ tableView: UITableView) {
        
    }
    
    // MARK: Secondary UI funcs
    // MatchesView Header
    fileprivate func setHeaderView(tableView: UITableView) {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.width), height: 36))
        header.backgroundColor = UIColor.white
        let label = UILabel(frame: header.bounds)
        label.text = "\(self.months[self.currentMonth - 1]), \(CalendarData.day)"
        label.textAlignment = .center
        label.textColor = UIColor.lightGray
        header.addSubview(label)
        
        tableView.tableHeaderView = header
    }
    // MatchesView Constraints
    private func setTableViewConstraints() {
        self.matchesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.matchesView.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 0),
            self.matchesView.leftToSuperview(),
            self.matchesView.rightToSuperview()
        ])
    }
    // SegmentedControl
    private func setSegmentedControl() {
        self.segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.segmentedControl.topAnchor.constraint(equalTo: (self.navigationController?.navigationBar.bottomAnchor)!, constant: 0),
            self.segmentedControl.leftToSuperview(),
            self.segmentedControl.rightToSuperview()
        ])
    }
    // SearchBar
    private func setSearchBarButton() {
        self.navigationController?.navigationItem.rightBarButtonItem = self.searchButton
    }
    // Date Picker
    private func setPicker() {
        let margins = self.view.layoutMarginsGuide
        
        view.addSubview(self.pickerView)
        view.addSubview(self.toolbar)
        
        pickerView.isHidden = true
        toolbar.isHidden = true
        pickerView.backgroundColor = .white
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([pickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
                                     pickerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
                                     pickerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
                                     pickerView.heightAnchor.constraint(equalToConstant: 200)])
        
        picker.datePickerMode = .time
        picker.setDate(Date(), animated: true)
        
        toolbar.barStyle = .black
        toolbar.barTintColor = .blue
        toolbar.tintColor = .white
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toolbar.heightAnchor.constraint(equalToConstant: 50),
            toolbar.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 0),
            toolbar.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 0),
            toolbar.bottomAnchor.constraint(equalTo: self.pickerView.bottomAnchor, constant: 0)
        ])
        
        self.embedButtons(toolbar)
    }
    // Toolbar buttons
    private func embedButtons(_ toolbar: UIToolbar) {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.setItems([flexButton, doneButton], animated: true)
    }
    // Navigation Bar
    private func setNavBar() {
        self.title = "Matches"
        self.navigationController?.navigationBar.barTintColor = Constants.blueAppColor
        self.navigationController?.navigationBar.titleTextAttributes = Constants.whiteColor
    }
    // Activity Indicator
    private func setActivityIndicator() {
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.isHidden = true
        
        self.view.addSubview(self.activityIndicator)
        
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.matchesView.centerXAnchor, constant: 0),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.matchesView.centerYAnchor, constant: 0)
        ])
    }
    
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
                self.stopActivityIndicator()
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
        guard let imageData = try? Data(contentsOf: url) else {
            guard let fakeImage = try? Data(contentsOf: Constants.pistonsLogoUrl!) else {
                fatalError() }
            return fakeImage }
        return imageData
    }
    
    // MARK: Actions funcs
    
    private func startActivityInticator() {
        self.activityIndicator.isHidden = false
        self.view.isUserInteractionEnabled = false
        self.matchesView.isHidden = true
        self.activityIndicator.startAnimating()
    }
    
    private func stopActivityIndicator() {
        self.view.isUserInteractionEnabled = true
        self.activityIndicator.stopAnimating()
        self.matchesView.isHidden = false
    }
    
    @objc private func searchButtonAction(_ sender: Any) {
        //        let alert = UIAlertController(title: "Search match", message: "Enter game date in field below", preferredStyle: .actionSheet)
        //
        //        let okayAction = UIAlertAction(title: "Ok", style: .default) { (okayAction) in
        //            //            if alert.textFields![0].text?.isEmpty == true {
        //            //
        //            //            }
        //        }
        //        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //        //        alert.addTextField { (dateTF) in
        //        //            dateTF.placeholder = "YYYY-MM-DD"
        //        //        }
        //
        //
        //        alert.addAction(okayAction)
        //        alert.addAction(cancelAction)
        //        self.present(alert, animated: true, completion: nil)
        
        self.pickerView.isHidden = false
        self.toolbar.isHidden = false
    }
    
    @objc private func donePressed() {
        self.pickerView.isHidden = true
        self.toolbar.isHidden = true
    }
    
    @IBAction func segmentAction(_ sender: Any) {
        
    }
}





