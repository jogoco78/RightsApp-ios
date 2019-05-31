//
//  TermsConditionsViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 31/05/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

class TermsConditionsViewController: UIViewController {

    @IBOutlet weak var tv_ownership: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let s = NSLocalizedString("xuQ-ZP-tMN.text",comment: "Comment")
        tv_ownership.text = s
        
        print(s)
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
