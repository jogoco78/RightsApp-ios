//
//  ParticleDetailsViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 20/06/2019.
//  Copyright © 2019 Jorge Gonzalez Conejero. All rights reserved.
//

import UIKit

class ParticleDetailsViewController: UIViewController {
    
    @IBOutlet weak var tvParticle: UITextView!
    
    let particleID = UserDefaults.standard.integer(forKey: Constants.shared.particle_id)
    let language = LocalizationSystem.sharedInstance.getLanguage()
    var particles = [ParticleModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if DatabaseHelper.shared.openDatabase(){
            let particle = DatabaseHelper.shared.getParticles([particleID], language)
            tvParticle.text = "-" + particle[0].text.replacingOccurrences(of: Constants.shared.rawSeparator, with: Constants.shared.newSeparator)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "AppIcon"), style: .plain, target: self, action: #selector(self.goHome))
    }
    
    @objc func goHome(){
        performSegue(withIdentifier: "toMain", sender: nil)
    }
}
