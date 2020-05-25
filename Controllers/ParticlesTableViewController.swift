//
//  ParticlesTableViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 19/06/2019.
//  Copyright © 2019 Jorge Gonzalez Conejero. All rights reserved.
//

import UIKit

class ParticlesSubjectTableViewCell: UITableViewCell {
    
    @IBOutlet weak var particleSubjectLabel: UILabel!
    
}

class ParticlesTableViewController: UITableViewController {

    var tags = UserDefaults.standard.string(forKey: Constants.keys.tags)
    var idTagUser = UserDefaults.standard.integer(forKey: Constants.keys.user_selected_tag)
    var language = LocalizationSystem.sharedInstance.getLanguage()
    var subjectsText = [String]()
    var subjectsID = [Int]()
    var particles:[ParticleModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("rights",comment: "Comment")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "AppIcon"), style: .plain, target: self, action: #selector(self.goHome))
        
        let main_tag = UserDefaults.standard.integer(forKey: Constants.keys.main_tag)
        let side_tag = UserDefaults.standard.integer(forKey: Constants.keys.side_tag)
        let residence_tag = UserDefaults.standard.integer(forKey: Constants.keys.residence_tag)
        let user_selected_tag = UserDefaults.standard.integer(forKey: Constants.keys.user_selected_tag)
        
        if DatabaseHelper.shared.openDatabase(){
            if(user_selected_tag != Constants.tags.EU_resident && user_selected_tag != Constants.tags.non_EU_resident){
                particles = sortParticles(DatabaseHelper.shared.getParticlesByTag(user_selected_tag, Constants.tags.spanish_resident, language))
            } else {
                particles = sortParticles(DatabaseHelper.shared.getParticlesByTag(main_tag, user_selected_tag, language))
            }
            
            for particle in particles{
                subjectsText.append(particle.subjectText)
            }
        }
        
        //Deletes the empty cells and their separators
        tableView.tableFooterView = UIView()
    }
    
    func sortParticles(_ source_particles: [ParticleModel]) -> [ParticleModel]{
        var order = 0
        var index = 0
        var aux_index = 0
        var source = [ParticleModel]()
        let size = source_particles.count
        var destination = [ParticleModel]()
        
        source.append(contentsOf: source_particles)
        
        for i in 0...size - 1{
            order = source[0].getOrder()
            index = 0
            aux_index = 0
            for particle in source{
                if (order > particle.getOrder()){
                    order = particle.getOrder()
                    index = aux_index
                }
                aux_index += 1
            }
            destination.append(source[index])
            source.remove(at: index)
        }
        return destination
    }
    
    @objc func goHome(){
        performSegue(withIdentifier: "ParticleTableToMainSegue", sender: nil)
    }
    
    // MARK: - tableView data source and delegate

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return particles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParticleSubjectItem", for: indexPath) as! ParticlesSubjectTableViewCell
        
        cell.particleSubjectLabel.text = particles[indexPath.row].subjectText
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(particles[indexPath.row].id, forKey: Constants.keys.particle_id)
        performSegue(withIdentifier: "particlesSubjectToDetail", sender: nil)
    }
}
