//
//  matchModel.swift
//  NBAlufe
//
//  Created by Alexey Meleshkevich on 30.01.2020.
//  Copyright © 2020 Alexey Meleshkevich. All rights reserved.
//

import Foundation
import UIKit

struct matchModel {
    let firstTeamName: String
    let firstTeamPoints: Int8
    let firstTeamImage: UIImage
    
    let secondTeamName: String
    let secondTeamPoints: Int8
    let secondTeamImage: UIImage
    
    init(name1: String, name2: String, _ points1: Int8, _ points2: Int8, _ image1: UIImage, _ image2: UIImage) {
        self.firstTeamName = name1
        self.firstTeamImage = image1
        self.firstTeamPoints = points1
        
        self.secondTeamName = name2
        self.secondTeamImage = image2
        self.secondTeamPoints = points2
    }
}
