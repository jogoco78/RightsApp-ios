//
//  WahtsNextTableViewController.swift
//  RightsApp
//
//  Created by Jorge Gonzalez Conejero on 25/05/2020.
//  Copyright © 2020 uab. All rights reserved.
//

import UIKit

class WhatsNextTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lb_whats_next_cell: UILabel!
}

class WhatsNextTableViewController: UITableViewController {

    var dataSet = [WhatsNextModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("",comment: "")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "AppIcon"), style: .plain, target: self, action: #selector(self.goHome))
        
        let main_tag = UserDefaults.standard.integer(forKey: Constants.keys.main_tag)
        let side_tag = UserDefaults.standard.integer(forKey: Constants.keys.side_tag)
        let residence_tag = UserDefaults.standard.integer(forKey: Constants.keys.residence_tag)
        let user_selected_tag = UserDefaults.standard.integer(forKey: Constants.keys.user_selected_tag)
        let language = LocalizationSystem.sharedInstance.getLanguage()
        
        dataSet.append(WhatsNextModel(0, NSLocalizedString("phone_112", comment: ""), language))
        dataSet.append(WhatsNextModel(1, NSLocalizedString("victims_association", comment: ""),language))
        dataSet.append(WhatsNextModel(2, NSLocalizedString("police_station", comment: ""), language))
        
        if(main_tag == Constants.tags.violence_against_women){
            //Violence against women
            dataSet.append(WhatsNextModel(3, NSLocalizedString("phone_against_violence", comment: ""), language))
        }
        
        if(main_tag == Constants.tags.sexual_attack || side_tag == Constants.tags.sexual_attack){
            //Sexual attack
            dataSet.append(WhatsNextModel(4, NSLocalizedString("hospital", comment: ""), language))
        }
        
        if(residence_tag != Constants.tags.spanish_resident){
            dataSet.append(WhatsNextModel(5, NSLocalizedString("consulate_embassy", comment: ""), language))
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
    
    @objc func goHome(){
           performSegue(withIdentifier: "WhatsNextToMainSegue", sender: nil)
       }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhatsNextCell", for: indexPath) as! WhatsNextTableViewCell

        cell.lb_whats_next_cell.text = dataSet[indexPath.row].data

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(dataSet[indexPath.row].id){
            case 0:
                UserDefaults.standard.set(Constants.call.emergency, forKey: Constants.keys.phone_to_call)
                performSegue(withIdentifier: "WhatsNextToMakeCallSegue" , sender: nil)
          /* case 1:
            case 2:
            case 3:
            case 4:
            case 5:*/
        default:
            performSegue(withIdentifier: "WhatsNextToMainSegue", sender: nil)
        }
        
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
