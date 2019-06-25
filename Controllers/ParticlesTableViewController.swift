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
        
        let tagsComponents = (tags?.components(separatedBy: ","))
        var tagsInt = [Int]()
        for tag in tagsComponents! {
            print(tag)
            if !tag.isEmpty {
               tagsInt.append(Int(tag)!)
            }
        }
        
        if DBManager.shared.openDatabase(){
            subjectsText = DBManager.shared.getSubjectsTextByTag(idTags: tagsInt, language: language)
            subjectsID = DBManager.shared.getSubjectsIDByTag(idTags: tagsInt, language: language)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subjectsText.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParticleSubjectItem", for: indexPath) as! ParticlesSubjectTableViewCell
        
        cell.particleSubjectLabel.text = subjectsText[indexPath.row]
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(subjectsID[indexPath.row], forKey: Constants.shared.particles_id_subject)
        performSegue(withIdentifier: "particlesSubjectToDetail", sender: nil)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
