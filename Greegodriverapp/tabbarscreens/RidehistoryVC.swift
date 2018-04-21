//
//  RidehistoryVC.swift
//  Greegodriverapp
//
//  Created by Ravi Dubey on 4/19/18.
//  Copyright © 2018 Harshal Shah. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
class RidehistoryVC: UIViewController {

    @IBOutlet weak var mapview: GMSMapView!
    
    @IBOutlet weak var lblstart: UILabel!
    
    @IBOutlet weak var lblend: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedStringKey.foregroundColor : UIColor(red:0.00, green:0.58, blue:0.59, alpha:1.0)]
        let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 10), NSAttributedStringKey.foregroundColor : UIColor.black]
        
        let attributedString1 = NSMutableAttributedString(string:"S", attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:"tart", attributes:attrs2)
        let attributedString3 = NSMutableAttributedString(string:"E", attributes:attrs1)
        let attributedString4 = NSMutableAttributedString(string:"nd", attributes:attrs2)
        
        attributedString1.append(attributedString2)
        attributedString3.append(attributedString4)
        
        self.lblstart.attributedText = attributedString1
        self.lblend.attributedText = attributedString3
        let center = CLLocationCoordinate2D(latitude: 22.9962, longitude: 72.5996)
        
        let center1 = CLLocationCoordinate2D(latitude:23.013413, longitude: 72.56241)
        
      let camera = GMSCameraPosition.camera(withLatitude:23.0134, longitude: 72.56241, zoom:18);
       self.mapview.camera = camera
        
        
        let marker = GMSMarker()
        marker.position = center
        marker.title = "Maninager"
        marker.appearAnimation = .pop
        marker.map = self.mapview
        marker.icon = UIImage(named:"pin")
        
        let marker1 = GMSMarker()
        marker1.position = center1
        marker1.title = "Paladi"
        marker1.appearAnimation = .pop
        marker1.map = self.mapview
        marker1.icon = UIImage(named:"pin")

        getPolylineRoute(from: center, to: center1)
     
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - IBaction methods

    
    @IBAction func back(_ sender: Any) {
        
        
        navigationController?.popToRootViewController(animated: true)

        
        
    }
    
    
    
    
    
    
    
    
    //MARK: - USER DEFINE FUNCTIONS
    
    
    func getPolylineRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
        
        
        Alamofire.request("http://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving", method: .post, parameters: [:], encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    print(response.result.value!)
                    
                    let dic =  response.result.value! as! NSDictionary
                    let routes = dic["routes"] as? [Any]
                    let overview_polyline = routes?[0] as?[String:Any]
                    let polyString = overview_polyline?["overview_polyline"] as? NSDictionary
                    let final = polyString?.value(forKey:"points") as! String
                    //Call this method to draw path on map
                    self.showPath(polyStr: final)
                    DispatchQueue.main.async {
                        
                  
               
                    }
                }
                break
                
            case .failure(_):
                print(response.result.error)
                break
                
            }
        }
        
        
        
        
        
        
        
        
        
    }
    
    func showPath(polyStr :String){
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 4.0
        polyline.strokeColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        polyline.map = self.mapview // Your map view
        mapview.animate(with: GMSCameraUpdate.fit(GMSCoordinateBounds(path: path!), withPadding: 10))

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
