//
//  HowToUseTheAppTextViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 05/06/2019.
//  Copyright © 2019 Jorge Gonzalez Conejero. All rights reserved.
//

import UIKit

class HowToUseTheAppTextViewController: UIViewController {

    @IBOutlet weak var tvHowUseAppText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tabBarItem.title = NSLocalizedString("use",comment: "")
        
        //line spacing
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        
        //How to use the app
        var s = NSMutableAttributedString(string: NSLocalizedString("howToUseTheApp",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let attributedText = s
        //Bottom menu
        s = NSMutableAttributedString(string: NSLocalizedString("bottomMenu",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("bottomMenuBody",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        //How the App works
        s = NSMutableAttributedString(string: NSLocalizedString("howTheAppWorks",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("howTheAppWorksBody",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        
        //Sets the attributted text to the textview
        tvHowUseAppText.attributedText = attributedText
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarItem.title = NSLocalizedString("use",comment: "")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarItem.title = NSLocalizedString("",comment: "")
    }

}
