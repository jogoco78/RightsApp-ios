//
//  SearchEntityViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 26/06/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

private let entityCellIdentifier = "entityCell"
private let countryCellIdentifier = "countryCell"
private let cityCellIdentifier = "cityCell"

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

// MARK: - ViewController main class

class SearchEntityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    var entityTableView: UITableView!
    var countryTableView: UITableView!
    var cityTableView: UITableView!
    var showEntity = false
    var showCountry = false
    var showCity = false
    var language = LocalizationSystem.sharedInstance.getLanguage()
    
    // MARK: - DB Results
    var categories = [CategoryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureTableView()
        
        if DBManager.shared.openDatabase(){
            categories = DBManager.shared.getCategoriesList(language: language)
            categories.insert(CategoryModel(0, NSLocalizedString("allEntities",comment: ""), language), at: 0)
        }
        
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
            entityTableView.insertRows(at: indexPaths, with: .fade)
        } else {
            entityTableView.deleteRows(at: indexPaths, with: .fade)
        }
        print("Drop down menu entity...")
    }
    
    @objc func handleDropDownCountry(){
        showCountry = !showCountry
        
        var indexPaths = [IndexPath]()
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        indexPaths.append(indexPath)
        
        if showCountry {
            countryTableView.insertRows(at: indexPaths, with: .fade)
        } else {
            countryTableView.deleteRows(at: indexPaths, with: .fade)
        }
        print("Drop down menu country...")
    }
    
    @objc func handleDropDownCity(){
        showCity = !showCity
        
        var indexPaths = [IndexPath]()
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        indexPaths.append(indexPath)
        
        if showCity {
            cityTableView.insertRows(at: indexPaths, with: .fade)
        } else {
            cityTableView.deleteRows(at: indexPaths, with: .fade)
        }
        print("Drop down menu city...")
    }
    
    func configureTableView(){
        entityTableView = UITableView()
        countryTableView = UITableView()
        cityTableView = UITableView()
        
        entityTableView.delegate = self
        entityTableView.dataSource = self
        countryTableView.delegate = self
        countryTableView.dataSource = self
        cityTableView.delegate = self
        cityTableView.dataSource = self
        
        entityTableView.register(entityTableViewCell.self , forCellReuseIdentifier: entityCellIdentifier)
        countryTableView.register(countryTableViewCell.self, forCellReuseIdentifier: countryCellIdentifier)
        cityTableView.register(cityTableViewCell.self, forCellReuseIdentifier: cityCellIdentifier)
        
        entityTableView.translatesAutoresizingMaskIntoConstraints = false
        countryTableView.translatesAutoresizingMaskIntoConstraints = false
        cityTableView.translatesAutoresizingMaskIntoConstraints = false
        
        entityTableView.rowHeight = 50
        countryTableView.rowHeight = 50
        cityTableView.rowHeight = 50
        
        entityTableView.separatorStyle = .none
        countryTableView.separatorStyle = .none
        cityTableView.separatorStyle = .none
        
        view.addSubview(entityTableView)
        view.addSubview(countryTableView)
        view.addSubview(cityTableView)
        
        entityTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        entityTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        entityTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        entityTableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        countryTableView.topAnchor.constraint(equalTo: entityTableView.bottomAnchor, constant: 20).isActive = true
        countryTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        countryTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        countryTableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        cityTableView.topAnchor.constraint(equalTo: countryTableView.bottomAnchor, constant: 20).isActive = true
        cityTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        cityTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        cityTableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        
        switch tableView {
        case entityTableView:
            numberOfRows = showEntity ? categories.count : 0
        case countryTableView:
            numberOfRows = showCountry ? 1 : 0
        case cityTableView:
            numberOfRows = showCity ? 1 : 0
        default:
            print("Something went wrong")
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch tableView {
        case entityTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: entityCellIdentifier, for: indexPath) as! entityTableViewCell
            cell.textLabel?.text = categories[indexPath.row].text
        case countryTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: countryCellIdentifier, for: indexPath) as! countryTableViewCell
            cell.textLabel?.text = "Hello2"
        case cityTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: cityCellIdentifier, for: indexPath) as! cityTableViewCell
            cell.textLabel?.text = "Hello3"
        default:
            print("Something went wrong")
        }
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        
        switch tableView {
        case entityTableView:
            button.setTitle("Select entity", for: .normal)
            button.addTarget(self, action: #selector(handleDropDownEntity), for: .touchUpInside)
        case countryTableView:
            button.setTitle("Select country", for: .normal)
            button.addTarget(self, action: #selector(handleDropDownCountry), for: .touchUpInside)
        case cityTableView:
            button.setTitle("Select city", for: .normal)
            button.addTarget(self, action: #selector(handleDropDownCity), for: .touchUpInside)
        default:
            print("Something went wrong")
        }
        
        return button
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
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

