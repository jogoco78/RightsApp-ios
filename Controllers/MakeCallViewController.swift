//
//  MakeCallViewController.swift
//  RightsApp
//
//  Created by Jorge Gonzalez Conejero on 26/05/2020.
//  Copyright © 2020 uab. All rights reserved.
//

import UIKit

class MakeCallViewController: UIViewController {

    let ib_emergency_call = UIButton()
    let tv_emergency_call = UITextView()
    var phone_to_call = Constants.call.emergency
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //Gets the number to phone
        if(UserDefaults.standard.string(forKey: Constants.keys.phone_to_call) != nil) {
            phone_to_call = UserDefaults.standard.string(forKey: Constants.keys.phone_to_call)!
        }
        
        //Screen title & Home icon
        self.navigationItem.title = NSLocalizedString("emergency_call_title", comment: "") + phone_to_call
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "AppIcon"), style: .plain, target: self, action: #selector(self.goHome))
        self.navigationItem.backBarButtonItem?.title = NSLocalizedString("back", comment: "")
        self.navigationItem.backBarButtonItem?.isEnabled = true
        
        view.addSubview(ib_emergency_call)
        view.addSubview(tv_emergency_call)
        
        ib_emergency_call.translatesAutoresizingMaskIntoConstraints = false
        ib_emergency_call.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        ib_emergency_call.heightAnchor.constraint(equalToConstant: 150).isActive = true
        ib_emergency_call.widthAnchor.constraint(equalToConstant: 150).isActive = true
        ib_emergency_call.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        ib_emergency_call.setImage(UIImage(named: "Phone"), for: .normal)
        //ib_emergency_call.setTitleColor(UIColor.blue, for: .normal)
        ib_emergency_call.addTarget(self, action: #selector(ib_emergency_call_listener), for: .touchUpInside)

        tv_emergency_call.translatesAutoresizingMaskIntoConstraints = false
        tv_emergency_call.isEditable = false
        tv_emergency_call.topAnchor.constraint(equalTo: ib_emergency_call.bottomAnchor, constant: 40).isActive = true
        tv_emergency_call.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        tv_emergency_call.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        tv_emergency_call.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        
        //Attributes of the text
        let font = UIFont.systemFont(ofSize: 17)
        let font_bold = UIFont.boldSystemFont(ofSize: 23)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 12
        paragraphStyle.firstLineHeadIndent = 5.0
        paragraphStyle.alignment = .justified
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black,
            .paragraphStyle: paragraphStyle]
        
        let attributes_bold: [NSAttributedString.Key: Any] = [
        .font: font_bold,
        .foregroundColor: UIColor.black,
        .paragraphStyle: paragraphStyle]
        
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: NSLocalizedString("emergency_call",comment: ""), attributes: attributes))
        text.append(NSAttributedString(string: NSLocalizedString(phone_to_call,comment: ""), attributes: attributes_bold))
        text.append(NSAttributedString(string: NSLocalizedString("emergency_call_go_home",comment: ""), attributes: attributes))
        
        tv_emergency_call.attributedText = text
    }
    
    @objc func ib_emergency_call_listener(sender:UIButton){
        guard let number = URL(string: "tel://" + phone_to_call) else { return }
        UIApplication.shared.open(number)
    }
    
    @objc func goHome(){
        performSegue(withIdentifier: "MakeCallToMain", sender: nil)
    }

}
