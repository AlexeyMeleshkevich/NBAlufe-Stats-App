//
//  MainViewControllerExtension.swift
//  NBAlufe
//
//  Created by Alexey Meleshkevich on 30.01.2020.
//  Copyright © 2020 Alexey Meleshkevich. All rights reserved.
//

import UIKit


extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.networker.matches.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.matchesView.dequeueReusableCell(withIdentifier: Constants.matchCellID, for: indexPath) as! CustomTableViewCell
        
        bindData(cell: cell, for: indexPath)
        
        return cell
    }
}
