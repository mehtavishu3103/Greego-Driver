//
//  OtpverificationViewController.swift
//  Greegodriverapp
//
//  Created by Harshal Shah on 4/10/18.
//  Copyright © 2018 Harshal Shah. All rights reserved.
//

import UIKit
import Alamofire
import SVPinView

class OtpverificationViewController: UIViewController {

    var strmobileno: String?
    var strotp: String?
    
    @IBOutlet weak var lblmobile: UILabel!
    
    @IBOutlet weak var txtmobile: SVPinView!
    
    @IBOutlet weak var btnresend: UIButton!
    
    @IBOutlet weak var lbltimer: UILabel!
    var timer : Timer?
    var count = 60
    override func viewDidLoad() {
        super.viewDidLoad()
//print(strmobileno)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        lbltimer.text = "00:00"
        lblmobile.text = "Enter six digit code sent to " + strmobileno!
    
        let tap = UITapGestureRecognizer()
        
        
        tap.addTarget(self, action:#selector(getter: btnresend))
        
        btnresend.addGestureRecognizer(tap)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 60.0, execute: {
            
            self.strotp = ""
            
        })
        
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func nextbtnaction(_ sender: Any) {
        
        if(txtmobile.getPin() != "")
        {
            if(strotp == "")
                
            {
                
                
                let alert = UIAlertController(title: "Alert", message: "OTP expired", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            
            if(txtmobile.getPin() == strotp)
            {
                
                checkuser()
                
                
                
            }
            
            //  verifyotp()
        }
        else
            
        {
            
            let alert = UIAlertController(title: "Alert", message: "Please enter OTP", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
    }
    
    
    @objc func update() {
        if(count > 0){
            let minutes = String(count / 60)
            let seconds = String(count % 60)
            lbltimer.text = minutes + ":" + seconds
            count -= 1;
            btnresend.isUserInteractionEnabled = false
            if count == 0 {
                timer?.invalidate()
                lbltimer.text = "00:00"
                btnresend.isUserInteractionEnabled = true
            }
        }else{
            timer?.invalidate()
        }
    }
    
    
    @IBAction func resendbtnaction(_ sender: Any) {
        
        if AppDelegate.hasConnectivity() == true
        {
            
            let parameters = [
                "contact_number":strmobileno,
                "is_iphone": "0",
                "user_type": "driver"
            ]
            
            Alamofire.request(WebServiceClass().BaseURL+"login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        print(response.result.value!)
                        
                        
                        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
                        
                        
                        let dic: NSDictionary =  response.result.value! as! NSDictionary
                        
                        if(dic.value(forKey: "error_code") as! NSNumber  == 0)
                        {
                            var datadic :NSDictionary = dic.value(forKey: "data") as! NSDictionary
                            
                            
                            
                            let otpstring = datadic.value(forKey: "otp") as! NSNumber
                            let devicetoken =  datadic.value(forKey: "token") as! String
                            
                            self.strotp = otpstring.stringValue
                            
                            
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
    
    func checkuser()
    {
        if AppDelegate.hasConnectivity() == true
        {
            
            print(UserDefaults.standard.value(forKey: "devicetoken") as! String)
            
            
            let token = UserDefaults.standard.value(forKey: "devicetoken") as! String
            let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
            
            
            Alamofire.request(WebServiceClass().BaseURL+"driver/me", method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        print(response.result.value!)
                        
                        
                        
                        let dic: NSDictionary =  response.result.value! as! NSDictionary
                        
                        if(dic.value(forKey: "error_code") as! NSNumber  == 0)
                        {
                            
                            
                            let newdic: NSDictionary = dic.value(forKey: "data") as! NSDictionary
                            
                            if(newdic.value(forKey: "is_agreed") as! String == "0")
                            {
                                
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                
                                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EmailViewController") as! EmailViewController
                                self.navigationController?.pushViewController(nextViewController, animated: true)
                                
                                
                            }
                            else
                                
                                
                            {
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                
                                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                                self.navigationController?.pushViewController(nextViewController, animated: true)
                                
                                
                            }
                            
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
