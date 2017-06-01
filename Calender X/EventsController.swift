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
    override func viewWillAppear(_ animated: Bool) {
        tableView!.setEditing(true, animated: true)
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCellStyle.subtitle,
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
        func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return countryNameSelected.count
        }else{
            return countryNameNotSelected.count
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section==0{
            return "Include Events From"
        }else{
            return "Do not include"
        }
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath.section != destinationIndexPath.section{
            if sourceIndexPath.section == 0{
                let item = countryNameSelected[sourceIndexPath.row]
                countryNameSelected.remove(at: sourceIndexPath.row)
                countryNameNotSelected.append(item)
                
                //presist in store
                data.setSelected(0, countryName: item)
                //reload table view
                tableView.reloadData()
               
                
            }else{
                let item = countryNameNotSelected[sourceIndexPath.row]
                countryNameSelected.append(item)
                countryNameNotSelected.remove(at: sourceIndexPath.row)
                data.setSelected(1, countryName: item)
                tableView.reloadData()
            }
        }
        
    }
   
    @IBAction func changeScene(_ sender: AnyObject) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "main") as! ViewController
        self.present(view, animated: true, completion: nil)
    }
}
