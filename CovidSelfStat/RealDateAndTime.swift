//
//  RealDateAndTime.swift
//  CovidSelfStat
//
//  Created by Александр Шубский on 01.12.2020.
//

import Foundation

class RealDataAndTime {
    
    let date = Date()
    let calendar = Calendar.current
    
    var finalDay: String?
    var finalMonth: String?
    var finalYear: String?
    
    var finalHour: String?
    var finalMinute: String?
    var finalSecond: String?
    
    
    
    func realDate() -> String{

        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        finalDay = normalView(value: day)
        finalMonth = normalView(value: month)
        
        return "\(finalDay!).\(finalMonth!).\(year)"
    }
    
    
    func realTime() -> String {
        
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        
        finalHour = normalView(value: hour)
        finalMinute = normalView(value: minute)
        finalSecond = normalView(value: second)

        return "\(finalHour!):\(finalMinute!):\(finalSecond!)"
    }
    
    func yesterdayDate() -> String {
        
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        finalDay = normalView(value: day)
        finalMonth = normalView(value: month)
        
        let lastDay = day - 1
        var lastMonth = month - 1
        let lastYear = year - 1
        
        if lastDay == 0 {
            if lastMonth == 0 {
                lastMonth = 12
                finalMonth = String(lastMonth)
                finalYear = String(lastYear)
            } else {
                finalMonth = String(lastMonth)
                finalYear = String(year)
            }
            finalDay = String(countDaysInMonth(month: lastMonth))
        } else {
            finalDay = String(lastDay)
            finalMonth = String(month)
            finalYear = String(year)
        }
        
        return "\(finalDay!).\(finalMonth!).\(finalYear!)"
    }
    
    func checkDay(day: Int, month: Int, year: Int) {
        
        
        
    }
    
    func countDaysInMonth(month: Int) -> Int {
        
        switch month {
        case 1, 3, 5, 7, 8, 10, 12:
            return 31
        case 2:
            return 28
        case 4, 6, 9, 11:
            return 30
        default:
            return 0
        }
        
    }
    
    
    func normalView(value: Int) -> String{
        var finalValue = ""
        
        if value < 10 {
            finalValue = "0" + String(value)
        } else {
            finalValue = String(value)
        }

        return finalValue
    }
    
    
}
