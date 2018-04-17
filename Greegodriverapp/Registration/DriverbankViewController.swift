//
//  DriverbankViewController.swift
//  Greegodriverapp
//
//  Created by Harshal Shah on 4/11/18.
//  Copyright © 2018 Harshal Shah. All rights reserved.
//

import UIKit

class DriverbankViewController: UIViewController {

    @IBOutlet weak var driverlabelview: UIView!
    
    @IBOutlet weak var routnumview: UIView!
    
    @IBOutlet weak var accountnumview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
self.setShadow(view: driverlabelview)
        self.setShadow(view: routnumview)
        self.setShadow(view: accountnumview)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setShadow(view: UIView)
    {
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        view.layer.shadowRadius = 2
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
