//
//  CustomTabBarController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 25/06/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {

    var rightsAppViewController: RightsAppViewController!
    var languageViewController: LanguageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        rightsAppViewController = RightsAppViewController()
        languageViewController = LanguageViewController()
        
        rightsAppViewController.tabBarItem.title = "Hello"
        languageViewController.tabBarItem.title = "Bye"
        
        viewControllers = [rightsAppViewController, languageViewController]
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
