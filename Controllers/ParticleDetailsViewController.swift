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
    
    var idSubject = UserDefaults.standard.integer(forKey: Constants.shared.particles_id_subject)
    var tags = UserDefaults.standard.string(forKey: Constants.shared.tags)
    let language = LocalizationSystem.sharedInstance.getLanguage()
    var particles = [ParticleModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tagsComponents = (tags?.components(separatedBy: ","))
        var tagsInt = [Int]()
        for tag in tagsComponents! {
            print(tag)
            if !tag.isEmpty {
                tagsInt.append(Int(tag)!)
            }
        }
        if DatabaseHelper.shared.openDatabase(){
            //particles = DatabaseHelper.shared.getParticlesByTag(idTags: tagsInt, language: language)
            particles = [ParticleModel]()
        }
        
        for particle in particles {
            if particle.idSubject == idSubject {
                var particleTexts = String()
                for text in particle.particleTexts{
                    particleTexts.append("- " + text + "\n\n")
                }
                tvParticle.text = particleTexts
                break;
            }
        }
        
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "AppIcon"), style: .plain, target: self, action: #selector(self.goHome))
    }
    
    @objc func goHome(){
        performSegue(withIdentifier: "toMain", sender: nil)
    }
}
