//
//  FirstTeamDetails.swift
//  NBAlufe
//
//  Created by Alexey Meleshkevich on 16.02.2020.
//  Copyright © 2020 Alexey Meleshkevich. All rights reserved.
//

import Foundation

struct vTeam: Decodable {
    let teamId:   String?
    let shortName:String?
    let fullName: String?
    let nickName: String?
    let logo:     String?
    let score:    score
}
