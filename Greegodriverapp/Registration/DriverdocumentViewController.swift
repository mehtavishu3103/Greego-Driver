//
//  DriverdocumentViewController.swift
//  Greegodriverapp
//
//  Created by Harshal Shah on 4/11/18.
//  Copyright © 2018 Harshal Shah. All rights reserved.
//

import UIKit

class DriverdocumentViewController: UIViewController {

    
    @IBOutlet var insuranceview: UIView!
    
    @IBOutlet weak var subview: UIView!
    @IBAction func txtinsurance(_ sender: Any) {
        self.view.addSubview(insuranceview)
        insuranceview.frame = CGRect(x: 10, y: 400, width: self.view.frame.width-20
            , height: 150)
        
        self.view.alpha = 2.0
        subview.layer.borderWidth = 1
        subview.layer.cornerRadius = 15
        subview.layer.borderColor = UIColor.black.cgColor
    }
    
    
    @IBOutlet weak var viewdocument: UIView!
    
    @IBOutlet weak var fileattechview: UIView!
    
    
    @IBOutlet weak var fieattechview2: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setShadow(view: viewdocument)
        
        fileattechview.layer.borderWidth = 1
        fileattechview.layer.cornerRadius = 15
        fileattechview.layer.borderColor = UIColor.black.cgColor
        
        fieattechview2.layer.borderWidth = 1
        fieattechview2.layer.cornerRadius = 15
        fieattechview2.layer.borderColor = UIColor.black.cgColor
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
