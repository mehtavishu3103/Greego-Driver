//
//  ExpressPayVC.swift
//  Greegodriverapp
//
//  Created by Ravi Dubey on 4/21/18.
//  Copyright © 2018 Harshal Shah. All rights reserved.
//

import UIKit

class ExpressPayVC: UIViewController {

    @IBOutlet weak var btneditcard: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btneditcard.layer.shadowColor = UIColor.lightGray.cgColor
        btneditcard.layer.shadowOpacity = 0.5
        btneditcard.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btneditcard.layer.shadowRadius = 2
        btneditcard.layer.cornerRadius = 12.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - IBaction Methods
    @IBAction func closeaction(_ sender: Any) {
        
        
        
        
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
