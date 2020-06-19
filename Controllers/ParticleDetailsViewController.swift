//
//  ParticleDetailsViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 20/06/2019.
//  Copyright © 2019 Jorge Gonzalez Conejero. All rights reserved.
//

import UIKit

class ParticleDetailsViewController: UIViewController {
    
    let btn_whats_next = UIButton()
    let tv_particle = UITextView()

    let particleID = UserDefaults.standard.integer(forKey: Constants.keys.particle_id)
    let language = LocalizationSystem.sharedInstance.getLanguage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Screen title
        self.navigationItem.title = NSLocalizedString("details", comment: "")
        
        view.addSubview(tv_particle)
        view.addSubview(btn_whats_next)
        
        tv_particle.translatesAutoresizingMaskIntoConstraints = false
        tv_particle.isEditable = false
        tv_particle.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        tv_particle.bottomAnchor.constraint(equalTo: btn_whats_next.topAnchor, constant: -10).isActive = true
        tv_particle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        tv_particle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        btn_whats_next.translatesAutoresizingMaskIntoConstraints = false
        btn_whats_next.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        btn_whats_next.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        btn_whats_next.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        btn_whats_next.setTitle(NSLocalizedString("whats_next",comment: ""), for: .normal)
        btn_whats_next.setTitleColor(UIColor.blue, for: .normal)
        
        btn_whats_next.addTarget(self, action: #selector(btn_whats_next_listener), for: .touchUpInside)
        
        if DatabaseHelper.shared.openDatabase(){
            let particle = DatabaseHelper.shared.getParticles([particleID], [particleID], language)
            
            let fullParticle = NSMutableAttributedString()
            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(named: "Bullet")
            let image1String = NSAttributedString(attachment: image1Attachment)
            let splitParticle = particle[0].text.split(separator: "|")
            
            //line spacing
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 12
            
            for i in 0..<splitParticle.count{
                fullParticle.append(image1String)
                fullParticle.append(NSAttributedString(string: "\t" + String(splitParticle[i]) + "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17), NSAttributedString.Key.paragraphStyle: paragraphStyle]))
            }
            
            tv_particle.attributedText = fullParticle
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "AppIcon"), style: .plain, target: self, action: #selector(self.goHome))
    }
    
    @objc func btn_whats_next_listener(sender:UIButton){
        performSegue(withIdentifier: "ParticlesToWhatsNextSegue", sender: nil)
    }
    
    @objc func goHome(){
        performSegue(withIdentifier: "toMain", sender: nil)
    }
}
