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
import SVProgressHUD
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
        
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bg_rectangle")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        lbltimer.text = "00:00"
        lblmobile.text = "Enter six digit code sent to " + strmobileno!
    btnresend.isEnabled = false
    
        
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
    
    @IBAction func backaction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)

    }
    
    @objc func update() {
        if(count > 0){
            let minutes = String(count / 60)
            let seconds = String(count % 60)
            lbltimer.text = minutes + ":" + seconds
            count -= 1;
            btnresend.isEnabled = false
            if count == 0 {
                timer?.invalidate()
                lbltimer.text = "00:00"
                btnresend.isEnabled = true
            }
        }else{
            timer?.invalidate()
        }
    }
    
    
    @IBAction func resendbtnaction(_ sender: Any) {
        
        if AppDelegate.hasConnectivity() == true
        {
            SVProgressHUD.show()

            let parameters = [
                "contact_number":"+91"+strmobileno!,
                "is_iphone": "0",
                "user_type": "driver"
            ]
            
            Alamofire.request(WebServiceClass().BaseURL+"login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        
                        SVProgressHUD.dismiss()

                        print(response.result.value!)
                        self.btnresend.isEnabled = false

                        
                        
                        
                        let dic: NSDictionary =  response.result.value! as! NSDictionary
                        
                        if(dic.value(forKey: "error_code") as! NSNumber  == 0)
                        {
                            var datadic :NSDictionary = dic.value(forKey: "data") as! NSDictionary
                            self.count = 60
                            self.lbltimer.text = "00:00"
                            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)

                            
                            let otpstring = datadic.value(forKey: "otp") as! NSNumber
                            let devicetoken =  datadic.value(forKey: "token") as! String
                            
                            self.strotp = otpstring.stringValue
                            
                            var dic = response.result.value as! NSDictionary
                            let profilestatus = datadic.value(forKey: "profile_status") as! Int
                            let status = profilestatus as! NSNumber
                            
                        
                            
                            
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
    
    func checkuser()
    {
        if AppDelegate.hasConnectivity() == true
        {
            SVProgressHUD.show()

            print(UserDefaults.standard.value(forKey: "devicetoken") as! String)
            
            
            let token = UserDefaults.standard.value(forKey: "devicetoken") as! String
            let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
            
            
            Alamofire.request(WebServiceClass().BaseURL+"driver/me", method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        print(response.result.value!)
                        
                        SVProgressHUD.dismiss()
                        
                        let dic: NSDictionary =  response.result.value! as! NSDictionary
                        
                        if(dic.value(forKey: "error_code") as! NSNumber  == 0)
                        {
                            
                            
                            let newdic: NSDictionary = dic.value(forKey: "data") as! NSDictionary
                            
                            if(newdic.value(forKey: "profile_status") as! NSNumber == 0)
                            {
                                
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                
                                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EmailViewController") as! EmailViewController
                                self.navigationController?.pushViewController(nextViewController, animated: true)
                                
                                
                                let status = newdic.value(forKey: "profile_status") as! NSNumber

                                
                                let user = UserDefaults.standard
                                
                                user.set(self.strmobileno!, forKey: "mobile")
                                
                                user.set(status.stringValue, forKey: "profilestatus")
                                
                                user.set(newdic.value(forKey: "is_approve") as! String, forKey: "isaprroved")


                                user.synchronize()
                                
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
    
  

}
