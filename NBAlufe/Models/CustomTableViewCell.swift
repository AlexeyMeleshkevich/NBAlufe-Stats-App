//
//  CustomTableViewCell.swift
//  NBAlufe
//
//  Created by Alexey Meleshkevich on 30.01.2020.
//  Copyright © 2020 Alexey Meleshkevich. All rights reserved.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var firstTeamImage: UIImageView!
    @IBOutlet var secondTeamImage: UIImageView!
    
    @IBOutlet weak var firstTeamTitle: UILabel!
    @IBOutlet weak var secondTeamTitle: UILabel!
    
    @IBOutlet weak var vsLabel: UILabel!
    
    @IBOutlet weak var firstTeamPoints: UILabel!
    @IBOutlet weak var secondTeamPoints: UILabel!
    
    @IBOutlet weak var hyphenLabel: UILabel!
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
