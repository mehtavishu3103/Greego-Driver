//
//  DriverpersonalinfoViewController.swift
//  Greegodriverapp
//
//  Created by Harshal Shah on 4/11/18.
//  Copyright © 2018 Harshal Shah. All rights reserved.
//

import UIKit
import Alamofire
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
           
            let parameters = [
                "legal_firstname":txtfname.text!,
                "legal_middlename": txtmname.text!,
                "legal_lastname": txtlname.text!,
                 "social_security_number": txtnumber.text!,
                  "dob": txtdob.text!
            ]
            
            Alamofire.request(WebServiceClass().BaseURL+"driver/update/personalinfo", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        print(response.result.value!)
                        
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermandconditionViewController") as! TermandconditionViewController
                        self.navigationController?.pushViewController(vc, animated: true)
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
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        txtdob.inputAccessoryView = toolbar
        txtdob.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        txtdob.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }



}
