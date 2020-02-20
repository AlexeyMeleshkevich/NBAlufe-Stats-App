//
//  UrlData.swift
//  NBAlufe
//
//  Created by Alexey Meleshkevich on 20.02.2020.
//  Copyright © 2020 Alexey Meleshkevich. All rights reserved.
//

import Foundation

struct URLData {
    var urlKey = "2020-02-14"
    
    var url = "https://api-nba-v1.p.rapidapi.com/games/date/"
    
    init(urlKey: String) {
        self.urlKey = urlKey
        urlSet()
    }
    
    mutating func urlSet() {
        url += urlKey
    }
}
