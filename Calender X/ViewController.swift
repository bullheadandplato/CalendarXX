//
//  ViewController.swift
//  Calender X
//
//  Created by osama on 7/30/16.
//  Copyright © 2016 osama. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var container: UIView!
    var settingController: SettingsController?

    override func viewDidLoad() {
        super.viewDidLoad()
        settingController = self.childViewControllers.last as? SettingsController
        
    }
    override func viewWillAppear(_ animated: Bool) {
        settingController?.getData()
    }
    
    override func didReceiveMemoryWarning() {
        //
    }
    @IBAction func prevButtonPressed(_ sender: UIBarButtonItem) {
        
        settingController?.prevMonth()
    }
    @IBAction func nextButtonPressed(_ sender: UIBarButtonItem) {
        settingController?.nextMonth()
    }
    @IBAction func changeScene(_ sender: AnyObject) {
        
    }
}

