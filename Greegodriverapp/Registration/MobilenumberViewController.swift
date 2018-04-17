//
//  MobilenumberViewController.swift
//  Greegodriverapp
//
//  Created by Harshal Shah on 4/10/18.
//  Copyright © 2018 Harshal Shah. All rights reserved.
//

import UIKit
import Alamofire


class MobilenumberViewController: UIViewController {

    
    @IBOutlet weak var txtmobilenumber: customTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtmobilenumber.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "usaflag")
        imageView.image = image
        txtmobilenumber.leftView = imageView
        txtmobilenumber.textInputView.frame.origin.x += 10
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextbtnaction(_ sender: Any) {
        
        if(txtmobilenumber.text == "")
        {
            let alert = UIAlertController(title: "Alert", message: "Please enter correct mobile number.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        else
        {
            
            checkmobile()
            
            
            
        }
        
    }
    
    //MARK: - USER DEFINE FUNCTIONS
    func checkmobile()
    {
        if AppDelegate.hasConnectivity() == true
        {
           // print(txtmobilenumber.text!)
            let parameters = [
                "contact_number":txtmobilenumber.text!,
                "is_iphone": "0",
                "user_type": "driver"
            ]
            
            Alamofire.request(WebServiceClass().BaseURL+"login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        print(response.result.value!)
                        
                        
                        
                        
                        let dic: NSDictionary =  response.result.value! as! NSDictionary
                        
                        if(dic.value(forKey: "error_code") as! NSNumber  == 0)
                        {
                            
                            
                            var datadic :NSDictionary = dic.value(forKey: "data") as! NSDictionary
                            let otpstring = datadic.value(forKey: "otp") as! NSNumber
                            let devicetoken =  datadic.value(forKey: "token") as! String
                            
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OtpverificationViewController") as! OtpverificationViewController
                            print(self.txtmobilenumber.text!)
                          nextViewController.strmobileno = self.txtmobilenumber.text!
                            nextViewController.strotp = otpstring.stringValue
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            
                            let user = UserDefaults.standard
                            
                            user.set(devicetoken, forKey: "devicetoken")
                            user.synchronize()
                            
                            
                        }
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
    
   
}
