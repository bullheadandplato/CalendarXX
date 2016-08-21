//
//  EventsController.swift
//  Calender X
//
//  Created by osama on 8/2/16.
//  Copyright © 2016 osama. All rights reserved.
//

import UIKit

class EventsController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let simpleTableIdentifier = "SimpleTableIdentifier"
    var data = DataClass()
    var countryData:[Countries]?
    var countryNameSelected = [String]()
    var countryNameNotSelected = [String]()
    var countryEventCount = [String:NSNumber]()
    
    override func viewDidLoad() {
        //fill data
        countryData = data.getCountries()
        for x in countryData!{
            countryEventCount[x.name!] = x.eventCount
            if x.selected != 0{
                countryNameSelected.append(x.name!)
            }else{
                countryNameNotSelected.append(x.name!)
                
            }
        }
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewWillAppear(animated: Bool) {
        tableView!.setEditing(true, animated: true)
    }
    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(simpleTableIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCellStyle.Subtitle,
                reuseIdentifier: simpleTableIdentifier)
        }
        if indexPath.section == 0{
            cell?.textLabel?.text = countryNameSelected[indexPath.row]
            cell?.detailTextLabel?.text = " \(countryEventCount[countryNameSelected[indexPath.row]] as! Int) events"


        }else{
            cell?.textLabel?.text = countryNameNotSelected[indexPath.row]
            let x = countryEventCount[countryNameNotSelected[indexPath.row]]
            let y = x as! Int
            cell?.detailTextLabel?.text =  "\(y) events "

        }
        return cell!
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return countryNameSelected.count
        }else{
            return countryNameNotSelected.count
        }
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section==0{
            return "Include Events From"
        }else{
            return "Do not include"
        }
    }
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.None
    }
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        if sourceIndexPath.section != destinationIndexPath.section{
            if sourceIndexPath.section == 0{
                let item = countryNameSelected[sourceIndexPath.row]
                countryNameSelected.removeAtIndex(sourceIndexPath.row)
                countryNameNotSelected.append(item)
                
                //presist in store
                data.setSelected(0, countryName: item)
                //reload table view
                tableView.reloadData()
               
                
            }else{
                let item = countryNameNotSelected[sourceIndexPath.row]
                countryNameSelected.append(item)
                countryNameNotSelected.removeAtIndex(sourceIndexPath.row)
                data.setSelected(1, countryName: item)
                tableView.reloadData()
            }
        }
        
    }
   
    @IBAction func changeScene(sender: AnyObject) {
        let view = self.storyboard?.instantiateViewControllerWithIdentifier("main") as! ViewController
        self.presentViewController(view, animated: true, completion: nil)
    }
}
