

//
//  DrivershippingaddViewController.swift
//  Greegodriverapp
//
//  Created by Harshal Shah on 4/11/18.
//  Copyright © 2018 Harshal Shah. All rights reserved.
//

import UIKit
import Alamofire
import CTCheckbox
import SVProgressHUD

class DrivershippingaddViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
   

    
    @IBOutlet weak var txtaddress: UITextField!
    
    @IBOutlet weak var txtapt: UITextField!

    @IBOutlet weak var txtcity: UITextField!
    
    @IBOutlet weak var txtstate: UITextField!
    
    @IBOutlet weak var txtzipcode: UITextField!
    
    @IBOutlet weak var viewdriver: UIView!
    
    @IBOutlet weak var checkboxcheck: CTCheckbox!
     var ischecked:String = "0"
    var state = [ "AK - Alaska",
                  "AL - Alabama",
                  "AR - Arkansas",
                  "AS - American Samoa",
                  "AZ - Arizona",
                  "CA - California",
                  "CO - Colorado",
                  "CT - Connecticut",
                  "DC - District of Columbia",
                  "DE - Delaware",
                  "FL - Florida",
                  "GA - Georgia",
                  "GU - Guam",
                  "HI - Hawaii",
                  "IA - Iowa",
                  "ID - Idaho",
                  "IL - Illinois",
                  "IN - Indiana",
                  "KS - Kansas",
                  "KY - Kentucky",
                  "LA - Louisiana",
                  "MA - Massachusetts",
                  "MD - Maryland",
                  "ME - Maine",
                  "MI - Michigan",
                  "MN - Minnesota",
                  "MO - Missouri",
                  "MS - Mississippi",
                  "MT - Montana",
                  "NC - North Carolina",
                  "ND - North Dakota",
                  "NE - Nebraska",
                  "NH - New Hampshire",
                  "NJ - New Jersey",
                  "NM - New Mexico",
                  "NV - Nevada",
                  "NY - New York",
                  "OH - Ohio",
                  "OK - Oklahoma",
                  "OR - Oregon",
                  "PA - Pennsylvania",
                  "PR - Puerto Rico",
                  "RI - Rhode Island",
                  "SC - South Carolina",
                  "SD - South Dakota",
                  "TN - Tennessee",
                  "TX - Texas",
                  "UT - Utah",
                  "VA - Virginia",
                  "VI - Virgin Islands",
                  "VT - Vermont",
                  "WA - Washington",
                  "WI - Wisconsin",
                  "WV - West Virginia",
                  "WY - Wyoming"]
     var pickerview  = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
         self.setShadow(view: viewdriver)

        var toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(donePressed))
        
        var spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        //self.navigationController?.navigationBar.isHidden = true
        txtstate.inputAccessoryView = toolBar
       
        pickerview.delegate = self
        pickerview.dataSource = self
        txtstate.inputView = pickerview
       
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func donePressed(){
        
    if(txtstate.text == "")
            {
                
               txtstate.text = state[0] as! String
                txtstate.resignFirstResponder()
             
                
            }
        else
        
            {
                
                txtstate.resignFirstResponder()

        }
       
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
       txtstate.text = state[row] as String
       
        
    }
    @IBAction func btnshippingaction(_ sender: Any) {
        
        if(txtaddress.text == "")
        {
            
            let alert = UIAlertController(title: "Alert", message: "Please Enter Firstname", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
          
            
        }
            
      
        else if(txtcity.text == ""){
            
            let alert = UIAlertController(title: "Alert", message: "Please Enter City", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if(txtstate.text == ""){
            let alert = UIAlertController(title: "Alert", message: "Please Enter State", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if(txtzipcode.text == ""){
            let alert = UIAlertController(title: "Alert", message: "Please Enter Zipcode", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if(ischecked == "0")
            
        {
            let alert = UIAlertController(title: "Alert", message: "Please check the checkbox", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        else{
            checkshippingaddress()
            
        }
        
    }
    
    @IBAction func checkboxaction(_ sender: Any) {
        
        
        if(ischecked == "0")
        {
            ischecked = "1"
        }
        else
        {
            ischecked = "0"
            
            
        }
    }
    func checkshippingaddress()
    {
        if AppDelegate.hasConnectivity() == true
        {
            
            SVProgressHUD.show()
            let token = UserDefaults.standard.value(forKey: "devicetoken") as! String
            let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
            
            let parameters = [
                "street":txtaddress.text!,
                "apt": txtapt.text!,
                "city": txtcity.text!,
                "zipcode": txtzipcode.text!,
                "state": txtstate.text!
            ]
            
            Alamofire.request(WebServiceClass().BaseURL+"driver/update/shippingadress", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    
                    SVProgressHUD.dismiss()

                    if let data = response.result.value{
                        print(response.result.value!)
                        var dic = response.result.value as! NSDictionary
                        
                        
                        
                        
                        if(dic.value(forKey: "error_code") as! NSNumber == 0)
                        {
                            
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DriverdocumentViewController") as! DriverdocumentViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        var dic = response.result.value as! NSDictionary
                        var datadic :NSDictionary = dic.value(forKey: "data") as! NSDictionary
                        let profilestatus = datadic.value(forKey: "profile_status") as! NSNumber
                      
                        
                        let user = UserDefaults.standard
                       // user.set(profilestatus, forKey: "profile_status")
                        user.set(self.txtaddress.text!, forKey: "address")
                        user.set(self.txtapt.text!, forKey: "apt")
                        user.set(self.txtcity.text!, forKey: "city")
                        user.set(self.txtzipcode.text!, forKey: "zipcode")
                        user.set(self.txtstate.text!, forKey: "state")
                        user.set(profilestatus.stringValue, forKey: "profilestatus")

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
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return state.count
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
     
         return state[row]as String
       
    }
    
    func setShadow(view: UIView)
    {
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        view.layer.shadowRadius = 2
    }
   

}
