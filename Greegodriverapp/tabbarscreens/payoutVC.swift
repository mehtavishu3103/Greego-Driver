//
//  payoutVC.swift
//  Greegodriverapp
//
//  Created by Ravi Dubey on 4/19/18.
//  Copyright © 2018 Harshal Shah. All rights reserved.
//

import UIKit

class payoutVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        let cell: PayoutActivityCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PayoutActivityCell
        
        return cell
        
        
        
    }

    // MARK: - IBaction
    
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)

        
        
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
