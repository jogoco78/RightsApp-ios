//
//  SearchEntityPickerViewController.swift
//  RightsApp
//
//  Created by Jorge Gonzalez Conejero on 11/06/2020.
//  Copyright © 2020 uab. All rights reserved.
//

import UIKit

class SearchEntityPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    let lbl_title = UILabel()
    let lbl_entity_title = UILabel()
    let lbl_country_title = UILabel()
    let lbl_city_title = UILabel()
    var lbl_entity_selected = UILabel()
    var lbl_country_selected = UILabel()
    var lbl_city_selected = UILabel()
    var btn_select_entity = UIButton()
    var btn_select_country = UIButton()
    var btn_select_city = UIButton()
    
    var picker = UIPickerView()
    var pickerData: [String] = [String]()
    var pickerData_entities: [String] = [String]()
    var pickerData_countries: [String] = [String]()
    var pickerData_cities: [String] = [String]()
    
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
        
        navBar.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("done", comment: ""), style: .done, target: self, action: #selector(self.doneListener))
        
        navBar.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("back", comment: ""), style: .done, target: self, action: #selector(self.backListener))
                    
        self.picker.delegate = self
        self.picker.dataSource = self
        
        view.addSubview(lbl_title)
        view.addSubview(lbl_entity_title)
        view.addSubview(lbl_country_title)
        view.addSubview(lbl_city_title)
        view.addSubview(lbl_entity_selected)
        view.addSubview(lbl_country_selected)
        view.addSubview(lbl_city_selected)
        view.addSubview(picker)
        view.addSubview(btn_select_entity)
        view.addSubview(btn_select_country)
        view.addSubview(btn_select_city)
        
        //Retrieval information from DB
        if DatabaseHelper.shared.openDatabase(){
            categories = DatabaseHelper.shared.getCategoriesList(language: language)
            categories.insert(CategoryModel(0, NSLocalizedString("allEntities",comment: ""), language), at: 0)
            cities = DatabaseHelper.shared.getCitiesList(idCities: nil, language: language)
            cities.insert(CityModel(0, NSLocalizedString("allCities",comment: ""), 0, language), at: 0)
            countries = DatabaseHelper.shared.getCountriesList(idCountries: nil, language: language)
            countries.insert(CountryModel(0, NSLocalizedString("allCountries",comment: ""), language), at: 0)
        }
        
        //Title label text
        lbl_title.font = UIFont(name: "Roboto-Black", size: 24)
        lbl_title.text = NSLocalizedString("your_selection", comment: "")
        
        //Entity label text
        lbl_entity_title.font = UIFont(name: "Roboto-Medium", size: 16)
        lbl_entity_title.text = NSLocalizedString("selectEntity", comment: "")
        
        //Entity selected text
        lbl_entity_selected.font = UIFont(name: "Roboto-Medium", size: 16)
        lbl_entity_selected.text = categories[0].text
        
        //Country label text
        lbl_country_title.font = UIFont(name: "Roboto-Medium", size: 16)
        lbl_country_title.text = NSLocalizedString("selectCountry", comment: "")
        
        //Country selected text
        lbl_country_selected.font = UIFont(name: "Roboto-Medium", size: 16)
        lbl_country_selected.text = countries[0].countryName
        
        //City label text
        lbl_city_title.font = UIFont(name: "Roboto-Medium", size: 16)
        lbl_city_title.text = NSLocalizedString("selectCity", comment: "")
        
        //City selected
        lbl_city_selected.font = UIFont(name: "Roboto-Medium", size: 16)
        lbl_city_selected.text = cities[0].cityName
        
        pickerData = ["Item 1", "Item 2", "Item 3"]
        
        for entity in categories {
            pickerData_entities.append(entity.text)
        }
        for country in countries {
            pickerData_countries.append(country.countryName)
        }
        for city in cities {
            pickerData_cities.append(city.cityName)
        }
        
        //Entity title constraints
        lbl_title.translatesAutoresizingMaskIntoConstraints = false
        lbl_title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        lbl_title.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        //Entity label constraints
        lbl_entity_title.translatesAutoresizingMaskIntoConstraints = false
        lbl_entity_title.topAnchor.constraint(equalTo: lbl_title.bottomAnchor, constant: 25).isActive = true
        lbl_entity_title.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        lbl_entity_title.sizeToFit()
        
        //Entity selected constraints
        lbl_entity_selected.translatesAutoresizingMaskIntoConstraints = false
        lbl_entity_selected.topAnchor.constraint(equalTo: lbl_entity_title.bottomAnchor, constant: 0).isActive = true
        lbl_entity_selected.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        lbl_entity_selected.sizeToFit()
        
        //Country label constraints
        lbl_country_title.translatesAutoresizingMaskIntoConstraints = false
        lbl_country_title.topAnchor.constraint(equalTo: lbl_entity_selected.bottomAnchor, constant: 20).isActive = true
        lbl_country_title.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        lbl_country_title.sizeToFit()
        
        //Country selected constraints
        lbl_country_selected.translatesAutoresizingMaskIntoConstraints = false
        lbl_country_selected.topAnchor.constraint(equalTo: lbl_country_title.bottomAnchor, constant: 0).isActive = true
        lbl_country_selected.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        lbl_country_selected.sizeToFit()
        
        //City label constraints
        lbl_city_title.translatesAutoresizingMaskIntoConstraints = false
        lbl_city_title.topAnchor.constraint(equalTo: lbl_country_selected.bottomAnchor, constant: 20).isActive = true
        lbl_city_title.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        lbl_city_title.sizeToFit()
        
        //City selected constraints
        lbl_city_selected.translatesAutoresizingMaskIntoConstraints = false
        lbl_city_selected.topAnchor.constraint(equalTo: lbl_city_title.bottomAnchor, constant: 0).isActive = true
        lbl_city_selected.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        lbl_city_selected.sizeToFit()
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            //Categories
            return pickerData_entities.count
        case 1:
            //Countries
            return pickerData_countries.count
        case 2:
            //Cities
            return pickerData_cities.count
        default:
            // Do nothing
            return pickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Roboto-Medium", size: 13)
            pickerLabel?.textAlignment = .center
            pickerLabel?.numberOfLines = 0
        }
        
        if(component == 0){
            pickerLabel?.text = pickerData_entities[row]
        }else if(component == 1){
            pickerLabel?.text = pickerData_countries[row]
        }else if(component == 2){
            pickerLabel?.text = pickerData_cities[row]
        }

        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         // use the row to get the selected row from the picker view
         // using the row extract the value from your datasource (array[row])
        if(component == 0){
            //Entities
            lbl_entity_selected.text = categories[row].text
            entityIndexSelected = row
            if(row == 0){
                //All available entities
                cities = DatabaseHelper.shared.getCitiesList(idCities: nil, language: language)
                countries = DatabaseHelper.shared.getCountriesList(idCountries: nil, language: language)
            }else{
                cities = DatabaseHelper.shared.getCitiesFromCategories(idCategory: categories[row].id, language: language)
                var countries_list = [Int]()
                for city in cities {
                    countries_list.append(city.idCountry)
                }
                countries = DatabaseHelper.shared.getCountriesList(idCountries: countries_list, language: language)
            }
            //Adds all available countries and cities
            cities.insert(CityModel(0, NSLocalizedString("allCities",comment: ""), 0, language), at: 0)
            countries.insert(CountryModel(0, NSLocalizedString("allCountries",comment: ""), language), at: 0)
            
            //Deletes old data
            pickerData_countries.removeAll()
            pickerData_cities.removeAll()
            for country in countries {
                pickerData_countries.append(country.countryName)
            }
            for city in cities {
                pickerData_cities.append(city.cityName)
            }
            
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
            
            //Picker is updated to all cities option when updated
            pickerView.selectRow(0, inComponent: 2, animated: true)
            lbl_city_selected.text = cities[0].cityName
            cityIndexSelected = 0
        }else if(component == 1){
            //Countries
            lbl_country_selected.text = countries[row].countryName
            countryIndexSelected = row
            /*if(row == 0){
                cities = DatabaseHelper.shared.getCitiesList(idCities: nil, language: language)
            }else{
                cities = DatabaseHelper.shared.getCitiesFromCountry(idCountry: countries[row].id, language: language)
            }
            cities.insert(CityModel(0, NSLocalizedString("allCities",comment: ""), 0, language), at: 0)
            pickerData_cities.removeAll()
            for city in cities {
                pickerData_cities.append(city.cityName)
            }
            pickerView.reloadComponent(2)*/
        }else{
            //Cities
            lbl_city_selected.text = cities[row].cityName
            cityIndexSelected = row
        }
    }
    
    @objc func doneListener(){
        UserDefaults.standard.set(categories[entityIndexSelected].id, forKey:  Constants.keys.searchIDEntity)
        UserDefaults.standard.set(countries[countryIndexSelected].id, forKey: Constants.keys.searchIDCountry)
        UserDefaults.standard.set(cities[cityIndexSelected].id, forKey: Constants.keys.searchIDCity)
        
        performSegue(withIdentifier: "SearchEntityPickerToEntityListSegue", sender: nil)
    }
    
    @objc func backListener(){
        performSegue(withIdentifier: "searchToMainSegue", sender: nil)
    }
    
}
