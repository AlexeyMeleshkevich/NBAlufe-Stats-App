//
//  NetworkingService.swift
//  NBAlufe
//
//  Created by Alexey Meleshkevich on 31.01.2020.
//  Copyright © 2020 Alexey Meleshkevich. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingService {
    
    let headers: HTTPHeaders = ["content-type": "application/json",
                                "date": "Fri, 31 Jan 2020 16:06:54 GMT",
                                "server": "RapidAPI-1.0.39",
                                "x-rapidapi-region": "AWS - eu-central-1",
                                "x-rapidapi-version": "1.0.39",
                                "x-ratelimit-requests-limit": "100",
                                "x-ratelimit-requests-remaining": "99",
                                "content-length": "144",
                                "connection": "Close",
    ]
    
    
    
    
    func request(url: String) {
        Alamofire.request(url, method: .get, headers: headers).responseJSON { responseJSON in
            
            guard let statusCode = responseJSON.response?.statusCode else { return }
            print("statusCode: ", statusCode)
            
            if (200..<300).contains(statusCode) {
                let value = responseJSON.result.value
                print(responseJSON.result)
                print("value: ", value ?? "nil")
            } else {
                print("error")
            }
        }
    }
}
