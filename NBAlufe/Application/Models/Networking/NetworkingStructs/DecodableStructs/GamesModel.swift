//
//  GamesModel.swift
//  NBAlufe
//
//  Created by Alexey Meleshkevich on 16.02.2020.
//  Copyright © 2020 Alexey Meleshkevich. All rights reserved.
//

import Foundation

struct API: Decodable {
    let status:  Int
    let message: String
    let results: Int
    let games:   [GameModel]
    let filters = ["seasonYear", "league", "gameId", "teamId", "date", "live"]
}
