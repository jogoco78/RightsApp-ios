//
//  ParticleDetailsViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 20/06/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

class ParticleDetailsViewController: UIViewController {
    
    @IBOutlet weak var tvParticle: UITextView!
    @IBOutlet weak var btnFinish: UIButton!
    
    var idSubject = UserDefaults.standard.integer(forKey: Constants.shared.particles_id_subject)
    var tags = UserDefaults.standard.string(forKey: Constants.shared.tags)
    let language = LocalizationSystem.sharedInstance.getLanguage()
    var particles = [ParticleModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        btnFinish.setTitle(NSLocalizedString("finishParticles",comment: ""), for: .normal)
        
        let tagsComponents = (tags?.components(separatedBy: ","))
        var tagsInt = [Int]()
        for tag in tagsComponents! {
            print(tag)
            if !tag.isEmpty {
                tagsInt.append(Int(tag)!)
            }
        }
        if DatabaseHelper.shared.openDatabase(){
            particles = DatabaseHelper.shared.getParticlesByTag(idTags: tagsInt, language: language)
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
    
    @IBAction func btnFinishListener(_ sender: Any) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        performSegue(withIdentifier: "toMain", sender: nil)
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
