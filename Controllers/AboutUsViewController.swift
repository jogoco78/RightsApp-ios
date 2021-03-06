//
//  AboutUsViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 25/06/2019.
//  Copyright © 2019 Jorge Gonzalez Conejero. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var tvAboutUs: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tabBarItem.title = NSLocalizedString("us",comment: "")
        
        //line spacing
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        
        var s = NSMutableAttributedString(string: NSLocalizedString("aboutUs",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        let attributedText = s
        
        s = NSMutableAttributedString(string: NSLocalizedString("aboutUsBody",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        attributedText.append(s)
        
        tvAboutUs.attributedText = attributedText
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarItem.title = NSLocalizedString("us",comment: "")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarItem.title = ""
    }
}
