//
//  EntityDetailsViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 27/06/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

class EntityDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var btnFinishEntity: UIButton!
    
    var entitiesTableView: UITableView!
    var noResultsTextView: UITextView!
    
    var language = LocalizationSystem.sharedInstance.getLanguage()
    var categoryID = UserDefaults.standard.integer(forKey: Constants.shared.searchIDEntity)
    var countryID = UserDefaults.standard.integer(forKey: Constants.shared.searchIDCountry)
    var cityID = UserDefaults.standard.integer(forKey: Constants.shared.searchIDCity)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if DatabaseHelper.shared.openDatabase(){
            var results = DatabaseHelper.shared.getEntitiesList(idEntity: nil, idCountry: nil, idCity: nil, language: language)
            print("Results " + String(results.count))
        }
        //configureTableView()
        //configureTextView()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //code
    }
    

    @IBAction func btnFinishEntity(_ sender: UIButton) {
        
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
