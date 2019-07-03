//
//  HowToViewController.swift
//  RightsApp
//
//  Created by Jorge Gonzalez Conejero on 03/07/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

class HowToViewController: UIViewController {
    
    var tvTerms = UITextView()
    let btAccept = UIButton()
    let swSwitch = UISwitch()
    let lbAcceptText = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        var s = NSMutableAttributedString(string: NSLocalizedString("doNotShow",comment: ""), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
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
        
        //How to use the app
        s = NSMutableAttributedString(string: NSLocalizedString("howToUseTheApp",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24), NSAttributedString.Key.paragraphStyle: paragraphStyle])
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
        tvTerms.attributedText = attributedText
    }
    
    //Button listener when touch inside
    @objc func btnAcceptListener(sender: UIButton){
        UserDefaults.standard.set(swSwitch.isOn, forKey: "useApp")
        performSegue(withIdentifier: "HowToToMainSegue", sender: nil)
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
