//
//  GameModel.swift
//  NBAlufe
//
//  Created by Alexey Meleshkevich on 16.02.2020.
//  Copyright © 2020 Alexey Meleshkevich. All rights reserved.
//

import Foundation

struct GameModel: Decodable {
    let seasonYear:      String
    let league:          String
    let gameId:          String
    let startTimeUTC:    String
    let endTimeUTC:      String
    let arena:           String
    let city:            String
    let country:         String
    let clock:           String
    let gameDuration:    String
    let currentPeriod:   String
    let halftime:        String
    let EndOfPeriod:     String
    let seasonStage:     String
    let statusShortGame: String
    let statusGame:      String
    let vTeam:           vTeam
    let hTeam:           hTeam
}
