//
//  Utils.swift
//  Calender X
//
//  Created by Osama Bin Omar on 6/1/17.
//  Copyright © 2017 osama. All rights reserved.
//

import Foundation
class Utils{
    static func isToday(date:Date)->Bool{
        let order=NSCalendar.current.compare(Date(), to: date, toGranularity: .day)
        return order==ComparisonResult.orderedSame
    }

    static func getCurrentDay(date:Date)->Int{
          return  Date().startOfMonth(date: date)

    }
    
    static func getPrevMonthDays(month: Int,isLeap:Int, noOfday:Int)->String{
    
        switch month {
        case 1:
            return fillString(days: 31, noOfDays: noOfday)
        case 2:
            if(isLeap%4==0){
                return fillString(days: 29, noOfDays: noOfday)
            }else{
                return fillString(days: 28, noOfDays: noOfday)
            }
        case 3:
            return fillString(days: 31, noOfDays: noOfday)
        case 4:
            return fillString(days: 30, noOfDays: noOfday)
        case 5:
            return fillString(days: 31, noOfDays: noOfday)
        case 6:
            return fillString(days: 30, noOfDays: noOfday)
        case 7:
            return fillString(days: 31, noOfDays: noOfday)
        case 8:
            return fillString(days: 31, noOfDays: noOfday)
        case 9:
            return fillString(days: 30, noOfDays: noOfday)
        case 10:
            return fillString(days: 31, noOfDays: noOfday)
        case 11:
            return fillString(days: 30, noOfDays: noOfday)
        case 12:
            return fillString(days: 31, noOfDays: noOfday)
            
        default:
            return ""
        }
    }
    private static func fillString(days:Int, noOfDays:Int)->String{
        var noOfDays = noOfDays
        var temp:String=""
        while(noOfDays>0){
            noOfDays=noOfDays-1;
            temp.append("\(days-noOfDays) ")
        }
        return temp
    }
    
    
}
extension Date {
    func startOfMonth(date: Date) -> Int {
        
        let calendar = Calendar.current
        let currentDateComponents = calendar.dateComponents([.year,.month], from: date)
        let startOfMonth = calendar.date(from: currentDateComponents)
        let weekday=calendar.dateComponents([.weekday], from: startOfMonth!)
        print("day of the week \(weekday.weekday ?? 0)")
        return weekday.weekday!
    }
}
