//
//  DrivemapVC.swift
//  Greegodriverapp
//
//  Created by Ravi Dubey on 4/17/18.
//  Copyright © 2018 Harshal Shah. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
import GooglePlaces
class DrivemapVC: UIViewController,CLLocationManagerDelegate {

    
    
    @IBOutlet weak var btnprofilecheck: UIButton!
    
    var profilestatus: NSNumber?
    
    @IBOutlet weak var heightview: NSLayoutConstraint!
    
    @IBOutlet weak var btnfinish: UIButton!
    
    @IBOutlet weak var imgerror: UIImageView!
    
    @IBOutlet weak var line2: UILabel!
    
    @IBOutlet weak var line1: UILabel!
    @IBOutlet weak var lblstatus: UILabel!
    
    @IBOutlet weak var userMapView: GMSMapView!
    
    @IBOutlet weak var imguser: UIImageView!
    
    @IBOutlet weak var viewupdate: UIView!
    
    @IBOutlet weak var btnfinidh: UIButton!
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
         setLocation()
        line2.isHidden = true
        line1.isHidden = true
        imgerror.isHidden = true
        lblstatus.isHidden = true
btnfinidh.isHidden = true
        btnfinidh.layer.cornerRadius = 18.0
        
        
        
        
  heightview.constant = 62
        
        
        let tap1 = UITapGestureRecognizer()
        
        tap1.addTarget(self, action: #selector(tapview))
        
        viewupdate.addGestureRecognizer(tap1)
       let tap = UITapGestureRecognizer()
        tap.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        imguser.addGestureRecognizer(tap)
        viewupdate.layer.shadowColor = UIColor.lightGray.cgColor
        viewupdate.layer.shadowOpacity = 0.5
        viewupdate.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewupdate.layer.shadowRadius = 2
        viewupdate.layer.cornerRadius = 12.0
        if revealViewController() != nil
        {
           
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
            //  viewFirstPopUp.isHidden = true
            //  self.setShadow()
            //   self.showFirstPopUp()
            
           
            
            
        }
        
        if let key = UserDefaults.standard.object(forKey: "profilestatus")
        {
            
            let status = UserDefaults.standard.string(forKey: "profilestatus") as! String
            print(status)
            if(status == "7")
            {
                btnprofilecheck.isHidden = true

                let status1 = UserDefaults.standard.string(forKey: "isaprroved") as! String

                if(status1 == "0")
                {
                    btnprofilecheck.isHidden = true
                    lblstatus.text = "Your Applicatio is on under review"

                    
                }
                else
                
                {
                    
                    btnprofilecheck.isHidden = true

                    lblstatus.text = "Your profile is 40% completed"

                    
                }
            
                
                
            }
            else{
                 btnprofilecheck.isHidden = false
            }
        }
        
        self.setLocation()

        // Do any additional setup after loading the view.
    }

    @objc func tapview()
    
   {
    
    line2.isHidden = false
    line1.isHidden = false
    imgerror.isHidden = false
    lblstatus.isHidden = false
    btnfinidh.isHidden = false
    
    heightview.constant = 190
    
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error" , Error.self)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let userLocation = locations.last
        let center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        
        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude, zoom: 15);
        self.userMapView.camera = camera
        self.userMapView.isMyLocationEnabled = true
     
        
        locationManager.stopUpdatingLocation()
    }
    //MARK: - IBAction Methods
    
    
    @IBAction func erroraction(_ sender: Any) {
        
        
        line2.isHidden = false
        line1.isHidden = false
        imgerror.isHidden = false
        lblstatus.isHidden = false
        btnfinidh.isHidden = false
        
        heightview.constant = 190
        
    
        
    }
    
  
    @IBAction func finishaction(_ sender: Any) {
     
        if let key = UserDefaults.standard.object(forKey: "profilestatus")
        {
            
        let status = UserDefaults.standard.string(forKey: "profilestatus") as! String
            print(status)
            if(status == "1")
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DriverpersonalinfoViewController") as! DriverpersonalinfoViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            }
            
            if(status == "2")
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DrivershippingaddViewController") as! DrivershippingaddViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            }
            if(status == "3")
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DriverdocumentViewController") as! DriverdocumentViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            }
            
            if(status == "4")
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DriverbankViewController") as! DriverbankViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            }
            if(status == "5")
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DrivertypeViewController") as! DrivertypeViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            }
            if(status == "6")
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DriverprofileViewController") as! DriverprofileViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            }
          
            
            
        }
        
        
        

    }
    
    
    //MARK: - USER DEFINE FUNCTIONS
    
    
    func setLocation()
    {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
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
