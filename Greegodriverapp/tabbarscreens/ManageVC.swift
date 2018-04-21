//
//  ManageVC.swift
//  Greegodriverapp
//
//  Created by Ravi Dubey on 4/18/18.
//  Copyright © 2018 Harshal Shah. All rights reserved.
//

import UIKit

class ManageVC: UIViewController {
    
    @IBOutlet weak var view1: UILabel!
    
    @IBOutlet weak var lbl2: UILabel!
    
    @IBOutlet weak var lbl3: UILabel!
    
    @IBOutlet weak var lbl4: UILabel!
    
    @IBOutlet weak var lbl5: UILabel!
    
    @IBOutlet weak var lbltime: UILabel!
    
    @IBOutlet weak var imguser: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view1.layer.cornerRadius = view1.frame.width/2
        lbl2.layer.cornerRadius = lbl2.frame.width/2
        lbl3.layer.cornerRadius = lbl3.frame.width/2
        lbl4.layer.cornerRadius = lbl4.frame.width/2
        lbl5.layer.cornerRadius = lbl5.frame.width/2
view1.clipsToBounds = true
        lbl2.clipsToBounds = true
        lbl3.clipsToBounds = true
        lbl4.clipsToBounds = true
        lbl5.clipsToBounds = true

        
        lbltime.layer.borderWidth = 1.0
        lbltime.layer.borderColor = UIColor.darkGray.cgColor
        let tap = UITapGestureRecognizer()
        tap.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        imguser.addGestureRecognizer(tap)
        if revealViewController() != nil
        {
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
            //  viewFirstPopUp.isHidden = true
            //  self.setShadow()
            //   self.showFirstPopUp()
            
            
            
            
        }
    
        self.view.backgroundColor = UIColor(red:0.87, green:0.87, blue:0.87, alpha:1.0)
       
       // setLeftView(textfield: txtmanual)


        // Do any additional setup after loading the view.
    }

    // MARK: - IBAction Methods

    
    @IBAction func shareaction(_ sender: Any) {
        
        let shareText = "Hello, world!"
        
       
            let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
            present(vc, animated: true)
     
        
        
        
    }
    
    // MARK: - user define functions

    func useUnderline(textfield:UITextField) {

        textfield.layer.masksToBounds = true

        var border = CALayer()
        var width = CGFloat(1.0)
        border.borderColor = UIColor(red:0.00, green:1.00, blue:0.84, alpha:1.0).cgColor
        border.frame = CGRect(x: 0, y: textfield.frame.size.height - width, width: textfield.frame.size.width, height: textfield.frame.size.height)
        
        border.borderWidth = width
        textfield.backgroundColor = UIColor.clear
        textfield.layer.addSublayer(border)
        
    }
    
    
    
    
    func setrightView(textfield:UITextField)
    {
        textfield.contentMode = .scaleToFill
        
        let imageView = UIImageView.init(image: #imageLiteral(resourceName: "help"))
        imageView.frame = CGRect(x: 0, y: 0, width: textfield.frame.size.height-10, height: textfield.frame.size.height-10)
        
        textfield.rightViewMode = UITextFieldViewMode.always
        
      textfield.addSubview(imageView)
        textfield.rightView = imageView
        textfield.textRect(forBounds: textfield.bounds)
        textfield.placeholderRect(forBounds: textfield.bounds)
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
