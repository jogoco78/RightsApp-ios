//
//  ParticlesTableViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 19/06/2019.
//  Copyright © 2019 uab. All rights reserved.
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
