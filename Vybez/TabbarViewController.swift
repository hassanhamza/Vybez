//
//  TabbarViewController.swift
//  Vybez
//
//  Created by Hassan on 6/5/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit

class TabbarViewController: RaisedTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.insertEmptyTabItem("", atIndex: 2)
        let screenSize:CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        if (screenWidth == 320) {
            self.addRaisedButton(UIImage(named:"plus signoff"), highlightImage: nil, offset:-10.0, show:true)
        }else if(screenWidth == 375){
            self.addRaisedButton(UIImage(named:"plus signoff"), highlightImage: nil, offset:-10.0, show:true)
        }else if(screenWidth == 414){
            self.addRaisedButton(UIImage(named:"plus signoff"), highlightImage: nil, offset:-3.0, show:true)
        }
        
        self.navigationController?.isNavigationBarHidden = true
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

extension RaisedTabBarController:UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if(selectedIndex == 2){
            self.addRaisedButton(UIImage(named:"plus sign"), highlightImage: nil, offset:-5.0, show: true)
        }
        else{
            self.addRaisedButton(UIImage(named:"plus signoff"), highlightImage: nil, offset:-5.0, show: true)
        }
    }
}

