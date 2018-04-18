//
//  DriverbankViewController.swift
//  Greegodriverapp
//
//  Created by Harshal Shah on 4/11/18.
//  Copyright © 2018 Harshal Shah. All rights reserved.
//

import UIKit
import  Alamofire

class DriverbankViewController: UIViewController {

    @IBOutlet weak var driverlabelview: UIView!
    
    @IBOutlet weak var routnumview: UIView!
    
    @IBOutlet weak var accountnumview: UIView!
    
    
    @IBOutlet weak var txtroutnum: UITextField!
    
    @IBOutlet weak var txtaccountnum: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setShadow(view: driverlabelview)
        self.setShadow(view: routnumview)
        self.setShadow(view: accountnumview)
        // Do any additional setup after loading the view.
    }

    
    @IBAction func btnnextaction(_ sender: Any) {
        
        if(txtroutnum.text == "")
        {
            
            let alert = UIAlertController(title: "Alert", message: "Please Enter Routnumber", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(txtaccountnum.text == ""){
            let alert = UIAlertController(title: "Alert", message: "Please Enter Accountnumber", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            checkbankdetail()
            
        }
    }
    
    func checkbankdetail()
    {
        if AppDelegate.hasConnectivity() == true
        {
            let token = UserDefaults.standard.value(forKey: "devicetoken") as! String
            let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
            
            let parameters = [
                "account_number":txtaccountnum.text!,
                "routing_number": txtroutnum.text!,
               
            ]
            
            Alamofire.request(WebServiceClass().BaseURL+"driver/update/bankinfo", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        print(response.result.value!)
                        
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DrivertypeViewController") as! DrivertypeViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                        var dic = response.result.value as! NSDictionary
                        var datadic :NSDictionary = dic.value(forKey: "data") as! NSDictionary
                        let profilestatus = datadic.value(forKey: "profile_status") as! Int
                        let status = profilestatus as! NSNumber
                        
                        let user = UserDefaults.standard
                        print(status.stringValue)
                        user.set(status.stringValue, forKey: "profile_status")
                        user.set(self.txtaccountnum.text!, forKey: "accountnum")
                        user.set(self.txtroutnum.text!, forKey: "routnum")
                        
                        user.synchronize()
                    }
                    break
                    
                case .failure(_):
                    print(response.result.error)
                    break
                    
                }
            }
            
        }
        else
        {
            NSLog("No Internet Connection")
        }
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
