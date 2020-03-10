//
//  Constraints.swift
//  NBAlufe
//
//  Created by Alexey Meleshkevich on 09.03.2020.
//  Copyright © 2020 Alexey Meleshkevich. All rights reserved.
//

import Foundation
import UIKit

extension MainViewController {
    
    func setActivityIndicatorConstraints(_ activityIndicator: UIActivityIndicatorView) {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.matchesView.centerXAnchor, constant: 0),
            activityIndicator.centerYAnchor.constraint(equalTo: self.matchesView.centerYAnchor, constant: 0)
        ])
    }
    
    func setToolbarConstraints(_ toolbar: UIToolbar) {
        
        self.toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toolbar.height(50),
            toolbar.leftToSuperview(),
            toolbar.rightToSuperview(),
            toolbar.bottomToTop(of: self.pickerView)
        ])
    }
    
    func setPickerViewConstraints(_ pickerView: UIDatePicker) {
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant:0),
            pickerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            pickerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            pickerView.heightAnchor.constraint(equalToConstant: 200)])
    }
    
    func setSegmentedControlConstraints(_ segmentedControl: UISegmentedControl) {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            segmentedControl.leftToSuperview(),
            segmentedControl.rightToSuperview()
        ])
    }
    
    func setTableViewConstraints(_ matchesView: UITableView) {
        matchesView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            matchesView.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 0),
            matchesView.height(650),
            matchesView.leftToSuperview(),
            matchesView.rightToSuperview()
        ])
    }
    
    func setPickerConstraints(_ picker: UIDatePicker) {
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        picker.centerInSuperview()
    }
}
