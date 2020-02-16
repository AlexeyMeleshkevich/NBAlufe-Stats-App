//
//  NetworkingService.swift
//  NBAlufe
//
//  Created by Alexey Meleshkevich on 31.01.2020.
//  Copyright © 2020 Alexey Meleshkevich. All rights reserved.
//

import Foundation

class NetworkingService {
    
    let url: String
    let headers: [String: String]
    
    init(url: String, headers: [String: String]) {
        self.url = url
        self.headers = headers
    }
    
    func requestData() {
        guard let url = URL(string: self.url) else { return }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = self.headers
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            print(response ?? "Error")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
            
//            let jsonArray = try? JSONDecoder().decode([MatchModel].self, from: data)
//            print(jsonArray ?? "Error")
        }.resume()
    }
}

