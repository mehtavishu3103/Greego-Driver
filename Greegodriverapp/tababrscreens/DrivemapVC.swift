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

    @IBOutlet weak var userMapView: GMSMapView!
    
    @IBOutlet weak var imguser: UIImageView!
    
    @IBOutlet weak var viewupdate: UIView!
    
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
         setLocation()
  
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
        
        self.setLocation()

        // Do any additional setup after loading the view.
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
        
        let marker = GMSMarker(position: center)
        
        print("Latitude :- \(userLocation!.coordinate.latitude)")
        print("Longitude :-\(userLocation!.coordinate.longitude)")
        marker.map = self.userMapView
        
        marker.title = "Current Location"
        locationManager.stopUpdatingLocation()
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
