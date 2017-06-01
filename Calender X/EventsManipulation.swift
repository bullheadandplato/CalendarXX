//
//  EventsManipulation.swift
//  Calender X
//
//  Created by osama on 8/3/16.
//  Copyright © 2016 osama. All rights reserved.
//

import Foundation
open class EventsManipulation{
    var day: NSNumber?
    var des: String?
    var month: NSNumber?
    var ac: String?
    
    func setAll(_ day:NSNumber,month:NSNumber,des:String,country:String){
        self.day = day
        self.month = month
        self.des = "\(country) : \(des)"
        self.ac = country
    }
   
   
}
