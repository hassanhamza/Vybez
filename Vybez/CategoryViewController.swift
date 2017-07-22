//
//  CategoryViewController.swift
//  Vybez
//
//  Created by Hassan on 6/13/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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

extension CategoryViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryViewCell") as! CategoryViewCell
        
        if (indexPath.row == 0) {
            cell.categoryImage.image = UIImage(named: "nightLife")
        }
        if (indexPath.row == 1) {
            cell.categoryImage.image = UIImage(named: "liveshows")
        }
        if (indexPath.row == 2) {
            cell.categoryImage.image = UIImage(named: "collegeEvents")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailDiscoveryViewController") as! DetailDiscoveryViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
