//
//  CalendarData.swift
//  NBAlufe
//
//  Created by Alexey Meleshkevich on 24.02.2020.
//  Copyright © 2020 Alexey Meleshkevich. All rights reserved.
//

import Foundation

struct CalendarData {
    static let date = Date()
    static let calendar = Calendar.current
    
    static var day = calendar.component(.day, from: date)
    static var weekday = calendar.component(.weekday, from: date)
    static var month = calendar.component(.month, from: date)
    static var year = calendar.component(.year, from: date)
    static var stringCurrentDay: String {
        get {
            
            switch self.day {
            case 1...9:
                switch self.month {
                case 0..<10:
                    let get1 = "\(self.year)-0\(self.month)-0\(self.day)"
                    return get1
                default:
                    let get2 = "\(self.year)-\(self.month)-0\(self.day)"
                    return get2
                }
            default:
                switch self.month {
                case 0..<10:
                    let get1 = "\(self.year)-0\(self.month)-\(self.day)"
                    return get1
                default:
                    let get2 = "\(self.year)-\(self.month)-\(self.day)"
                    return get2
                }
            }
        }
    }
}
