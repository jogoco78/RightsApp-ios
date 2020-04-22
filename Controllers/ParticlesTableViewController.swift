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

    var tags = UserDefaults.standard.string(forKey: "tags")
    var language = LocalizationSystem.sharedInstance.getLanguage()
    var subjectsText = [String]()
    var subjectsID = [Int]()
    
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
        } else{
            //Common crimes
            mainTags.append(Constants.shared.tag_common_crime)
        }
        
        if((tags?.contains(String(Constants.shared.tag_sexual_attack)))!){
            //Sexual attack
            mainTags.append(Constants.shared.tag_sexual_attack)
        }
        
        //Residence tags
        var residenceTags = [Int]()
        if((tags?.contains(String(Constants.shared.tag_spanish_resident)))!){
            //Spanish resident
            residenceTags.append(Constants.shared.tag_spanish_resident)
        } else if((tags?.contains(String(Constants.shared.tag_EU_resident)))!){
            //EU resident
            residenceTags.append(Constants.shared.tag_EU_resident)
        } else if((tags?.contains(String(Constants.shared.tag_non_EU_resident)))!){
            //Non EU resident
            residenceTags.append(Constants.shared.tag_non_EU_resident)
        } else {
          //Error
            
        }
        
        let tagsComponents = (tags?.components(separatedBy: ","))
        var tagsInt = [Int]()
        for tag in tagsComponents! {
            print(tag)
            if !tag.isEmpty {
               tagsInt.append(Int(tag)!)
            }
        }
        
        
        
        if DatabaseHelper.shared.openDatabase(){
            subjectsText = DatabaseHelper.shared.getSubjectsTextByTag(idTags: tagsInt, language: language)
            subjectsID = DatabaseHelper.shared.getSubjectsIDByTag(idTags: tagsInt, language: language)
        }
        
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
        return subjectsText.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParticleSubjectItem", for: indexPath) as! ParticlesSubjectTableViewCell
        
        cell.particleSubjectLabel.text = subjectsText[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(subjectsID[indexPath.row], forKey: Constants.shared.particles_id_subject)
        performSegue(withIdentifier: "particlesSubjectToDetail", sender: nil)
    }
}
