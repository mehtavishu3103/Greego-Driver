//
//  EarningVC.swift
//  Greegodriverapp
//
//  Created by Ravi Dubey on 4/18/18.
//  Copyright © 2018 Harshal Shah. All rights reserved.
//

import UIKit

class EarningVC: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var imguser: UIImageView!
    
    @IBOutlet weak var payoutview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    payoutview.layer.cornerRadius = 12.0
        
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        imguser.addGestureRecognizer(tap)
        if revealViewController() != nil
        {
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: Amountcell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Amountcell
        cell.view.layer.cornerRadius = 12.0
        
        return cell
        
        
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RidehistoryVC") as! RidehistoryVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
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
