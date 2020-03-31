//
//  TermsViewController.swift
//  RightsApp
//
//  Created by Jorge Gonzalez Conejero on 03/07/2019.
//  Copyright © 2019 Jorge Gonzalez Conejero. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController {

    var tvTerms = UITextView()
    let btAccept = UIButton()
    let swSwitch = UISwitch()
    let lbAcceptText = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tvTerms)
        view.addSubview(btAccept)
        view.addSubview(swSwitch)
        view.addSubview(lbAcceptText)
        
        //Label properties
        lbAcceptText.translatesAutoresizingMaskIntoConstraints = false
        lbAcceptText.centerYAnchor.constraint(equalTo: swSwitch.centerYAnchor).isActive = true
        lbAcceptText.leftAnchor.constraint(equalTo: swSwitch.rightAnchor, constant: 10).isActive = true
        lbAcceptText.rightAnchor.constraint(equalTo: btAccept.leftAnchor, constant: -10).isActive = true
        lbAcceptText.numberOfLines = 0
        var s = NSMutableAttributedString(string: NSLocalizedString("labelTermsConditions",comment: ""), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        lbAcceptText.attributedText = s
        
        //Accept button properties
        btAccept.translatesAutoresizingMaskIntoConstraints = false
        btAccept.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:-20).isActive = true
        btAccept.rightAnchor.constraint(equalTo: view.rightAnchor, constant:-20).isActive = true
        btAccept.widthAnchor.constraint(equalToConstant: 70).isActive = true
        btAccept.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btAccept.setTitle(NSLocalizedString("accept",comment: ""), for: .normal)
        btAccept.setTitleColor(UIColor.blue, for: .normal)
        
        btAccept.addTarget(self, action: #selector(btnAcceptListener), for: .touchUpInside)
        
        //Switch properties
        swSwitch.translatesAutoresizingMaskIntoConstraints = false
        swSwitch.leftAnchor.constraint(equalTo: view.leftAnchor, constant:20).isActive = true
        swSwitch.centerYAnchor.constraint(equalTo: btAccept.centerYAnchor).isActive = true
        swSwitch.widthAnchor.constraint(equalToConstant: 45).isActive = true
        swSwitch.heightAnchor.constraint(equalToConstant: 30)
        
        //Text properties
        tvTerms.translatesAutoresizingMaskIntoConstraints = false
        tvTerms.isEditable = false
        tvTerms.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        tvTerms.bottomAnchor.constraint(equalTo: btAccept.topAnchor, constant: -10).isActive = true
        tvTerms.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        tvTerms.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        //line spacing
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        
        //App ownership
        s = NSMutableAttributedString(string: NSLocalizedString("appOwnership",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24), NSAttributedString.Key.paragraphStyle: paragraphStyle])
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
        tvTerms.attributedText = attributedText
        
    }
    
    //Button listener when touch inside
    @objc func btnAcceptListener(sender: UIButton){
        if swSwitch.isOn {
            //Stores preferences and launch next VC
            UserDefaults.standard.set(true, forKey: "agreed")
            
            if UserDefaults.standard.object(forKey: "useApp") != nil {
                if UserDefaults.standard.bool(forKey: "useApp") {
                    //it is true that the user DO NOT want to see the explanation again
                    //performSegue(withIdentifier: "RightsAppSegue", sender: nil) skips the how to use screen
                    performSegue(withIdentifier: "TermsToMainSegue", sender: nil)
                }else{
                    performSegue(withIdentifier: "TermsToMainSegue", sender: nil)
                }
            } else {
                UserDefaults.standard.set(false, forKey: "useApp")
                performSegue(withIdentifier: "TermsToHowToSegue", sender: nil)
            }
            
        } else {
            //Shows an alert: terms and conditions must be accepted
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
