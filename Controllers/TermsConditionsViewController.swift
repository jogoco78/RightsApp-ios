//
//  TermsConditionsViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 31/05/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

class TermsConditionsViewController: UIViewController {
    
    @IBOutlet weak var tvTermsConditions: UITextView!
    @IBOutlet weak var acceptTermsSwitch: UISwitch!
    @IBOutlet weak var tvAcceptTermsConditions: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //line spacing
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        
        //App ownership
        var s = NSMutableAttributedString(string: NSLocalizedString("appOwnership",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let attributedText = s
        s = NSMutableAttributedString(string: NSLocalizedString("appOwnershipBody",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        
        //Terms and conditions
        s = NSMutableAttributedString(string: NSLocalizedString("termsConditions",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("termsConditionsBody",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        
        //Privacy policy
        s = NSMutableAttributedString(string: NSLocalizedString("privacyPolicy",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("privacyPolicyBody",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        
        //Personal data
        s = NSMutableAttributedString(string: NSLocalizedString("personalData",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("personalDataBody",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        
        //Links to external sites
        s = NSMutableAttributedString(string: NSLocalizedString("linksToExternalSites",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("linksToExternalSitesBody",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        
        //Aggregated statistics
        s = NSMutableAttributedString(string: NSLocalizedString("aggregatedStatistics",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("aggregatedStatisticsBody",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        
        //Google Analytics
        s = NSMutableAttributedString(string: NSLocalizedString("googleAnalytics",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("googleAnalyticsBody",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        
        //Privacy policy changes
        s = NSMutableAttributedString(string: NSLocalizedString("privacyPolicyChanges",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("privacyPolicyChangesBody",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        
        //Sets the attributed text to the TextView
        tvTermsConditions.attributedText = attributedText
        
        //Sets the attributed text to accept terms and conditions
        s = NSMutableAttributedString(string: NSLocalizedString("labelTermsConditions",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        tvAcceptTermsConditions.attributedText = s
        
        //Sets the switch to the stored value
        if UserDefaults.standard.object(forKey: "agreed") != nil {
            acceptTermsSwitch.setOn(UserDefaults.standard.bool(forKey: "agreed"), animated: true)
        } else {
            acceptTermsSwitch.setOn(false, animated: true)
        }
    }
    
    //Stores if the user agreeds with the terms and conditions
    @IBAction func switchChangeTerms(_ sender: UISwitch) {
        
    }
    
    @IBAction func buttonAcceptTerms(_ sender: UIButton) {
        if acceptTermsSwitch.isOn {
            //Stores preferences and launch next VC
            UserDefaults.standard.set(true, forKey: "agreed")
            
            if UserDefaults.standard.object(forKey: "useApp") != nil {
                if UserDefaults.standard.bool(forKey: "useApp") {
                    //it is true that the user DO NOT want to see the explanation again
                    performSegue(withIdentifier: "RightsAppSegue", sender: nil)
                }else{
                    performSegue(withIdentifier: "HowToUseTheAppSegue", sender: nil)
                }
            } else {
                UserDefaults.standard.set(false, forKey: "useApp")
                performSegue(withIdentifier: "HowToUseTheAppSegue", sender: nil)
            }
            
        } else {
            //Shows an alert: temrs and conditions must be accepted
            let alert = UIAlertController(title: nil, message: NSLocalizedString("alertTermsConditions", comment: ""), preferredStyle: .alert)
            alert.view.backgroundColor = UIColor.black
            alert.view.alpha = 0.6
            alert.view.layer.cornerRadius = 15
            
            self.present(alert, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
                alert.dismiss(animated: true)
            }
        }
    }
}
