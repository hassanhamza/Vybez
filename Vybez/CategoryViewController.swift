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
    @IBOutlet weak var titleButton: UIButton!
    var titleCell = String()
    
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
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryViewCell") as! CategoryViewCell
        
        if (indexPath.row == 0) {
            cell.categoryImage.image = UIImage(named: "categoriesNight")
            titleCell = "Night Life"
        }
        if (indexPath.row == 1) {
            cell.categoryImage.image = UIImage(named: "categoriesLiveshows")
            titleCell = "Live Shows"
        }
        if (indexPath.row == 2) {
            cell.categoryImage.image = UIImage(named: "categoriesCollege")
            titleCell = "College Events"
        }
        if (indexPath.row == 3) {
            cell.categoryImage.image = UIImage(named: "categoriesLounges")
            titleCell = "Lounges"
        }
        if (indexPath.row == 4) {
            cell.categoryImage.image = UIImage(named: "categoriesNetworking")
            titleCell = "Networking"
        }
        if (indexPath.row == 5) {
            cell.categoryImage.image = UIImage(named: "categoriesArt")
            titleCell = "Arts&Entertainment"
        }
        if (indexPath.row == 6) {
            cell.categoryImage.image = UIImage(named: "categoriesMiscellanous")
            titleCell = "Miscellanous"
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryViewCell") as! CategoryViewCell
        
        if (indexPath.row == 0) {
            cell.categoryImage.image = UIImage(named: "categoriesNightLife")
            titleCell = "Night Life"
        }
        if (indexPath.row == 1) {
            titleCell = "Live Shows"
        }
        if (indexPath.row == 2) {
            titleCell = "College Events"
        }
        if (indexPath.row == 3) {
            titleCell = "Lounges"
        }
        if (indexPath.row == 4) {
            titleCell = "Networking"
        }
        if (indexPath.row == 5) {
            titleCell = "Arts&Entertainment"
        }
        if (indexPath.row == 6) {
            titleCell = "Miscellanous"
        }

        
        let viewController:DetailDiscoveryViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailDiscoveryViewController") as! DetailDiscoveryViewController
        viewController.titleNav = titleCell
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
