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
    
    static let httpHeader = ["x-rapidapi-host": "api-nba-v1.p.rapidapi.com",
                             "x-rapidapi-key": "d3f4042bc4msh3e8baa6aaf0e778p15af52jsn260491400f82"]
    
    init(urlKey: String) {
        self.urlKey = urlKey
        urlSet()
    }
    
    mutating func urlSet() {
        url += urlKey
    }
}
