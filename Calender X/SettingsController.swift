//
//  SettingsController.swift
//  Calender X
//
//  Created by osama on 7/31/16.
//  Copyright © 2016 osama. All rights reserved.
//

import UIKit

class SettingsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var day: Int?
    private var month1 = [["header": "January","content": "0 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31"]]
    private var month2 = [[ "header": "Febraury","content": "0 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28"]]
    private var month3 = [["header": "March","content": "0 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31"]]
    private var month4 = [["header": "April","content": "0 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30"]]
    private var month5 = [["header": "May","content": "0 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31"]]
    private var month6 = [["header": "June","content": "0 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30"]]
    private var month7 = [["header": "July","content": "0 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31"]]
    private var month8 = [["header": "August","content": "0 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31"]]
    private var month9 = [["header": "September","content": "0 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30"]]
    private var month10 = [["header": "Octobar","content": "0 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31"]]
    private var month11 = [["header": "November","content": "0 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30"]]
    private var month12 = [["header": "December","content": "0 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31"]]
 
    //month events and data format for dictionary is [day:description]
    private var month1Events = [Int:String]()
    private var month2Events = [Int:String]()
    private var month3Events = [Int:String]()
    private var month4Events = [Int:String]()
    private var month5Events = [Int:String]()
    private var month6Events = [Int:String]()
    private var month7Events = [Int:String]()
    private var month8Events = [Int:String]()
    private var month9Events = [Int:String]()
    private var month10Events = [Int:String]()
    private var month11Events = [Int:String]()
    private var month12Events = [Int:String]()

    private var selectedMonth = [[String:String]]()
    private var selectedEvents = [Int:String]()
    private var selectedMonthIndex:Int = 0
    private var currentMonth:Int = 0
    private var currentYear:Int = 0
    private var selectedYear:Int = 0
    var countryFix = [NSNumber:String]()
    var data = DataClass()
    var events = [EventsManipulation]()
    private var totalEvents:Int = 0
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView!.registerClass(CellContent.self, forCellWithReuseIdentifier: "CONTENT")
        collectionView!.registerClass(HeaderCell.self,
                                      forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                      withReuseIdentifier: "HEADER")
        
        let layout = collectionView!.collectionViewLayout
        let flow = layout as! UICollectionViewFlowLayout
        flow.headerReferenceSize = CGSizeMake(100, 20)
        
        //get todays date
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day, .Month, .Year ], fromDate: date)
        selectedMonthIndex = components.month
        currentMonth = components.month
        currentYear = components.year
        selectedYear = currentYear
        day = components.day
        //fill data for events
        getData()
        monthChanged()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func wordsInSection(section: Int) -> [String] {
        
        let content = selectedMonth[section]["content"]
        let spaces = NSCharacterSet.whitespaceAndNewlineCharacterSet()
        let words = content?.componentsSeparatedByCharactersInSet(spaces)
        return words!
    }
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let words = wordsInSection(section)
        return words.count
    }
    override func collectionView(collectionView: UICollectionView,
                                 cellForItemAtIndexPath indexPath: NSIndexPath)
        -> UICollectionViewCell {
            let words = wordsInSection(indexPath.section)
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
                "CONTENT", forIndexPath: indexPath) as! CellContent
            cell.maxWidth = collectionView.bounds.size.width
            cell.text = words[indexPath.row]
            let tmp1 = [Int](selectedEvents.keys)
            let tmp = eventDayinMonth(tmp1, cellText: Int(cell.text)!)
            //be sure to set label background
            if day == Int(cell.text!) && selectedMonthIndex == currentMonth && selectedYear == currentYear{
                cell.label.backgroundColor = UIColor(patternImage: UIImage(named: "today")!)
            }else if Int(cell.text!) == 0{
                cell.text = " "
                cell.label.backgroundColor = UIColor.whiteColor()
            }else if tmp != 0{
                cell.label.textColor = UIColor.whiteColor()
                cell.label.font = UIFont.boldSystemFontOfSize(20)
                if getCountryforDate(selectedMonthIndex, day: Int(cell.text!)!) == "Amerirca (USA)"{
                    cell.label.backgroundColor = UIColor(patternImage: UIImage(named: "usa")!)
                                    }else if getCountryforDate(selectedMonthIndex, day: Int(cell.text!)!) == "Pakistan" {
                    cell.label.backgroundColor = UIColor(patternImage: UIImage(named: "pak")!)

                }
            }else{
                cell.label.textColor = UIColor.blackColor()
                cell.label.font = UIFont.boldSystemFontOfSize(16)

                cell.label.backgroundColor = UIColor(patternImage: UIImage(named: "all")!)
            }
            return cell
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let words = wordsInSection(indexPath.section)
        let size = CellContent.sizeForContentString(words[indexPath.row],
                                                    forMaxWidth: collectionView.bounds.size.width)
        return size
    }
    
    override func collectionView(collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                                                   atIndexPath indexPath: NSIndexPath)
        -> UICollectionReusableView {
            if (kind == UICollectionElementKindSectionHeader) {
                let cell =
                    collectionView.dequeueReusableSupplementaryViewOfKind(
                        kind, withReuseIdentifier: "HEADER",
                        forIndexPath: indexPath) as! HeaderCell
                cell.maxWidth = collectionView.bounds.size.width
                cell.text = selectedMonth[indexPath.section]["header"]
                //append year with month name
                cell.text.appendContentsOf(" "+String(currentYear))
                return cell
            }
            abort()
    }
    private func monthChanged(){
        switch selectedMonthIndex {
        case 1: selectedMonth = month1
        selectedEvents = month1Events
            break
        case 2: selectedMonth = month2
        selectedEvents = month2Events
            break
        case 3: selectedMonth = month3
        selectedEvents = month3Events
            break
        case 4: selectedMonth = month4
        selectedEvents = month4Events
            break
        case 5: selectedMonth = month5
        selectedEvents = month5Events
            break
        case 6: selectedMonth = month6
        selectedEvents = month6Events
            break
        case 7: selectedMonth = month7
        selectedEvents = month7Events
            break
        case 8: selectedMonth = month8
        selectedEvents = month8Events
            break
        case 9: selectedMonth = month9
        selectedEvents = month9Events
            break
        case 10: selectedMonth = month10
        selectedEvents = month10Events
            break
        case 11: selectedMonth = month11
        selectedEvents = month11Events
            break
        case 12:selectedMonth = month12
        selectedEvents = month12Events
            break
        default: break
            
        }
    }
    
    func prevMonth( ){
        if selectedMonthIndex == 1{
            selectedMonthIndex = 12
            currentYear -= 1
        }else{
            selectedMonthIndex -= 1
        }
        monthChanged()
        collectionView!.reloadData()
    }
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
            animateCell(cell)
    }
    func animateCell(cell:UICollectionViewCell) {
        cell.layer.opacity = 0
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.fromValue = 0
        anim.toValue = 1
        anim.duration = 2
        cell.layer.addAnimation(anim, forKey: anim.keyPath)
        cell.layer.opacity=1
    }
    func nextMonth(){
        if selectedMonthIndex == 12{
            selectedMonthIndex = 1
            currentYear += 1
        }else{
            selectedMonthIndex += 1
        }
        monthChanged()
        collectionView?.reloadData()
    }
    private func fillEventsData(month:Int, day:Int,description:String){
        switch month {
        case 1: month1Events.updateValue(description, forKey: day)
        break;
        case 2: month2Events.updateValue(description, forKey: day)
        break;
        case 3: month3Events.updateValue(description, forKey: day)
        break;
        case 4: month4Events.updateValue(description, forKey: day)
        break;
        case 5: month5Events.updateValue(description, forKey: day)
        break;
        case 6: month6Events.updateValue(description, forKey: day)
        break;
        case 7: month7Events.updateValue(description, forKey: day)
            break
        case 8: month8Events.updateValue(description, forKey: day)
        break
        case 9: month9Events.updateValue(description, forKey: day)
        case 10: month10Events.updateValue(description, forKey: day)
        break;
        case 11: month11Events.updateValue(description, forKey: day)
        break;
        case 12: month12Events.updateValue(description, forKey: day)
        break;

        default:
            break
        }
    }
    private func eventDayinMonth(month:[Int], cellText:Int)->Int{
        var y:Int = 0

        for x in month{
            if x == cellText{
                y = cellText
            }
        }
         return y
    }
    func getEventDescription(month:Int,day:Int)->String{
        switch month {
        case 1: if month1Events[day] == nil{
            return "No event for \(day) January, Goto Settings to add events"
            
        }else{
            return month1Events[day]!
            }
        case 2:if month2Events[day] == nil{
            return "No event for \(day) Febraury, Goto Settings to add events"
            
        }else{
            return month2Events[day]!
            }
        case 3: if month3Events[day] == nil{
            return "No event for \(day) March, Goto Settings to add events"
            
        }else{
            return month3Events[day]!
            }
        case 4:if month4Events[day] == nil{
            return "No event for \(day) May, Goto Settings to add events"
            
        }else{
            return month4Events[day]!
            }
        case 5:if month5Events[day] == nil{
            return "No event for \(day) April Goto Settings to add events"
            
        }else{
            return month5Events[day]!
            }
        case 6:if month6Events[day] == nil{
            return "No event for \(day) June, Goto Settings to add events"
            
        }else{
            return month6Events[day]!
            }
        case 7: if month7Events[day] == nil{
            return "No event for \(day) July, Goto Settings to add events"

        }else{
            return month7Events[day]!
            }
        case 8:if month8Events[day] == nil{
            return "No event for \(day) August, Goto Settings to add events"
            
        }else{
            return month8Events[day]!
            }
        case 9:if month9Events[day] == nil{
            return "No event for \(day) September, Goto Settings to add events"
            
        }else{
            return month9Events[day]!
            }
        case 10: if month10Events[day] == nil{
            return "No event for \(day) Octobar, Goto Settings to add events"
            
        }else{
            return month10Events[day]!
            }
        case 11: if month11Events[day] == nil{
            return "No event for \(day) November, Goto Settings to add events"
            
        }else{
            return month11Events[day]!
            }
        case 12: if month12Events[day] == nil{
            return "No event for \(day) December, Goto Settings to add events"
            
        }else{
            return month12Events[day]!
            }
        default:
            break
        }
        return " " //this should never happen
    }
    
    func getCurrentMonth()->Int{
        return selectedMonthIndex
    }
    
    private func getCountryforDate(month:Int, day:Int)->String{
        for (key,value) in countryFix{
            if key == month{
                for (c,_) in selectedEvents{
                    if c == day{
                        return value
                    }
                }
            }
            
        }
        return " " //this should never happen
    }
    
    func getData(){
        events = data.getSelectedEvents()
        if events.count == 0{
            
            // clear every array and dictionary becuase events are removed
            //define an empty dictionary and set it to all month events
            let tmp = [Int:String]()
            month1Events = tmp
            month2Events = tmp
            month3Events = tmp
            month4Events = tmp
            month5Events = tmp
            month6Events = tmp
            month7Events = tmp
            month8Events = tmp
            month9Events = tmp
            month10Events = tmp
            month11Events = tmp
            month12Events = tmp
            selectedEvents = tmp
            
        }
        for x in events{
            totalEvents += 1
            fillEventsData(x.month as! Int, day: x.day as! Int, description: x.des!)
            countryFix.updateValue(x.ac!, forKey: x.month!)
            
        }
        collectionView?.reloadData()
    }
}
