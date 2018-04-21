//
//  DriverprofileViewController.swift
//  Greegodriverapp
//
//  Created by Harshal Shah on 4/11/18.
//  Copyright © 2018 Harshal Shah. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
class DriverprofileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var btnprofile: UIButton!
    
    @IBOutlet weak var viewprofile: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
 let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        // Do any additional setup after loading the view.
        
        btnprofile.layer.cornerRadius = btnprofile.frame.width/2
        btnprofile.clipsToBounds = true
        
    }

    @objc func imageTapped(gesture:UIGestureRecognizer) {
        if let profile1Pic = gesture.view as? UIImageView {
            print("Image Tapped")
           // showActionSheet()
        }
    }
    
    func camera()
    {
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    func photoLibrary()
    {
        
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    func showActionSheet(img:String) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    var imgstr = "";
    var checkimg = "0";
    var imgstr1 = UIImage();
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
   
   var image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        if(self.checkimg == "0")
        {
            imgstr1 = image
            btnprofile.setBackgroundImage(image, for: .normal)
        }
       
        self.dismiss(animated: true, completion: nil)
      
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnprofileaction(_ sender: Any) {
        
      
        showActionSheet(img: "0")
    }
    
    
    @IBAction func btnnextaction(_ sender: Any) {
        
       SVProgressHUD.show()
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        var url = NSURL(string: "http://innoviussoftware.com/greego/public/api/driver/update/profile_pic")
        let token = UserDefaults.standard.value(forKey: "devicetoken") as! String
        let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
        let URL = try! URLRequest(url: "http://innoviussoftware.com/greego/public/api/driver/update/profile_pic", method: .post, headers: headers)
        
        manager.upload(multipartFormData: { MultipartFormData in
            
            let maximumSize : CGFloat = 400*400
            var compressRatio = CGFloat()
            let imageSize1 : CGFloat = self.imgstr1.size.width * self.imgstr1.size.height
           
            
            if imageSize1 < maximumSize {
                compressRatio = 1
            }
                
            else {
                compressRatio = maximumSize / imageSize1
            }
            
            
            var  image1 = UIImageJPEGRepresentation(self.imgstr1, 2.0)
            MultipartFormData.append(image1!, withName: "image", fileName: "swift_file.jpg", mimeType: "image/jpeg")
           
        },   usingThreshold: UInt64.init(), to:"http://innoviussoftware.com/greego/public/api/driver/update/profile_pic", method: .post, headers: headers)  { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print(response.result.value!)
                    
                    SVProgressHUD.dismiss()
                    var dic = response.result.value as! NSDictionary
                    var datadic :NSDictionary = dic.value(forKey: "data") as! NSDictionary
                    let profilestatus = datadic.value(forKey: "profile_status") as! Int
                    let status = profilestatus as! NSNumber
                    
                    let user = UserDefaults.standard
                    user.set(status.stringValue, forKey:"profilestatus")
                    user.synchronize()
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                    if let err = response.error{
                        return
                    }
                }
            case .failure(let error):
                SVProgressHUD.dismiss()

                print("Error in upload: \(error.localizedDescription)")
                
            }
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
    
}
