//
//  matchModel.swift
//  NBAlufe
//
//  Created by Alexey Meleshkevich on 30.01.2020.
//  Copyright © 2020 Alexey Meleshkevich. All rights reserved.
//

import Foundation
import UIKit

struct MatchModel: Decodable {
    
    let firstTeamName: String?
    let firstTeamPoints: Int?
    let firstTeamImageUrl: String?
    
    let secondTeamName: String?
    let secondTeamPoints: Int?
    let secondTeamImageUrl: String?
    
}
