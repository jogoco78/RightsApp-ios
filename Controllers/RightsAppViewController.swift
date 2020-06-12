//
//  RightsAppViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 04/06/2019.
//  Copyright © 2019 Jorge Gonzalez Conejero. All rights reserved.
//

import UIKit

class RightsAppViewController: UIViewController {
    
    var btnImageEmergency = UIButton()
    var btnTextEmergency = UIButton()
    var btnImageQuestionnaire = UIButton()
    var btnTextQuestionnaire = UIButton()
    var btnImageSearchEntity = UIButton()
    var btnTextSearchEntity = UIButton()
    var tvTitleVC = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tvTitleVC)
        view.addSubview(btnImageEmergency)
        view.addSubview(btnTextEmergency)
        view.addSubview(btnImageQuestionnaire)
        view.addSubview(btnTextQuestionnaire)
        view.addSubview(btnImageSearchEntity)
        view.addSubview(btnTextSearchEntity)
        
        //Title properties
        tvTitleVC.translatesAutoresizingMaskIntoConstraints = false
        tvTitleVC.isEditable = false
        tvTitleVC.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        tvTitleVC.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tvTitleVC.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        tvTitleVC.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        tvTitleVC.heightAnchor.constraint(equalToConstant: 75).isActive = true
        let s = NSMutableAttributedString(string: NSLocalizedString("mainScreen",comment: ""), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)])
        tvTitleVC.attributedText = s
        
        //Attributes of the text
        let font = UIFont.systemFont(ofSize: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        paragraphStyle.alignment = .justified
        let font_roboto = UIFont(name: "Roboto-Medium", size: 15)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font_roboto,
            .foregroundColor: UIColor.black,
            .paragraphStyle: paragraphStyle]
        
        //Emergency call properties
        btnImageEmergency.translatesAutoresizingMaskIntoConstraints = false
        btnImageEmergency.topAnchor.constraint(equalTo: tvTitleVC.bottomAnchor , constant: 30).isActive = true
        btnImageEmergency.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        btnImageEmergency.widthAnchor.constraint(equalToConstant: 75).isActive = true
        btnImageEmergency.heightAnchor.constraint(equalToConstant: 75).isActive = true
        btnImageEmergency.setImage(UIImage(named: "EmergencyCall"), for: .normal)
        btnImageEmergency.addTarget(self, action: #selector(emergencyCallListener), for: .touchUpInside)
        
        btnTextEmergency.translatesAutoresizingMaskIntoConstraints = false
        btnTextEmergency.centerYAnchor.constraint(equalTo: btnImageEmergency.centerYAnchor).isActive = true
        btnTextEmergency.leftAnchor.constraint(equalTo: btnImageEmergency.rightAnchor, constant: 20).isActive = true
        btnTextEmergency.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        btnTextEmergency.heightAnchor.constraint(equalToConstant: 75).isActive = true
        btnTextEmergency.titleLabel?.numberOfLines = 0
        btnTextEmergency.setTitleColor(UIColor.black, for: .normal)
        btnTextEmergency.setAttributedTitle(NSMutableAttributedString(string: NSLocalizedString("emergencyCallText",comment: ""), attributes: attributes), for: .normal)
        btnTextEmergency.addTarget(self, action: #selector(emergencyCallListener), for: .touchUpInside)
        
        //Questionnaire properties
        btnImageQuestionnaire.translatesAutoresizingMaskIntoConstraints = false
        btnImageQuestionnaire.topAnchor.constraint(equalTo: btnImageEmergency.bottomAnchor, constant: 60).isActive = true
        btnImageQuestionnaire.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        btnImageQuestionnaire.widthAnchor.constraint(equalToConstant: 75).isActive = true
        btnImageQuestionnaire.heightAnchor.constraint(equalToConstant: 75).isActive = true
        btnImageQuestionnaire.setImage(UIImage(named: "Questionnaire"), for: .normal)
        btnImageQuestionnaire.addTarget(self, action: #selector(questionnaireListener), for: .touchUpInside)

        btnTextQuestionnaire.translatesAutoresizingMaskIntoConstraints = false
        btnTextQuestionnaire.centerYAnchor.constraint(equalTo: btnImageQuestionnaire.centerYAnchor).isActive = true
        btnTextQuestionnaire.leftAnchor.constraint(equalTo: btnImageQuestionnaire.rightAnchor, constant: 20).isActive = true
        btnTextQuestionnaire.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        btnTextQuestionnaire.titleLabel?.numberOfLines = 0
        //btnTextQuestionnaire.setTitle(NSLocalizedString("questionnaireText",comment: ""), for: .normal)
        btnTextQuestionnaire.setAttributedTitle(NSMutableAttributedString(string: NSLocalizedString("questionnaireText",comment: ""), attributes: attributes), for: .normal)
        btnTextQuestionnaire.addTarget(self, action: #selector(questionnaireListener), for: .touchUpInside)
        
        //Search Entity properties
        btnImageSearchEntity.translatesAutoresizingMaskIntoConstraints = false
        btnImageSearchEntity.topAnchor.constraint(equalTo: btnImageQuestionnaire.bottomAnchor, constant: 60).isActive = true
        btnImageSearchEntity.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        btnImageSearchEntity.widthAnchor.constraint(equalToConstant: 75).isActive = true
        btnImageSearchEntity.heightAnchor.constraint(equalToConstant: 75).isActive = true
        btnImageSearchEntity.setImage(UIImage(named: "Maps"), for: .normal)
        btnImageSearchEntity.addTarget(self, action: #selector(searchEntityListener), for: .touchUpInside)
        
        btnTextSearchEntity.translatesAutoresizingMaskIntoConstraints = false
        btnTextSearchEntity.centerYAnchor.constraint(equalTo: btnImageSearchEntity.centerYAnchor).isActive = true
        btnTextSearchEntity.leftAnchor.constraint(equalTo: btnImageSearchEntity.rightAnchor, constant: 20).isActive = true
        btnTextSearchEntity.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        btnTextSearchEntity.titleLabel?.numberOfLines = 0
        btnTextSearchEntity.setAttributedTitle(NSMutableAttributedString(string: NSLocalizedString("searchEntityText",comment: ""), attributes: attributes), for: .normal)
        //btnTextSearchEntity.setTitle(NSLocalizedString("searchEntityText",comment: ""), for: .normal)
        btnTextSearchEntity.addTarget(self, action: #selector(searchEntityListener), for: .touchUpInside)
        
        self.tabBarItem.title = NSLocalizedString("home",comment: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarItem.title = NSLocalizedString("home",comment: "")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarItem.title = ""
    }
    
    //Emergency call listener for image and text buttons
    @objc func emergencyCallListener(_ sender: UIButton){
        performSegue(withIdentifier: "rightsAppToEmergencyCallSegue", sender: nil)
    }
    
    //Questionnaire listener for image and text buttons
    @objc func questionnaireListener(_ sender: UIButton){
        performSegue(withIdentifier: "rightsAppToQuestionnaireSegue", sender: nil)
    }
    
    //Search Entity listener for image and text buttons
    @objc func searchEntityListener(_ sender: UIButton){
        performSegue(withIdentifier: "rightsAppToSearchEntitySegue", sender: nil)
    }
    
}
