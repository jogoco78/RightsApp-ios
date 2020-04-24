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

    var tags = UserDefaults.standard.string(forKey: Constants.shared.tags)
    var idTagUser = UserDefaults.standard.integer(forKey: Constants.shared.idTagUser_key)
    var language = LocalizationSystem.sharedInstance.getLanguage()
    var subjectsText = [String]()
    var subjectsID = [Int]()
    var particles:[ParticleModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.navigationItem.title = NSLocalizedString("rights",comment: "Comment")
        
        //Main tags
        var mainTags = [Int]()
        if((tags?.contains(String(Constants.shared.tag_terrorism)))!){
            //Terrorism
            mainTags.append(Constants.shared.tag_terrorism)
        } else if((tags?.contains(String(Constants.shared.tag_violence_against_women)))!){
            //Violence against women
            mainTags.append(Constants.shared.tag_violence_against_women)
        } else if((tags?.contains(String(Constants.shared.tag_domestic_violence)))!){
            //Domestic violence
            mainTags.append(Constants.shared.tag_domestic_violence)
            if((tags?.contains(String(Constants.shared.tag_violent_crimes)))!){
                //Plus Violent crimes
                mainTags.append(Constants.shared.tag_violent_crimes)
            }
        } else if((tags?.contains(String(Constants.shared.tag_violent_crimes)))!){
            //Violent crimes
            mainTags.append(Constants.shared.tag_violent_crimes)
        } else if((tags?.contains(String(Constants.shared.tag_common_crime)))!){
            //Common crimes
            mainTags.append(Constants.shared.tag_common_crime)
        } else {
            //Error
        }
        
        if(idTagUser == Constants.shared.tag_sexual_attack){
            mainTags = [Constants.shared.tag_sexual_attack]
        }
        
        var residenceTags = [Int]()
        if(idTagUser == Constants.shared.tag_common_crime ||
            idTagUser == Constants.shared.tag_terrorism ||
            idTagUser == Constants.shared.tag_violence_against_women ||
            idTagUser == Constants.shared.tag_domestic_violence ||
            idTagUser == Constants.shared.tag_violent_crimes ||
            idTagUser == Constants.shared.tag_sexual_attack) {
            residenceTags.append(Constants.shared.tag_spanish_resident)
        }
        
        if(idTagUser == Constants.shared.tag_EU_resident){
            residenceTags.append(Constants.shared.tag_EU_resident)
        }
        
        if(idTagUser == Constants.shared.tag_non_EU_resident){
            residenceTags.append(Constants.shared.tag_non_EU_resident)
        }
        
        if DatabaseHelper.shared.openDatabase(){
            particles = DatabaseHelper.shared.getParticlesByTag(mainTags, residenceTags, language)
            for particle in particles{
                subjectsText.append(particle.subjectText)
            }
        }
        //Deletes the empty cells and their separators
        tableView.tableFooterView = UIView()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "AppIcon"), style: .plain, target: self, action: #selector(self.goHome))
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
        UserDefaults.standard.set(particles[indexPath.row].id, forKey: Constants.shared.particle_id)
        performSegue(withIdentifier: "particlesSubjectToDetail", sender: nil)
    }
}
