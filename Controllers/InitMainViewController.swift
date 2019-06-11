//
//  InitMainViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 07/06/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

class InitMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //Check if the Terms and Conditions are already accepted and the How to use the app should be shown
        if UserDefaults.standard.object(forKey: "agreed") != nil && UserDefaults.standard.bool(forKey: "agreed"){
            //Terms and Conditions are already accepted
            print("Terms and conditions accepted")
            if UserDefaults.standard.object(forKey: "useApp") != nil && UserDefaults.standard.bool(forKey: "useApp"){
                //The How to use the app info should NOT be shown
                performSegue(withIdentifier: "initToRightsAppSegue", sender: nil)
            }else{
                //The How to use the app info should be shown
                performSegue(withIdentifier: "initToHowToUseAppSegue", sender: nil)
                print("How to use the app should be shown")
            }
        } else {
            //Terms and Conditions are not accepted yet
            performSegue(withIdentifier: "initToTermsConditionsSegue", sender: nil)
            print("Terms and conditions should be shown")
        }
        copyDatabaseIfNeeded("rightsapp_v5_utf16")
    }
    
    func copyDatabaseIfNeeded(_ database: String) {
        
        let fileManager = FileManager.default
        let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        guard documentsUrl.count != 0 else {
            return
        }
        
        let finalDatabaseURL = documentsUrl.first!.appendingPathComponent("\(database).db")
        
        if !( (try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
            print("DB does not exist in documents folder")
            let databaseInMainBundleURL = Bundle.main.resourceURL?.appendingPathComponent("\(database).db")
            
            do {
                try fileManager.copyItem(atPath: (databaseInMainBundleURL?.path)!, toPath: finalDatabaseURL.path)
            } catch let error as NSError {
                print("Couldn't copy file to final location! Error:\(error.description)")
            }
            
        } else {
            print("Database file found at path: \(finalDatabaseURL.path)")
        }
    }

}
