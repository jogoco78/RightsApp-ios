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
    
    var tags = UserDefaults.standard.string(forKey: Constants.keys.tags)
    var language = LocalizationSystem.sharedInstance.getLanguage()
    var dataSet = [ClusterModel]()
    var main_tag = 0
    var side_tag = 0
    var residence_tag = Constants.tags.spanish_resident
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        //Screen title
        self.navigationItem.title = NSLocalizedString("rights", comment: "")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "AppIcon"), style: .plain, target: self, action: #selector(self.goHome))
        
        
        if((tags?.contains(String(Constants.tags.terrorism)))!){
            //Terrorism
            main_tag = Constants.tags.terrorism
            dataSet.append(ClusterModel(Constants.tags.terrorism, NSLocalizedString("citizensRights", comment: ""), language))
        }else if((tags?.contains(String(Constants.tags.violence_against_women)))!){
            //Violence against women
            main_tag = Constants.tags.violence_against_women
            dataSet.append(ClusterModel(Constants.tags.violence_against_women, NSLocalizedString("citizensRights", comment: ""), language))
            if((tags?.contains(String(Constants.tags.sexual_attack)))!){
                //Sexual attack
                side_tag = Constants.tags.sexual_attack
                dataSet.append(ClusterModel(Constants.tags.sexual_attack, NSLocalizedString("sexualAttackProtocol", comment: ""), language))
            }
        }else if((tags?.contains(String(Constants.tags.domestic_violence)))!){
            //Domestic violence
            main_tag = Constants.tags.domestic_violence
            dataSet.append(ClusterModel(Constants.tags.domestic_violence, NSLocalizedString("citizensRights", comment: ""), language))
            if((tags?.contains(String(Constants.tags.sexual_attack)))!){
                //Sexual attack
                side_tag = Constants.tags.sexual_attack
                dataSet.append(ClusterModel(Constants.tags.sexual_attack, NSLocalizedString("sexualAttackProtocol", comment: ""), language))
            }
        }else if((tags?.contains(String(Constants.tags.violent_crimes)))!){
            //Violent crimes
            main_tag = Constants.tags.violent_crimes
            dataSet.append(ClusterModel(Constants.tags.violent_crimes, NSLocalizedString("citizensRights", comment: ""), language))
            if((tags?.contains(String(Constants.tags.sexual_attack)))!){
                //Sexual attack
                side_tag = Constants.tags.sexual_attack
                dataSet.append(ClusterModel(Constants.tags.sexual_attack, NSLocalizedString("sexualAttackProtocol", comment: ""), language))
            }
        }else if((tags?.contains(String(Constants.tags.common_crime)))!){
            //Common crimes
            main_tag = Constants.tags.common_crime
            dataSet.append(ClusterModel(Constants.tags.common_crime, NSLocalizedString("citizensRights", comment: ""), language))
        }
        
        if((tags?.contains(String(Constants.tags.EU_resident)))!){
            //EU residents
            residence_tag = Constants.tags.EU_resident
            dataSet.append(ClusterModel(Constants.tags.EU_resident, NSLocalizedString("EUCitizensRights", comment: ""), language))
        }else if((tags?.contains(String(Constants.tags.non_EU_resident)))!){
            //Non EU residents
            residence_tag = Constants.tags.non_EU_resident
            dataSet.append(ClusterModel(Constants.tags.non_EU_resident, NSLocalizedString("NoEUCitizenRights", comment: ""), language))
        }
        
        //Stores the tags provided by the questionnaire
        UserDefaults.standard.set(main_tag, forKey: Constants.keys.main_tag)
        UserDefaults.standard.set(side_tag, forKey: Constants.keys.side_tag)
        UserDefaults.standard.set(residence_tag, forKey: Constants.keys.residence_tag)
        
        //Common crimes cluster is always included
       /* dataSet.append(ClusterModel(Constants.shared.tag_common_crime, NSLocalizedString("citizensRights", comment: ""), language))
    
        if((tags?.contains(String(Constants.shared.tag_sexual_attack)))!){
            //Sexual attack cluster
            dataSet.append(ClusterModel(Constants.shared.tag_sexual_attack, NSLocalizedString("sexualAttackProtocol", comment: ""), language))
        }
        
        if((tags?.contains(String(Constants.shared.tag_EU_resident)))!){
            //EU resident cluster
            dataSet.append(ClusterModel(Constants.shared.tag_EU_resident, NSLocalizedString("EUCitizensRights", comment: ""), language))
        }
        
        if((tags?.contains(String(Constants.shared.tag_non_EU_resident)))!){
            //No EU resident cluster
            dataSet.append(ClusterModel(Constants.shared.tag_non_EU_resident, NSLocalizedString("NoEUCitizenRights", comment: ""), language))
        }*/
        
        //Deletes the empty cells and their separators
        tableView.tableFooterView = UIView()
    
    }
    
    @objc func goHome(){
        performSegue(withIdentifier: "clusterToMainSegue", sender: nil)
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
        UserDefaults.standard.set(dataSet[indexPath.row].tag_id, forKey: Constants.keys.user_selected_tag)
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
