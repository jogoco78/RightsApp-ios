//
//  SearchEntityViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 26/06/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit
import CoreLocation

private let entityCellIdentifier = "entityCell"
private let countryCellIdentifier = "countryCell"
private let cityCellIdentifier = "cityCell"



// MARK: - ViewController main class

class SearchEntityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var navBarEntity: UINavigationItem!
    
    // MARK: - Properties
    var categoryTableView: UITableView!
    var countryTableView: UITableView!
    var cityTableView: UITableView!
    var showEntity = true
    var showCountry = true
    var showCity = true
    var language = LocalizationSystem.sharedInstance.getLanguage()
    
    // MARK: - DB Results
    var categories = [CategoryModel]()
    var cities = [CityModel]()
    var countries = [CountryModel]()
    
    // MARK: - Selected rows for entity, country and city
    var entityIndexSelected = 0
    var countryIndexSelected = 0
    var cityIndexSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("searchEntityTitle",comment: "Comment")
        
        // Do any additional setup after loading the view.
        configureTableView()
        
        if DatabaseHelper.shared.openDatabase(){
            categories = DatabaseHelper.shared.getCategoriesList(language: language)
            categories.insert(CategoryModel(0, NSLocalizedString("allEntities",comment: ""), language), at: 0)
            cities = DatabaseHelper.shared.getCitiesList(idCities: nil, language: language)
            cities.insert(CityModel(0, NSLocalizedString("allCities",comment: ""), 0, language), at: 0)
            countries = DatabaseHelper.shared.getCountriesList(idCountries: nil, language: language)
            countries.insert(CountryModel(0, NSLocalizedString("allCountries",comment: ""), language), at: 0)
        }
        
        navBarEntity.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "AppIcon"), style: .plain, target: self, action: #selector(self.goHome))
    }
    
    @objc func goHome(){
        performSegue(withIdentifier: "searchToMainSegue", sender: nil)
    }

    //Configure tableviews (position, size, etc.)
    func configureTableView(){
        categoryTableView = UITableView()
        countryTableView = UITableView()
        cityTableView = UITableView()
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        countryTableView.delegate = self
        countryTableView.dataSource = self
        cityTableView.delegate = self
        cityTableView.dataSource = self
        
        categoryTableView.register(entityTableViewCell.self , forCellReuseIdentifier: entityCellIdentifier)
        countryTableView.register(countryTableViewCell.self, forCellReuseIdentifier: countryCellIdentifier)
        cityTableView.register(cityTableViewCell.self, forCellReuseIdentifier: cityCellIdentifier)
        
        categoryTableView.translatesAutoresizingMaskIntoConstraints = false
        countryTableView.translatesAutoresizingMaskIntoConstraints = false
        cityTableView.translatesAutoresizingMaskIntoConstraints = false
        
        categoryTableView.rowHeight = 50
        countryTableView.rowHeight = 50
        cityTableView.rowHeight = 50
        
        categoryTableView.separatorStyle = .none
        countryTableView.separatorStyle = .none
        cityTableView.separatorStyle = .none
        
        view.addSubview(categoryTableView)
        view.addSubview(countryTableView)
        view.addSubview(cityTableView)
        
        categoryTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        categoryTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        categoryTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        categoryTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30).isActive = true
        
        countryTableView.topAnchor.constraint(equalTo: categoryTableView.bottomAnchor, constant: 5).isActive = true
        countryTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        countryTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        countryTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30).isActive = true
        
        cityTableView.topAnchor.constraint(equalTo: countryTableView.bottomAnchor, constant: 5).isActive = true
        cityTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        cityTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        cityTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        
        switch tableView {
        case categoryTableView:
            numberOfRows = showEntity ? categories.count : 0
        case countryTableView:
            numberOfRows = showCountry ? countries.count : 0
        case cityTableView:
            numberOfRows = showCity ? cities.count : 0
        default:
            print("Something went wrong")
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch tableView {
        case categoryTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: entityCellIdentifier, for: indexPath) as! entityTableViewCell
            cell.textLabel?.text = categories[indexPath.row].text
        case countryTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: countryCellIdentifier, for: indexPath) as! countryTableViewCell
            cell.textLabel?.text = countries[indexPath.row].countryName
        case cityTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: cityCellIdentifier, for: indexPath) as! cityTableViewCell
            cell.textLabel?.text = cities[indexPath.row].cityName
        default:
            print("Something went wrong")
        }
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        
        switch tableView {
        case categoryTableView:
            button.setAttributedTitle(NSMutableAttributedString(string: NSLocalizedString("selectEntity",comment: ""), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
            button.addTarget(self, action: #selector(handleDropDownEntity), for: .touchUpInside)
        case countryTableView:
            button.setAttributedTitle(NSMutableAttributedString(string: NSLocalizedString("selectCountry",comment: ""), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
            button.addTarget(self, action: #selector(handleDropDownCountry), for: .touchUpInside)
        case cityTableView:
            button.setAttributedTitle(NSMutableAttributedString(string: NSLocalizedString("selectCity",comment: ""), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
            button.addTarget(self, action: #selector(handleDropDownCity), for: .touchUpInside)
        default:
            print("Something went wrong")
        }
        button.backgroundColor = UIColor.blue
        return button
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case categoryTableView:
            entityIndexSelected = indexPath.row
        case countryTableView:
            countryIndexSelected = indexPath.row
            
            //Reloads the cities available when a country is selected
            if DatabaseHelper.shared.openDatabase(){
                //categories = DatabaseHelper.shared.getCategoriesList(language: language)
                //categories.insert(CategoryModel(0, NSLocalizedString("allEntities",comment: ""), language), at: 0)
                
                if countryIndexSelected == 0{
                    cities = DatabaseHelper.shared.getCitiesList(idCities: nil, language: language)
                } else {
                    cities = DatabaseHelper.shared.getCitiesFromCountry(idCountry: countries[countryIndexSelected].id, language: language)
                }
                cities.insert(CityModel(0, NSLocalizedString("allCities",comment: ""), 0, language), at: 0)
                    
                //countries = DatabaseHelper.shared.getCountriesList(idCountries: nil, language: language)
                //countries.insert(CountryModel(0, NSLocalizedString("allCountries",comment: ""), language), at: 0)
            }
            cityTableView.reloadData()
        case cityTableView:
            cityIndexSelected = indexPath.row
        default:
            print("Something went wrong")
        }
    }
    
    //Button listener
    @IBAction func btnSearchAction(_ sender: UIButton) {
        UserDefaults.standard.set(categories[entityIndexSelected].id, forKey:  Constants.shared.searchIDEntity)
        UserDefaults.standard.set(countries[countryIndexSelected].id, forKey: Constants.shared.searchIDCountry)
        UserDefaults.standard.set(cities[cityIndexSelected].id, forKey: Constants.shared.searchIDCity)
        
        performSegue(withIdentifier: "SearchEntityToEntityListSegue", sender: nil)
    }
    
    // MARK: - Selectors
    
    @objc func handleDropDownEntity(){
        showEntity = !showEntity
        
        var indexPaths = [IndexPath]()
        
        for category in categories {
            let indexPath = IndexPath(row: categories.firstIndex{$0 === category}!, section: 0)
            indexPaths.append(indexPath)
        }
        
        if showEntity {
            categoryTableView.insertRows(at: indexPaths, with: .fade)
        } else {
            categoryTableView.deleteRows(at: indexPaths, with: .fade)
        }
    }
    
    @objc func handleDropDownCountry(){
        showCountry = !showCountry
        
        var indexPaths = [IndexPath]()
        
        for country in countries {
            let indexPath = IndexPath(row: countries.firstIndex{$0 === country}!, section: 0)
            indexPaths.append(indexPath)
        }
        
        if showCountry {
            countryTableView.insertRows(at: indexPaths, with: .fade)
        } else {
            countryTableView.deleteRows(at: indexPaths, with: .fade)
        }
    }
    
    @objc func handleDropDownCity(){
        showCity = !showCity
        
        var indexPaths = [IndexPath]()
        
        for city in cities {
            let indexPath = IndexPath(row: cities.firstIndex{$0 === city}!, section: 0)
            indexPaths.append(indexPath)
        }
        
        if showCity {
            cityTableView.insertRows(at: indexPaths, with: .fade)
        } else {
            cityTableView.deleteRows(at: indexPaths, with: .fade)
        }
    }
}

// MARK: - TableViewCells

class entityTableViewCell: UITableViewCell {
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

class countryTableViewCell: UITableViewCell {
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

class cityTableViewCell: UITableViewCell {
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

