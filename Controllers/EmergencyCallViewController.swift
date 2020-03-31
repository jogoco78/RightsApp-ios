//
//  EmergencyCallViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 20/06/2019.
//  Copyright © 2019 Jorge Gonzalez Conejero. All rights reserved.
//

import UIKit

class EmergencyCallViewController: UIViewController {

    @IBOutlet weak var btEmergencyCall: UIButton!
    @IBOutlet weak var tvEmergencyCall: UITextView!
    
    @IBOutlet weak var btFinish: UIButton!
    @IBOutlet weak var btCall: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tvEmergencyCall.text = NSLocalizedString("emergencyCallText",comment: "")
        btFinish.setTitle(NSLocalizedString("home",comment: ""), for: .normal)
        btCall.setTitle(NSLocalizedString("call",comment: ""), for: .normal)
    }
    
    @IBAction func btEmergencyCallTouch(_ sender: UIButton) {
        guard let number = URL(string: "tel://" + Constants.shared.emergencyCall) else { return }
        UIApplication.shared.open(number)
    }
    
    @IBAction func btFinish(_ sender: UIButton) {
        performSegue(withIdentifier: "toMain", sender: nil)
    }
    
    @IBAction func btCall(_ sender: Any) {
        guard let number = URL(string: "tel://" + Constants.shared.emergencyCall) else { return }
        UIApplication.shared.open(number)
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
