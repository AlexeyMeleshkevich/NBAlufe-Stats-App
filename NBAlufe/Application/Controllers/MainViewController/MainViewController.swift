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
    
    
    let matchesView = UITableView()
    let segmentedControl = UISegmentedControl(items: Constants.segmentItems)
    let activityIndicator = UIActivityIndicatorView()
    let pickerView = UIView()
    let toolbar = UIToolbar()
    let picker = UIDatePicker()
    let searchButton = UIBarButtonItem(barButtonSystemItem: .search,
                                       target: self,
                                       action: #selector(searchButtonAction))
    
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
        print(CalendarData.stringCurrentDay)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI(tableView:   matchesView,
        segmentedControl:  segmentedControl,
        picker:            picker,
        activityIndicator: activityIndicator,
        toolbar:           toolbar)
        print("223")
        networker.requestData(tableView: self.matchesView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    
    // MARK: Main set UI func
    
    func addSubview(_ sender: UIView) {
        self.view.addSubview(sender)
    }
    
    fileprivate func setUI(tableView: UITableView,
                           segmentedControl: UISegmentedControl,
                           picker: UIDatePicker,
                           activityIndicator: UIActivityIndicatorView,
                           toolbar: UIToolbar) {
        
        setNavigationBar()
        setSegmentedControl(segment: segmentedControl)
        setTableView(tableView: tableView)
        setHeaderView(tableView: tableView)
        setActivityIndicator(activity: activityIndicator)
        setPicker(picker: picker)
        setToolbar(toolbar: toolbar)
    }
    
    // MARK: Secondary UI funcs
    
    // Navigation Bar
    private func setNavigationBar() {
        self.title = "Matches"
        self.navigationController?.navigationBar.barTintColor = Constants.blueAppColor
        self.navigationController?.navigationBar.titleTextAttributes = Constants.whiteColor
    }
    // MatchesView
    private func setTableView(tableView: UITableView) {
        self.matchesView.delegate = self
        self.matchesView.dataSource = self
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: Constants.matchCellID)
        
        addSubview(tableView)
        setTableViewConstraints(tableView)
    }
    // MatchesView Header
    private func setHeaderView(tableView: UITableView) {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.width), height: 36))
        header.backgroundColor = UIColor.white
        let label = UILabel(frame: header.bounds)
        label.text = "\(self.months[self.currentMonth - 1]), \(CalendarData.day)"
        label.textAlignment = .center
        label.textColor = UIColor.lightGray
        header.addSubview(label)
        
        tableView.tableHeaderView = header
    }
    // SegmentedControl
    private func setSegmentedControl(segment: UISegmentedControl) {
        addSubview(segment)
        setSegmentedControlConstraints(segment)
    }
    // SearchButton
    private func setSearchBarButton() {
        self.navigationController?.navigationItem.rightBarButtonItem = self.searchButton
    }
    // Date Picker
    private func setPicker(picker: UIDatePicker) {
        addSubview(picker)
        setPickerViewConstraints(picker)
        
        pickerView.isHidden = true
        pickerView.backgroundColor = .white
        
        picker.datePickerMode = .time
        picker.setDate(Date(), animated: true)
    }
    // Toolbar
    private func setToolbar(toolbar: UIToolbar) {
        toolbar.isHidden = true
        toolbar.barStyle = .black
        toolbar.barTintColor = .blue
        toolbar.tintColor = .white
        
        embedButtons(toolbar)
        
        addSubview(toolbar)
        setToolbarConstraints(toolbar)
    }
    
    private func embedButtons(_ toolbar: UIToolbar) {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.setItems([flexButton, doneButton], animated: true)
    }
    // Activity Indicator
    private func setActivityIndicator(activity: UIActivityIndicatorView) {
        activity.hidesWhenStopped = true
        activity.isHidden = true
        
        addSubview(activity)
        setActivityIndicatorConstraints(activity)
        startActivityIndicator()
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
    
    private func startActivityIndicator() {
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





