//
//  ParticlesClusterTableViewController.swift
//  RightsApp
//
//  Created by Jorge Gonzalez Conejero on 22/04/2020.
//  Copyright © 2020 uab. All rights reserved.
//

import UIKit

class ParticlesClusterTableViewCell: UITableViewCell {
    @IBOutlet weak var particleClusterLabel: UILabel!
    
}

class ParticlesClusterTableViewController: UITableViewController {
    
    var tags = UserDefaults.standard.string(forKey: "tags")
    var language = LocalizationSystem.sharedInstance.getLanguage()
    var dataSet = [ClusterModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        self.navigationItem.title = NSLocalizedString("rights", comment: "")
        
        //Common crimes cluster is always included
        dataSet.append(ClusterModel(Constants.shared.tag_common_crime, NSLocalizedString("citizensRights", comment: ""), language))
    
        if((tags?.contains(String(Constants.shared.tag_sexual_attack)))!){
            //Sexual attack cluster
            dataSet.append(ClusterModel(Constants.shared.tag_sexual_attack, NSLocalizedString("sexual_attack_protocol", comment: ""), language))
        }
        
        if((tags?.contains(String(Constants.shared.tag_EU_resident)))!){
            //EU resident cluster
            dataSet.append(ClusterModel(Constants.shared.tag_EU_resident, NSLocalizedString("EUCitizensRights", comment: ""), language))
        }
        
        if((tags?.contains(String(Constants.shared.tag_non_EU_resident)))!){
            //No EU resident cluster
            dataSet.append(ClusterModel(Constants.shared.tag_non_EU_resident, NSLocalizedString("NoEUCitizenRights", comment: ""), language))
        }
        
        //Deletes the empty cells and their separators
        tableView.tableFooterView = UIView()
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSet.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParticleClusterItem", for: indexPath) as! ParticlesClusterTableViewCell

        cell.particleClusterLabel.text = dataSet[indexPath.row].description

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(dataSet[indexPath.row].tag_id, forKey: Constants.shared.idTagUser_key)
        performSegue(withIdentifier: "ParticleClusterToSubjectsSegue", sender: nil)
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
