//
//  EntitiesListViewController.swift
//  RightsApp
//
//  Created by Jorge Gonzalez Conejero on 04/07/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit
import CoreLocation

private let entitiesCellIdentifier = "entityCell"

class EntitiesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var idCategory = UserDefaults.standard.object(forKey: Constants.shared.searchIDEntity)
    var idCountry = UserDefaults.standard.object(forKey: Constants.shared.searchIDCountry)
    var idCity = UserDefaults.standard.object(forKey: Constants.shared.searchIDCity)
    var longitude = UserDefaults.standard.double(forKey: Constants.shared.longitude)
    var latitude = UserDefaults.standard.double(forKey: Constants.shared.latitude)
    let language = LocalizationSystem.sharedInstance.getLanguage()
    
    var entitiesTableView: UITableView!
    var entities = [EntityModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sets right bar button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "AppIcon"), style: .plain, target: self, action: #selector(self.goHome))
        
        //Loads the entities from the database
        if DatabaseHelper.shared.openDatabase(){
            entities = DatabaseHelper.shared.getEntitiesList(idEntity: nil, idCountry: nil, idCity: nil, language: language)
        }
        
        //Calculates distance
        let startLocation = CLLocation(latitude: latitude, longitude: longitude)
        for entity in entities {
            let endLocation = CLLocation(latitude: entity.latitude, longitude: entity.longitude)
            let distance = startLocation.distance(from: endLocation)
            entity.distance = distance.magnitude / 1000.0
            print("Entity: " + String(entity.latitude) + "," + String(entity.longitude))
            print("Distance antes: " + String(entity.distance))
        }
        
        entities = entities.sorted {
            $0.distance < $1.distance
        }
        //entities = sortedEntities
        
        for entity in entities{
            print("Distance despues: " + String(entity.distance))
        }
        
        configureTableView()
    }
    
    @objc func goHome(){
        performSegue(withIdentifier: "listToMainSegue", sender: nil)
    }

 
    
    func configureTableView(){
        entitiesTableView = UITableView()
        
        entitiesTableView.delegate = self
        entitiesTableView.dataSource = self
        
        view.addSubview(entitiesTableView)
        entitiesTableView.register(entitiesTableViewCell.self, forCellReuseIdentifier: entitiesCellIdentifier)
        
        entitiesTableView.translatesAutoresizingMaskIntoConstraints = false
        entitiesTableView.register(entitiesTableViewCell.self , forCellReuseIdentifier: entitiesCellIdentifier)
        entitiesTableView.rowHeight = 50
        entitiesTableView.separatorStyle = .none
        entitiesTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        entitiesTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        entitiesTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        entitiesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return entities.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return entities[section].entityName
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.lightGray
        
        let headerLabel = UILabel(frame: CGRect(x: 30, y: 0, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont.systemFont(ofSize: 14)
        headerLabel.textColor = UIColor.white
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        cell = tableView.dequeueReusableCell(withIdentifier: entitiesCellIdentifier, for: indexPath) as! entitiesTableViewCell
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        switch indexPath.row {
        case 0:
            if entities[indexPath.section].entityDescription != nil {
                cell.textLabel?.text = entities[indexPath.section].entityDescription
            }else {
                cell.textLabel?.text = "Description"
            }
        case 1:
            if entities[indexPath.section].distance != nil {
                cell.textLabel?.text = String(entities[indexPath.section].distance)
            }else {
                cell.textLabel?.text = "Distance"
            }
            
        default:
            cell.textLabel?.text = "Default"
            print("Something went wrong in cells text...")
            print("Section " + String(indexPath.section))
            print("Row: " + String(indexPath.row))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //code
    }
}

// MARK: - TableViewCells

class entitiesTableViewCell: UITableViewCell {
    var entityTitle = UILabel()
    //var entityDescription = UILabel()
    //let entityAddress = UILabel()
    //let entityPhone = UILabel()
    //let entityLink = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(entityTitle)
        entityTitle.translatesAutoresizingMaskIntoConstraints = false
        entityTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        entityTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
}
