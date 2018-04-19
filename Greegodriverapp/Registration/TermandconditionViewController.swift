//
//  TermandconditionViewController.swift
//  Greegodriverapp
//
//  Created by Harshal Shah on 4/13/18.
//  Copyright © 2018 Harshal Shah. All rights reserved.
//

import UIKit
import  Alamofire

class TermandconditionViewController: UIViewController {

    
    @IBOutlet weak var textview: UITextView!
    var ischecked:String = "0"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func nextbtnaction(_ sender: Any) {
        
        if(ischecked == "0")
            
        {
            let alert = UIAlertController(title: "Alert", message: "Please Accept Term and condition", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
            
        else
        {
            getuserprofile()
            
        }
    }
    
    @IBAction func checkbox(_ sender: Any) {
        
        if(ischecked == "0")
        {
            ischecked = "1"
        }
        else
        {
            ischecked = "0"
            
            
        }
    }
    
    //MARK: - USER DEFINE FUNCTIONS
    
    func getuserprofile()
    {
        if AppDelegate.hasConnectivity() == true
        {
            
            let token = UserDefaults.standard.value(forKey: "devicetoken") as! String
            let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
            
            let parameters = [
                "name":UserDefaults.standard.value(forKey: "fname") as! String,
                "email": UserDefaults.standard.value(forKey: "email") as! String,
                "lastname":UserDefaults.standard.value(forKey: "lname") as! String,
                "city": "",
                "profile_pic":"",
                "is_agreed": ischecked,
                
                ]
            
            
            Alamofire.request(WebServiceClass().BaseURL+"user/update", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        print(response.result.value!)
                        
                        
                        
                        
                        let dic: NSDictionary =  response.result.value! as! NSDictionary
                        
                        if(dic.value(forKey: "error_code") as! NSNumber  == 0)
                        {
                            
                            
                            let newdic: NSDictionary = dic.value(forKey: "data") as! NSDictionary
                            
                            
                            
                            
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            
                            
                            
                            
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
