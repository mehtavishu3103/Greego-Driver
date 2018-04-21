//
//  DriverpersonalinfoViewController.swift
//  Greegodriverapp
//
//  Created by Harshal Shah on 4/11/18.
//  Copyright © 2018 Harshal Shah. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class DriverpersonalinfoViewController: UIViewController {

    
    @IBOutlet weak var txtfname: UITextField!
    
    @IBOutlet weak var txtmname: UITextField!
    
    @IBOutlet weak var txtlname: UITextField!
    
    @IBOutlet weak var txtnumber: UITextField!
    @IBOutlet weak var txtdob: UITextField!
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        
    }

    
    @IBAction func txtbtnaction(_ sender: Any) {
        if(txtfname.text == "")
        {
            
            let alert = UIAlertController(title: "Alert", message: "Please Enter Firstname", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
            
            
        }
       
        else if(txtlname.text == "")
        {
            
            let alert = UIAlertController(title: "Alert", message: "Please Enter Lastname", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        }
        else if(txtnumber.text == ""){
            
            let alert = UIAlertController(title: "Alert", message: "Please Enter SecurityNumber", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if(txtdob.text == ""){
            let alert = UIAlertController(title: "Alert", message: "Please Enter Date of Birth", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        else{
           checkinfo()
          
        }
        
    }
    
    
    
    func checkinfo()
    {
        if AppDelegate.hasConnectivity() == true
        {
            
            SVProgressHUD.show()
            let token = UserDefaults.standard.value(forKey: "devicetoken") as! String
            let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
           
            let parameters = [
                "legal_firstname":txtfname.text!,
                "legal_middlename": txtmname.text!,
                "legal_lastname": txtlname.text!,
                 "social_security_number": txtnumber.text!,
                  "dob": txtdob.text!
            ]
            
            Alamofire.request(WebServiceClass().BaseURL+"driver/update/personalinfo", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    SVProgressHUD.dismiss()
                    if let data = response.result.value{
                        print(response.result.value!)
                        var dic = response.result.value as! NSDictionary
                        
                        
                        
                        
                        if(dic.value(forKey: "error_code") as! NSNumber == 0)
                        {
                            
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DrivershippingaddViewController") as! DrivershippingaddViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                        var dic = response.result.value as! NSDictionary
                        var datadic :NSDictionary = dic.value(forKey: "data") as! NSDictionary
                        let profilestatus = datadic.value(forKey: "profile_status") as! Int
                        let status = profilestatus as! NSNumber
                        
                        let user = UserDefaults.standard
                        print(status.stringValue)
                        user.set(status.stringValue, forKey: "profile_status")
                        user.set(self.txtfname.text!, forKey: "firstname")
                        user.set(self.txtmname.text!, forKey: "middlename")
                        user.set(self.txtlname.text!, forKey: "lastname")
                        user.set(self.txtnumber.text!, forKey: "securitynum")
                        user.set(self.txtdob.text!, forKey: "dob")
                        user.set(profilestatus, forKey: "profilestatus")

                        user.synchronize()
                        }
                        else
                        {
                            let alert = UIAlertController(title: "Alert", message: dic.value(forKey: "message") as! String, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                    }
                    break
                    
                case .failure(_):
                    SVProgressHUD.dismiss()

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
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donedatePicker));
        
        toolbar.setItems([doneButton], animated: false)
        
        txtdob.inputAccessoryView = toolbar
        txtdob.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        txtdob.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }



}
