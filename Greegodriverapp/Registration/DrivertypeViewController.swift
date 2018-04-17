//
//  DrivertypeViewController.swift
//  Greegodriverapp
//
//  Created by Harshal Shah on 4/11/18.
//  Copyright © 2018 Harshal Shah. All rights reserved.
//

import UIKit

class DrivertypeViewController: UIViewController {

    
    @IBOutlet weak var carsizeview: HADropDown!
    
    @IBOutlet weak var transmissionview: HADropDown!
    override func viewDidLoad() {
        super.viewDidLoad()
carsizeview.items = ["Cat", "Mouse", "Horse", "Elephant", "Dog", "Zebra"]
        
        transmissionview.items = ["Cat", "Mouse", "Horse", "Elephant", "Dog", "Zebra"]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
