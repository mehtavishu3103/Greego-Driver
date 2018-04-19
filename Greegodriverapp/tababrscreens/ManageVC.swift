//
//  ManageVC.swift
//  Greegodriverapp
//
//  Created by Ravi Dubey on 4/18/18.
//  Copyright © 2018 Harshal Shah. All rights reserved.
//

import UIKit

class ManageVC: UIViewController {

    
    @IBOutlet weak var txtseadn: UITextField!
    
    @IBOutlet weak var txtsuv: UITextField!
    
    @IBOutlet weak var txtvan: UITextField!
    
    @IBOutlet weak var txtautomatic: UITextField!
    
    @IBOutlet weak var txtmanual: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        self.view.backgroundColor = UIColor(red:0.87, green:0.87, blue:0.87, alpha:1.0)
        useUnderline(textfield: txtseadn)
        useUnderline(textfield: txtsuv)
        useUnderline(textfield: txtvan)
        useUnderline(textfield: txtautomatic)
        useUnderline(textfield: txtmanual)

        
        setrightView(textfield: txtseadn)
        setrightView(textfield: txtsuv)

        //setLeftView(textfield: txtvan)

        setrightView(textfield: txtautomatic)
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
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor(red:0.00, green:1.00, blue:0.84, alpha:1.0).cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :textfield.frame.size.height - borderWidth), size: CGSize(width: textfield.frame.size.width, height: textfield.frame.size.height))
        border.borderWidth = borderWidth
        textfield.layer.addSublayer(border)
        textfield.layer.masksToBounds = true
    }
    
    
    
    
    func setrightView(textfield:UITextField)
    {
        textfield.contentMode = .scaleToFill
        
        let imageView = UIImageView.init(image: #imageLiteral(resourceName: "home"))
        imageView.frame = CGRect(x: 0, y: 0, width: textfield.frame.size.height-10, height: textfield.frame.size.height-10)
        
        textfield.rightViewMode = UITextFieldViewMode.always
        
        //txtSearchPlace.addSubview(imageView)
        textfield.rightView = imageView
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
