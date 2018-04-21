//
//  DriverdocumentViewController.swift
//  Greegodriverapp
//
//  Created by Harshal Shah on 4/11/18.
//  Copyright © 2018 Harshal Shah. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class DriverdocumentViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var insurancrheight: NSLayoutConstraint!
    
    
    @IBOutlet weak var uberheight: NSLayoutConstraint!
    
    
    @IBOutlet weak var btnverification: UIButton!
    
    //@IBOutlet weak var btninsurance: UIButton!
    
    @IBOutlet weak var btninsurance: UIButton!
    
    @IBOutlet weak var lblinsurance: UILabel!
    
    @IBOutlet weak var lbldriver: UILabel!
    
    @IBOutlet weak var insurancemainview: UIView!
    
    @IBOutlet weak var firstview: UIView!
    @IBOutlet weak var lblfirst: UILabel!
    
    @IBOutlet weak var secondview: UILabel!
    
    @IBOutlet weak var lblsecondview: UIView!
   
    @IBOutlet weak var imginsurance: UIImageView!
    
    @IBOutlet weak var imgdriver: UIImageView!
    @IBOutlet weak var viewdocument: UIView!
    
    @IBOutlet weak var fileattechview: UIView!
    
    @IBOutlet weak var insuranceview: UIView!
    
    @IBOutlet weak var driverview: UIView!
    @IBOutlet weak var fieattechview2: UIView!
    
    @IBOutlet weak var btnuberdriver: UIButton!
 
    @IBOutlet weak var btndriver: UIButton!
    var imgstr = "";
    var checkimg = "0";
    var imgstr1 = UIImage(named:"");
    var imgstr2 = UIImage(named:"");
    var imgstr3 = UIImage(named:"");
    var imgstr4 = UIImage(named:"");
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        insurancrheight.constant = 0
        uberheight.constant = 0
        self.setShadow(view: viewdocument)
        
        fileattechview.layer.borderWidth = 1
        fileattechview.layer.cornerRadius = 15
        fileattechview.layer.borderColor = UIColor.black.cgColor
        
        fieattechview2.layer.borderWidth = 1
        fieattechview2.layer.cornerRadius = 15
        fieattechview2.layer.borderColor = UIColor.black.cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(insuranceview1))
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(driverview1))
        lblinsurance.addGestureRecognizer(tapGesture)
        lblinsurance.isUserInteractionEnabled = true

        lbldriver.addGestureRecognizer(tapGesture1)
        lbldriver.isUserInteractionEnabled = true
        lblfirst.isHidden = true
        firstview.isHidden = true
        secondview.isHidden = true
        lblsecondview.isHidden = true
    }
    
    @objc func imageTapped(gesture:UIGestureRecognizer) {
        if let profile1Pic = gesture.view as? UIImageView {
            print("Image Tapped")
       //     showActionSheet()
        }
    }
  
    func photoLibrary()
    {
        
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    func camera()
    {
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    func showActionSheet(img:String) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
            self.checkimg = img

        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
            self.checkimg = img
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        
       if(self.checkimg == "0")
       {
        imgstr1 = image
        btnverification.setBackgroundImage(image, for: .normal)
        }
        if(self.checkimg == "1"){
             imgstr2 = image
        btninsurance.setBackgroundImage(image, for: .normal)
        }
        if(self.checkimg == "2"){
             imgstr3 = image
         btnuberdriver.setBackgroundImage(image, for: .normal)
            
        }
        if(self.checkimg == "3"){
            imgstr4 = image
         btndriver.setBackgroundImage(image, for: .normal)
        }
        
        
        self.dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    var click = "0"
    @objc func insuranceview1()
    {
        if(click == "0"){
            
            click = "1"
         insurancrheight.constant = 128
            lblinsurance.textColor = UIColor(red:0.00, green:0.48, blue:0.00, alpha:1.0)
            lblfirst.isHidden = false
            firstview.isHidden = false
            insuranceview.layer.borderWidth = 1
            insuranceview.layer.cornerRadius = 15
            insuranceview.layer.borderColor = UIColor.black.cgColor
            imginsurance.isHidden = false
        }else{
            click = "0"
            insurancrheight.constant = 0
            lblinsurance.textColor = UIColor.black
            lblfirst.isHidden = true
            firstview.isHidden = true
             imginsurance.isHidden = true
        }
     
    }

    var click1 = "0"
    @objc func driverview1()
    {
        if(click1 == "0"){
            
            click1 = "1"
            uberheight.constant = 128;
            lbldriver.textColor = UIColor(red:0.00, green:0.48, blue:0.00, alpha:1.0)
            secondview.isHidden = false
            lblsecondview.isHidden = false
            driverview.layer.borderWidth = 1
            driverview.layer.cornerRadius = 15
            driverview.layer.borderColor = UIColor.black.cgColor
             imgdriver.isHidden = false
        }else{
            click1 = "0"
            uberheight.constant = 0;
            lbldriver.textColor = UIColor.black
            secondview.isHidden = true
            lblsecondview.isHidden = true
             imgdriver.isHidden = true
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
    
    
    @IBAction func attechverification(_ sender: Any) {
        showActionSheet(img: "0")
        
    }
    
    @IBAction func insuranceattech(_ sender: Any) {
         showActionSheet(img: "1")
    }
    
    @IBAction func homeinsuranceattech(_ sender: Any) {
         showActionSheet(img: "2")
    }
    
    @IBAction func uberattech(_ sender: Any) {
         showActionSheet(img: "3")
    }
    @IBAction func btnnextaction(_ sender: Any) {
        
      let image = UIImage()
        if(imgstr1 == UIImage(named:"")){
            let alert = UIAlertController(title: "Alert", message: "Please select driver verification", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
       else if(imgstr2 == UIImage(named:"")){
            let alert = UIAlertController(title: "Alert", message: "Please select driver insurance", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
      else  if(imgstr3 == UIImage(named:"")){
            let alert = UIAlertController(title: "Alert", message: "Please select driver home insurance", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
      else  if(imgstr4 == UIImage(named:"")){
            let alert = UIAlertController(title: "Alert", message: "Please Enter City", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        else
        {
            
            
            SVProgressHUD.show()
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        var url = NSURL(string:WebServiceClass().BaseURL + "driver/update/document")
        let token = UserDefaults.standard.value(forKey: "devicetoken") as! String
        let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
        let URL = try! URLRequest(url: "http://innoviussoftware.com/greego/public/api/driver/update/document", method: .post, headers: headers)

        Alamofire.upload(multipartFormData: { MultipartFormData in
         
            let maximumSize : CGFloat = 400*400
            var compressRatio = CGFloat()
            let imageSize1 : CGFloat = self.imgstr1!.size.width * self.imgstr1!.size.height
            let imageSize2: CGFloat = self.imgstr2!.size.width * self.imgstr2!.size.height
            let imageSize3 : CGFloat = self.imgstr3!.size.width * self.imgstr3!.size.height
            let imageSize4 : CGFloat = self.imgstr4!.size.width * self.imgstr4!.size.height

            if imageSize1 < maximumSize {
                compressRatio = 1
            }
                
            else {
                compressRatio = maximumSize / imageSize1
            }
            if imageSize2 < maximumSize {
                compressRatio = 1
            }
                
            else {
                compressRatio = maximumSize / imageSize2
            }
            if imageSize3 < maximumSize {
                compressRatio = 1
            }
                
            else {
                compressRatio = maximumSize / imageSize3
            }
            if imageSize4 < maximumSize {
                compressRatio = 1
            }
                
            else {
                compressRatio = maximumSize / imageSize4
            }
            
            var  image1 = UIImageJPEGRepresentation(self.imgstr1!, 2.0)
            MultipartFormData.append(image1!, withName: "driving_license", fileName: "swift_file.jpg", mimeType: "image/jpeg")
         
            var image2 = UIImageJPEGRepresentation(self.imgstr2!, 2.0)
            MultipartFormData.append(image2!, withName: "insurance_card", fileName: "swift_file.jpg", mimeType: "image/jpeg")
            
            var image3 = UIImageJPEGRepresentation(self.imgstr3!, 2.0)
                MultipartFormData.append(image3!, withName: "home_insurance", fileName: "swift_file.jpg", mimeType: "image/jpeg")
            
            let image4 = UIImageJPEGRepresentation(self.imgstr4!, 2.0)
            MultipartFormData.append(image4!, withName: "current_driver", fileName: "swift_file.jpg", mimeType: "image/jpeg")
            
        },   usingThreshold: UInt64.init(), to:"http://innoviussoftware.com/greego/public/api/driver/update/document", method: .post, headers: headers)  { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    
                    switch response.result {
                    case .success(let JSON):
                    //do json stuff
                        print(response.result.value!)
                        
                        
                        SVProgressHUD.dismiss()
                        var dic = response.result.value as! NSDictionary
                        
                        
                        
                        
                        if(dic.value(forKey: "error_code") as! NSNumber == 0)
                        {
                            
                            var datadic :NSDictionary = dic.value(forKey: "data") as! NSDictionary
                            let profilestatus = datadic.value(forKey: "profile_status") as! NSNumber
                            
                            let user = UserDefaults.standard
                            
                            user.set(profilestatus.stringValue, forKey: "profilestatus")
                            user.synchronize()
                            
                            
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DriverbankViewController") as! DriverbankViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                           
                        }
                        else
                        {
                            let alert = UIAlertController(title: "Alert", message:dic.value(forKey: "message") as! String, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                        
                        
                    case .failure(let error):
                        SVProgressHUD.dismiss()

                        if error._code == NSURLErrorTimedOut {
                            //HANDLE TIMEOUT HERE
                        }
                        print("\n\nAuth request failed with error:\n \(error)")
                    }
                    
                    
              
                    
                    
                    
                }
            case .failure(let error):
                SVProgressHUD.dismiss()

                if error._code == NSURLErrorTimedOut {
                    let alert = UIAlertController(title: "Alert", message: "Request Timeout", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)                }
                
                print("Error in upload: \(error.localizedDescription)")
       
        }
        }

        }
        
    }
    
   
}

