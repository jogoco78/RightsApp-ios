//
//  HowToViewController.swift
//  RightsApp
//
//  Created by Jorge Gonzalez Conejero on 03/07/2019.
//  Copyright © 2019 Jorge Gonzalez Conejero. All rights reserved.
//

import UIKit

class HowToViewController: UIViewController {
    
    var tv_how_to = UITextView()
    let btAccept = UIButton()
    let swSwitch = UISwitch()
    let lbAcceptText = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(tv_how_to)
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
        swSwitch.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //Text properties
        tv_how_to.translatesAutoresizingMaskIntoConstraints = false
        tv_how_to.isEditable = false
        tv_how_to.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        tv_how_to.bottomAnchor.constraint(equalTo: btAccept.topAnchor, constant: -10).isActive = true
        tv_how_to.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        tv_how_to.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
       //Attributes of the text
        let font_roboto = UIFont(name: "Roboto-Medium", size: 14)
        let font_bold_roboto = UIFont(name: "Roboto-Black", size: 14)
        let font_title_roboto = UIFont(name: "Roboto-Black", size: 24)
        let font = UIFont.systemFont(ofSize: 14)
        let font_bold = UIFont.boldSystemFont(ofSize: 14.0)
        let font_title = UIFont.boldSystemFont(ofSize: 24)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = .justified
        paragraphStyle.paragraphSpacing = 8
        
        let attributes_title: [NSAttributedString.Key: Any] = [
        .font: font_title_roboto,
        .foregroundColor: UIColor.black,
        .paragraphStyle: paragraphStyle]
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font_roboto,
            .foregroundColor: UIColor.black,
            .paragraphStyle: paragraphStyle]
        
        let attributes_bold: [NSAttributedString.Key: Any] = [
        .font: font_bold_roboto,
        .foregroundColor: UIColor.black,
        .paragraphStyle: paragraphStyle]
        
        //How to use the app
        s = NSMutableAttributedString(string: NSLocalizedString("howToUseTheApp",comment: "Comment"), attributes: attributes_title)
        let attributedText = s
        s = NSMutableAttributedString(string: NSLocalizedString("htaw_body",comment: "Comment"), attributes: attributes)
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("htaw_first_scenario_title",comment: "Comment"), attributes: attributes_bold)
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("htaw_first_scenario_body",comment: "Comment"), attributes: attributes)
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("htaw_second_scenario_title",comment: "Comment"), attributes: attributes_bold)
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("htaw_second_scenario_body",comment: "Comment"), attributes: attributes)
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("htaw_third_scenario_title",comment: "Comment"), attributes: attributes_bold)
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("htaw_third_scenario_body",comment: "Comment"), attributes: attributes)
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("bottomMenu",comment: "Comment"), attributes: attributes_title)
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("bottomMenuBody",comment: "Comment"), attributes: attributes)
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("bm_first_option_title",comment: "Comment"), attributes: attributes_bold)
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("bm_first_option_body",comment: "Comment"), attributes: attributes)
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("bm_second_option_title",comment: "Comment"), attributes: attributes_bold)
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("bm_second_option_body",comment: "Comment"), attributes: attributes)
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("bm_third_option_title",comment: "Comment"), attributes: attributes_bold)
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("bm_third_option_body",comment: "Comment"), attributes: attributes)
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("bm_fourth_option_title",comment: "Comment"), attributes: attributes_bold)
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("bm_fourth_option_body",comment: "Comment"), attributes: attributes)
        attributedText.append(s)
        
        //Sets the attributted text to the textview
        tv_how_to.attributedText = attributedText
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
