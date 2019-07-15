//
//  InitViewController.swift
//  RightsApp
//
//  Created by Jorge Gonzalez Conejero on 03/07/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

class InitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //UserDefaults.standard.set(false, forKey: "useApp")
        //UserDefaults.standard.set(true, forKey: "agreed")
        //Check if the Terms and Conditions are already accepted and the How to use the app should be shown
        //performSegue(withIdentifier: "InitToTermsSegue", sender: nil)
        if UserDefaults.standard.object(forKey: "agreed") != nil && UserDefaults.standard.bool(forKey: "agreed"){
            //Terms and Conditions are already accepted
            if UserDefaults.standard.object(forKey: "useApp") != nil && UserDefaults.standard.bool(forKey: "useApp"){
                //The How to use the app info should NOT be shown
                performSegue(withIdentifier: "InitToMainSegue", sender: nil)
            }else{
                //The How to use the app info should be shown
                performSegue(withIdentifier: "InitToHowToSegue", sender: nil)
            }
        } else {
            //Terms and Conditions are not accepted yet
            performSegue(withIdentifier: "InitToTermsSegue", sender: nil)
        }
    }
}
