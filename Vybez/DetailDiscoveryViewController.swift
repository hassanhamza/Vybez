//
//  DetailDiscoveryViewController.swift
//  Vybez
//
//  Created by Hassan on 6/21/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit

class DetailDiscoveryViewController: UIViewController {

    @IBOutlet weak var DetailTextview: UITextView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
        let image = UIImage(named:"header")
        UINavigationBar.appearance().setBackgroundImage(image?.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "back"), for: UIControlState.normal)
        button.frame = CGRect.init(x: 0, y: 0, width: 25, height: 17)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = barButton

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
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

extension DetailDiscoveryViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailDiscoverViewCell") as! DetailDiscoverViewCell
        
//        if (indexPath.row == 0) {
//            cell.categoryImage.image = UIImage(named: "nightLife")
//        }
//        if (indexPath.row == 1) {
//            cell.categoryImage.image = UIImage(named: "liveshows")
//        }
//        if (indexPath.row == 2) {
//            cell.categoryImage.image = UIImage(named: "collegeEvents")
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventDetailController") as! EventDetailController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

