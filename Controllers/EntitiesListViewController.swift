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

class EntitiesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    var idCategory = UserDefaults.standard.integer(forKey: Constants.shared.searchIDEntity)
    var idCountry = UserDefaults.standard.integer(forKey: Constants.shared.searchIDCountry)
    var idCity = UserDefaults.standard.integer(forKey: Constants.shared.searchIDCity)
    var longitude: Double!
    var latitude: Double!
    let language = LocalizationSystem.sharedInstance.getLanguage()
    let locationManager = CLLocationManager()
    
    var entitiesTableView: UITableView!
    var entities = [EntityModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //GPS Coordinates delegate
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //Sets right bar button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "AppIcon"), style: .plain, target: self, action: #selector(self.goHome))
        
        //Loads the entities from the database
        if DatabaseHelper.shared.openDatabase(){
            entities = DatabaseHelper.shared.getEntitiesList(idEntity: idCategory, idCountry: idCountry, idCity: idCity, language: language)
        }
        print("Entities: " + String(entities.count) + " IDEntity: " + String(idCategory))
        configureTableView()
    }
    
    @objc func goHome(){
        performSegue(withIdentifier: "listToMainSegue", sender: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied:
            //TODO: Showing an alert that the app will need location to work
            print("User denied location permission")
            return
        case .authorizedWhenInUse:
            print("App is authorized to use location while in use")
            break
        case .authorizedAlways:
            print("App is authorized to always use this device's location")
            break
        default:
            print("User has not yet determined location permission")
            return
        }
        
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed to get user's location. \(String(describing: error))")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.first else {
            assertionFailure("Failed to get user's location")
            return
        }
        
        latitude = userLocation.coordinate.latitude
        longitude = userLocation.coordinate.longitude
        
        //Calculates distance
        let startLocation = CLLocation(latitude: latitude, longitude: longitude)
        for entity in entities {
            let endLocation = CLLocation(latitude: entity.latitude, longitude: entity.longitude)
            let distance = startLocation.distance(from: endLocation)
            entity.distance = distance.magnitude / 1000.0 //in kms
            entity.distance = round(entity.distance * 100) / 100 //rounded two decimals
        }
        
        entities = entities.sorted {
            $0.distance < $1.distance
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func configureTableView(){
        entitiesTableView = UITableView()
        
        entitiesTableView.delegate = self
        entitiesTableView.dataSource = self
        
        view.addSubview(entitiesTableView)
        entitiesTableView.register(entitiesTableViewCell.self, forCellReuseIdentifier: entitiesCellIdentifier)
        
        entitiesTableView.translatesAutoresizingMaskIntoConstraints = false
        entitiesTableView.register(entitiesTableViewCell.self , forCellReuseIdentifier: entitiesCellIdentifier)
        entitiesTableView.rowHeight = 65
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
        headerLabel.numberOfLines = 0
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
                cell.textLabel?.text = NSLocalizedString("descriptionNotAvailable",comment: "")
            }
        case 1:
            if entities[indexPath.section].distance != nil {
                cell.textLabel?.text = NSLocalizedString("distance",comment: "") + ": " + String(entities[indexPath.section].distance) + " " + NSLocalizedString("kms",comment: "")
            }else {
                cell.textLabel?.text = "Distance"
            }
        case 2:
            if entities[indexPath.section].address != nil {
                cell.textLabel?.text = NSLocalizedString("address",comment: "") + ": " + entities[indexPath.section].address + ", " + entities[indexPath.section].cityName
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.lineBreakMode = .byWordWrapping
            } else {
                cell.textLabel?.text = NSLocalizedString("addressNotAvailable",comment: "")
            }
        case 3:
            if entities[indexPath.section].phoneNumber != nil {
                cell.textLabel?.text = NSLocalizedString("phone",comment: "") + ": " + entities[indexPath.section].phoneNumber
            } else {
                cell.textLabel?.text = NSLocalizedString("phoneNotAvailable",comment: "")
            }
        case 4:
            if entities[indexPath.section].link != nil {
                cell.textLabel?.text = NSLocalizedString("link",comment: "") + entities[indexPath.section].link
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.isUserInteractionEnabled = true
            } else {
                cell.textLabel?.text = NSLocalizedString("linkNotAvailable",comment: "")
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
    var entityField = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(entityField)
        entityField.translatesAutoresizingMaskIntoConstraints = false
        entityField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        entityField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
}
