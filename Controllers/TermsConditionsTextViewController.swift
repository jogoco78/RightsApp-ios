//
//  TermsConditionsTextViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 05/06/2019.
//  Copyright © 2019 Jorge Gonzalez Conejero. All rights reserved.
//

import UIKit

class TermsConditionsTextViewController: UIViewController {

    @IBOutlet weak var tvTermsConditionsText: UITextView!
    
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
        tvTermsConditionsText.attributedText = attributedText
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarItem.title = NSLocalizedString("terms",comment: "")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarItem.title = ""
    }
    
}
