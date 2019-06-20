//
//  ParticleDetailsViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 20/06/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

class ParticleDetailsViewController: UIViewController {
    
    @IBOutlet weak var textView_particle: UITextView!
    @IBOutlet weak var button_Finish: UIButton!
    
    var idSubject = UserDefaults.standard.integer(forKey: Constants.shared.particles_id_subject)
    var tags = UserDefaults.standard.string(forKey: Constants.shared.tags)
    let language = "es"
    var particles = [ParticleModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        button_Finish.setTitle(NSLocalizedString("finishParticles",comment: ""), for: .normal)
        
        let tagsComponents = (tags?.components(separatedBy: ","))
        var tagsInt = [Int]()
        for tag in tagsComponents! {
            print(tag)
            if !tag.isEmpty {
                tagsInt.append(Int(tag)!)
            }
        }
        if DBManager.shared.openDatabase(){
            particles = DBManager.shared.getParticlesByTag(idTags: tagsInt, language: language)
        }
        
        for particle in particles {
            if particle.idSubject == idSubject {
                textView_particle.text = particle.text
                break;
            }
        }
    }
    
    @IBAction func btFinish(_ sender: Any) {
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
