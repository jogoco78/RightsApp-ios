//
//  RightsAppViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 04/06/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

class RightsAppViewController: UIViewController {

    
    @IBOutlet weak var bt_emergencyCallText: UIButton!
    @IBOutlet weak var bt_questionnaireText: UIButton!
    @IBOutlet weak var bt_searchEntityText: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bt_emergencyCallText.setTitle(NSLocalizedString("emergencyCallText",comment: ""),for: .normal)
        bt_questionnaireText.setTitle(NSLocalizedString("questionnaireText",comment: ""),for: .normal)
        bt_searchEntityText.setTitle(NSLocalizedString("searchEntityText",comment: ""),for: .normal)
    }
    
    @IBAction func bt_emergencyCall(_ sender: UIButton) {
        performSegue(withIdentifier: "rightsAppToEmergencyCallSegue", sender: nil)
    }
    @IBAction func bt_emergencyCallText(_ sender: UIButton) {
        performSegue(withIdentifier: "rightsAppToEmergencyCallSegue", sender: nil)
    }
    
    @IBAction func bt_questionnaire(_ sender: UIButton) {
        performSegue(withIdentifier: "rightsAppToQuestionnaireSegue", sender: nil)
    }
    @IBAction func bt_questionnaireText(_ sender: Any) {
        performSegue(withIdentifier: "rightsAppToQuestionnaireSegue", sender: nil)
    }
    
    @IBAction func bt_searchEntity(_ sender: UIButton) {
        performSegue(withIdentifier: "rightsAppToSearchEntitySegue", sender: nil)
    }
    
    @IBAction func bt_searchEntityText(_ sender: UIButton) {
        performSegue(withIdentifier: "rightsAppToSearchEntitySegue", sender: nil)
    }
    
    
    
    /*
     @IBAction func bt_questionnaireText(_ sender: UIButton) {
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
