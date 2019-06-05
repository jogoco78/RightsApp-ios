//
//  HowToUseTheAppViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 04/06/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

class HowToUseTheAppViewController: UIViewController {

    @IBOutlet weak var tvHowToUseTheApp: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
        tvHowToUseTheApp.attributedText = attributedText
    }
    
    @IBAction func buttonNotShowAgain(_ sender: UIButton) {
        performSegue(withIdentifier: "RightsAppUseApp", sender: nil)
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
