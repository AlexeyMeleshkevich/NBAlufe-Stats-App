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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = matchesView.dequeueReusableCell(withIdentifier: "C§", for: indexPath) as! CustomTableViewCell
        
        cell.firstTeamImage = UIImageView(image: UIImage(systemName: "appicon_okc"))
        cell.secondTeamImage = UIImageView(image: UIImage(systemName: "appicon_min"))
        cell.firstTeamTitle.text = "Minnesota Timberwolves"
        cell.secondTeamTitle.text = "Okclahoma City Thunder"
        cell.secondTeamPoints.text = "132"
        cell.firstTeamPoints.text = "228"
        
        return cell
    }
    
    
    
}
