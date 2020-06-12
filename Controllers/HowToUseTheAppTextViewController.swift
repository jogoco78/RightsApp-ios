//
//  HowToUseTheAppTextViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 05/06/2019.
//  Copyright © 2019 Jorge Gonzalez Conejero. All rights reserved.
//

import UIKit

class HowToUseTheAppTextViewController: UIViewController {
    
    var tv_How_To = UITextView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tabBarItem.title = NSLocalizedString("use",comment: "")
        
        view.addSubview(tv_How_To)
        
        tv_How_To.translatesAutoresizingMaskIntoConstraints = false
        tv_How_To.topAnchor.constraint(equalTo: view.topAnchor, constant: 40.0).isActive = true
        tv_How_To.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10.0).isActive = true
        tv_How_To.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10.0).isActive = true
        tv_How_To.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0).isActive = true
        tv_How_To.isEditable = false
        
        
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
        var s = NSMutableAttributedString(string: NSLocalizedString("howToUseTheApp",comment: "Comment"), attributes: attributes_title)
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
       
        
        //Bottom menu
       /* s = NSMutableAttributedString(string: NSLocalizedString("bottomMenu",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        s = NSMutableAttributedString(string: NSLocalizedString("bottomMenuBody",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)
        //How the App works
        s = NSMutableAttributedString(string: NSLocalizedString("howTheAppWorks",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText.append(s)*/
        
        
        //Sets the attributted text to the textview
        tv_How_To.attributedText = attributedText
        tv_How_To.isScrollEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarItem.title = NSLocalizedString("use",comment: "")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarItem.title = NSLocalizedString("",comment: "")
    }

}
