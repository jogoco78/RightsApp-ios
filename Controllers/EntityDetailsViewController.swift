//
//  EntityDetailsViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 27/06/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

private let entitiesCellIdentifier = "entityCell"

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
        
        if DBManager.shared.openDatabase(){
            var results = DBManager.shared.getEntitiesList(idEntity: nil, idCountry: nil, idCity: nil, language: language)
            print("Results " + String(results.count))
        }
        //configureTableView()
        configureTextView()
    }
    
    func configureTextView(){
        noResultsTextView = UITextView()
        
        noResultsTextView.translatesAutoresizingMaskIntoConstraints = false
        
        //noResultsTextView.frame = CGRect(x: 100, y: 150, width: view.widthAnchor., height: 150)
        
        view.addSubview(noResultsTextView)
        
        noResultsTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        noResultsTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        noResultsTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 30).isActive = true
        noResultsTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        noResultsTextView.text = "Your query produced no results"
        noResultsTextView.backgroundColor = UIColor.blue
        
    }
    
    func configureTableView(){
        entitiesTableView = UITableView()
        
        entitiesTableView.delegate = self
        entitiesTableView.dataSource = self
        
        entitiesTableView.register(entitiesTableViewCell.self , forCellReuseIdentifier: entitiesCellIdentifier)
        
        entitiesTableView.translatesAutoresizingMaskIntoConstraints = false
       
        entitiesTableView.rowHeight = 50
       
        //entitiesTableView.separatorStyle = .none
        
        view.addSubview(entitiesTableView)
        
        entitiesTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        entitiesTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        entitiesTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        entitiesTableView.bottomAnchor.constraint(equalTo: btnFinishEntity.topAnchor, constant: 5).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        cell = tableView.dequeueReusableCell(withIdentifier: entitiesCellIdentifier, for: indexPath) as! entitiesTableViewCell
        cell.textLabel?.text = "Hello"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        
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

// MARK: - TableViewCells

class entitiesTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
