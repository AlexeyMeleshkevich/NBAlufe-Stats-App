//
//  NetworkingService.swift
//  NBAlufe
//
//  Created by Alexey Meleshkevich on 31.01.2020.
//  Copyright © 2020 Alexey Meleshkevich. All rights reserved.
//

import Foundation
import UIKit

class NetworkingService {
    
    internal var matches = [GameModel]()
    
    
    public let url: String
    public let header: [String: String]
    
    
    init(url: String, header: [String: String]) {
        self.url = url
        self.header = header
        print(url)
    }
    
    func requestData(tableView: UITableView) {
        guard let url = URL(string: self.url) else { return }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = self.header
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let json = try JSONDecoder().decode(APIShell.self, from: data)
                self.matches = json.api.games
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
                //                print(json.api.games[0].vTeam.fullName! + " " + json.api.games[0].hTeam.fullName!)
                //                print(json.api.games[0].vTeam.score.points + " vs " + json.api.games[0].hTeam.score.points)
                
            } catch let error {
                print("Error serialization json", error, response ?? "No response")
            }
        }.resume()
    }
}
