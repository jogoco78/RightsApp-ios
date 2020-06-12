//
//  EntityDetailsViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 27/06/2019.
//  Copyright © 2019 Jorge Gonzalez Conejero. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class EntityDetailsViewController: UIViewController {
    
    var entity: EntityModel!
    //var tvEntityDetails = UITextView()
    
    var tv_entity_title = UITextView()
    var tv_entity_description = UITextView()
    var tv_entity_address = UITextView()
    var tv_entity_phone = UITextView()
    var tv_entity_phone2 = UITextView()
    var tv_entity_link = UITextView()
    var tv_entity_email = UITextView()
    var ib_call = UIButton()
    var ib_call_2 = UIButton()
    var ib_navigate = UIButton()
    var ib_email = UIButton()
    var ib_link = UIButton()
    
    var language = LocalizationSystem.sharedInstance.getLanguage()
    var entityID = UserDefaults.standard.integer(forKey: Constants.keys.entitySelected)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Sets right bar button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "AppIcon"), style: .plain, target: self, action: #selector(self.goHome))
        
        if DatabaseHelper.shared.openDatabase(){
            entity = DatabaseHelper.shared.getEntitiesList(idEntity: entityID, idCategory: nil, idCountry: nil, idCity: nil, language: language)[0]
        }
        
        view.addSubview(tv_entity_title)
        view.addSubview(tv_entity_description)
        view.addSubview(tv_entity_address)
        view.addSubview(tv_entity_phone)
        view.addSubview(tv_entity_phone2)
        view.addSubview(tv_entity_link)
        view.addSubview(tv_entity_email)
        view.addSubview(ib_navigate)
        view.addSubview(ib_call)
        view.addSubview(ib_call_2)
        view.addSubview(ib_email)
        view.addSubview(ib_link)

        //Sets the image for the buttons
        let image_navigate = UIImage(named: "Navigate")
        ib_navigate.setImage(image_navigate, for: .normal)
        
        let image_call = UIImage(named: "Phone")
        ib_call.setImage(image_call, for: .normal)
        
        let image_call_2 = UIImage(named: "Phone")
        ib_call_2.setImage(image_call_2, for: .normal)
        
        let image_mail = UIImage(named: "Mail")
        ib_email.setImage(image_mail, for: .normal)
        
        let image_link = UIImage(named: "Browser")
        ib_link.setImage(image_link, for: .normal)
        
        //Title constraints
        tv_entity_title.translatesAutoresizingMaskIntoConstraints = false
        tv_entity_title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
       // tv_entity_title.bottomAnchor.constraint(equalTo: tv_entity_description.topAnchor, constant: -5).isActive = true
        tv_entity_title.heightAnchor.constraint(equalToConstant: 100).isActive = true
        tv_entity_title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        tv_entity_title.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        tv_entity_title.isEditable = false
        tv_entity_title.isScrollEnabled = false
        tv_entity_title.sizeToFit()
        
        //Description constraints
        tv_entity_description.translatesAutoresizingMaskIntoConstraints = false
        tv_entity_description.topAnchor.constraint(equalTo: tv_entity_title.bottomAnchor, constant: -35).isActive = true
        tv_entity_description.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        tv_entity_description.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        tv_entity_description.isScrollEnabled = false
        tv_entity_description.isEditable = false
        tv_entity_description.sizeToFit()
        
        //Address constraints
        tv_entity_address.translatesAutoresizingMaskIntoConstraints = false
        tv_entity_address.topAnchor.constraint(equalTo: tv_entity_description.bottomAnchor, constant: -10).isActive = true
        tv_entity_address.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        tv_entity_address.rightAnchor.constraint(equalTo: ib_navigate.leftAnchor, constant: -20).isActive = true
        tv_entity_address.isScrollEnabled = false
        tv_entity_address.isEditable = false
        tv_entity_address.sizeToFit()
        
        //Maps button constraints & listener
        ib_navigate.translatesAutoresizingMaskIntoConstraints = false
        ib_navigate.centerYAnchor.constraint(equalTo: tv_entity_address.centerYAnchor, constant: 5).isActive = true
        ib_navigate.leftAnchor.constraint(equalTo: tv_entity_description.rightAnchor, constant: 20).isActive = true
        ib_navigate.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        ib_navigate.widthAnchor.constraint(equalToConstant: 40).isActive = true
        ib_navigate.heightAnchor.constraint(equalToConstant: 40).isActive = true
        ib_navigate.backgroundColor = .white
        //ib_navigate.layer.borderWidth = 3
        ib_navigate.layer.opacity = 50
        ib_navigate.addTarget(self, action: #selector(mapsListener), for: .touchUpInside)
        
        //Phone constraints
        tv_entity_phone.translatesAutoresizingMaskIntoConstraints = false
        tv_entity_phone.topAnchor.constraint(equalTo: tv_entity_address.bottomAnchor, constant: -10).isActive = true
        tv_entity_phone.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        tv_entity_phone.rightAnchor.constraint(equalTo: ib_call.leftAnchor, constant: -20).isActive = true
        tv_entity_phone.isScrollEnabled = false
        tv_entity_phone.isEditable = false
        tv_entity_phone.sizeToFit()
        
        //Call button constraints & listener
        ib_call.translatesAutoresizingMaskIntoConstraints = false
        ib_call.centerYAnchor.constraint(equalTo: tv_entity_phone.centerYAnchor, constant: 10).isActive = true
        ib_call.leftAnchor.constraint(equalTo: tv_entity_phone.rightAnchor, constant: 20).isActive = true
        ib_call.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        ib_call.widthAnchor.constraint(equalToConstant: 30).isActive = true
        ib_call.heightAnchor.constraint(equalToConstant: 30).isActive = true
        ib_call.backgroundColor = .white
        //ib_call.layer.borderWidth = 3
        ib_call.layer.opacity = 50
        ib_call.addTarget(self, action: #selector(callPhoneListener), for: .touchUpInside)
        
        //Phone2 constraints
        tv_entity_phone2.translatesAutoresizingMaskIntoConstraints = false
        tv_entity_phone2.topAnchor.constraint(equalTo: tv_entity_phone.bottomAnchor, constant: -10).isActive = true
        tv_entity_phone2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        tv_entity_phone2.rightAnchor.constraint(equalTo: ib_call_2.leftAnchor, constant: -20).isActive = true
        tv_entity_phone2.isScrollEnabled = false
        tv_entity_phone2.isEditable = false
        tv_entity_phone2.sizeToFit()
        
        //Call button 2 constraints & listener
        ib_call_2.translatesAutoresizingMaskIntoConstraints = false
        ib_call_2.centerYAnchor.constraint(equalTo: tv_entity_phone2.centerYAnchor, constant: 10).isActive = true
        ib_call_2.leftAnchor.constraint(equalTo: tv_entity_phone2.rightAnchor, constant: 20).isActive = true
        ib_call_2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        ib_call_2.widthAnchor.constraint(equalToConstant: 30).isActive = true
        ib_call_2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        ib_call_2.backgroundColor = .white
        //ib_call_2.layer.borderWidth = 3
        ib_call_2.layer.opacity = 50
        ib_call_2.addTarget(self, action: #selector(callPhone2Listener), for: .touchUpInside)
        
        //EMail constraints
        tv_entity_email.translatesAutoresizingMaskIntoConstraints = false
        tv_entity_email.topAnchor.constraint(equalTo: tv_entity_phone2.bottomAnchor, constant: -10).isActive = true
        tv_entity_email.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        tv_entity_email.rightAnchor.constraint(equalTo: ib_email.leftAnchor, constant: -20).isActive = true
        tv_entity_email.isScrollEnabled = false
        tv_entity_email.isEditable = false
        tv_entity_email.sizeToFit()
        
        //EMail button constraints & listener
        ib_email.translatesAutoresizingMaskIntoConstraints = false
        ib_email.centerYAnchor.constraint(equalTo: tv_entity_email.centerYAnchor, constant: 10).isActive = true
        ib_email.leftAnchor.constraint(equalTo: tv_entity_email.rightAnchor, constant: 20).isActive = true
        ib_email.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        ib_email.widthAnchor.constraint(equalToConstant: 30).isActive = true
        ib_email.heightAnchor.constraint(equalToConstant: 25).isActive = true
        ib_email.backgroundColor = .white
        //ib_email.layer.borderWidth = 3
        ib_email.layer.opacity = 50
        ib_email.addTarget(self, action: #selector(emailListener), for: .touchUpInside)
        
        //Link constraints
        tv_entity_link.translatesAutoresizingMaskIntoConstraints = false
        tv_entity_link.topAnchor.constraint(equalTo: tv_entity_email.bottomAnchor, constant: -10).isActive = true
        tv_entity_link.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        tv_entity_link.rightAnchor.constraint(equalTo: ib_link.leftAnchor, constant: -20).isActive = true
        tv_entity_link.isScrollEnabled = false
        tv_entity_link.isEditable = false
        tv_entity_link.sizeToFit()
        
        //Link button constraints & listener
        ib_link.translatesAutoresizingMaskIntoConstraints = false
        ib_link.centerYAnchor.constraint(equalTo: tv_entity_link.centerYAnchor, constant: 10).isActive = true
        ib_link.leftAnchor.constraint(equalTo: tv_entity_link.rightAnchor, constant: 20).isActive = true
        ib_link.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        ib_link.widthAnchor.constraint(equalToConstant: 30).isActive = true
        ib_link.heightAnchor.constraint(equalToConstant: 30).isActive = true
        ib_link.backgroundColor = .white
        //ib_link.layer.borderWidth = 3
        ib_link.layer.opacity = 50
        ib_link.addTarget(self, action: #selector(linkListener), for: .touchUpInside)
        
        
        //Attributes of the text
        let font = UIFont(name: "Roboto-Medium", size: 14)
        let font_bold = UIFont(name: "Roboto-Black", size: 14)
        let font_title = UIFont(name: "Roboto-Black", size: 23)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        paragraphStyle.alignment = .justified
        paragraphStyle.paragraphSpacing = 5
        
        let paragraphStyle_title = NSMutableParagraphStyle()
        paragraphStyle_title.lineSpacing = 1
        paragraphStyle_title.alignment = .center
        paragraphStyle_title.paragraphSpacing = 0
        
        let attributes_title: [NSAttributedString.Key: Any] = [
            .font: font_title!,
            .foregroundColor: UIColor.black,
            .paragraphStyle: paragraphStyle_title]
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black,
            .paragraphStyle: paragraphStyle]
        
        let attributes_bold: [NSAttributedString.Key: Any] = [
        .font: font_bold,
        .foregroundColor: UIColor.black,
        .paragraphStyle: paragraphStyle]
        
        //Title text
        tv_entity_title.attributedText = NSMutableAttributedString(string: entity.entityName, attributes: attributes_title)
        
        //Entity description text
        if entity.entityDescription != nil {
            tv_entity_description.attributedText = NSMutableAttributedString(string: entity.entityDescription, attributes: attributes)
        }else {
            tv_entity_description.attributedText = NSMutableAttributedString(string: NSLocalizedString("descriptionNotAvailable", comment: ""), attributes: attributes)
        }
        
        //Address text
        if entity.address != nil {
            var s = NSMutableAttributedString(string: NSLocalizedString("address",comment: "") + ": " + entity.address, attributes: attributes)
            if entity.cityName != nil {
                s.append(NSMutableAttributedString(string: ", " + entity.cityName , attributes: attributes))
            }
            tv_entity_address.attributedText = s
        }else {
            ib_navigate.removeFromSuperview()
            tv_entity_address.attributedText = NSMutableAttributedString(string: NSLocalizedString("addressNotAvailable", comment: ""), attributes: attributes)
        }
        
        //Phone text
        if entity.phoneNumber != nil {
            tv_entity_phone.attributedText = NSMutableAttributedString(string: NSLocalizedString("phone",comment: "") + ": " + entity.phoneNumber, attributes: attributes)
        }else {
            ib_call.removeFromSuperview()
            tv_entity_phone.attributedText = NSMutableAttributedString(string: NSLocalizedString("phoneNotAvailable", comment: ""), attributes: attributes)
        }
        
        //Phone text 2
        if entity.phoneNumber2 != nil {
            tv_entity_phone2.attributedText = NSMutableAttributedString(string: NSLocalizedString("phone",comment: "") + ": " + entity.phoneNumber2, attributes: attributes)
        }else {
            ib_call_2.removeFromSuperview()
            tv_entity_phone2.attributedText = NSMutableAttributedString(string: NSLocalizedString("phone2NotAvailable", comment: ""), attributes: attributes)
        }
        
        //Email text
        if entity.email != nil {
            tv_entity_email.attributedText = NSMutableAttributedString(string: NSLocalizedString("email",comment: "") + ": " + entity.email, attributes: attributes)
        }else {
            ib_email.removeFromSuperview()
            tv_entity_email.attributedText = NSMutableAttributedString(string: NSLocalizedString("emailNotAvailable", comment: ""), attributes: attributes)
        }
        
        //Link text
        if entity.link != nil {
            tv_entity_link.attributedText = NSMutableAttributedString(string: NSLocalizedString("link",comment: "") + ": " + entity.link , attributes: attributes)
        }else {
            ib_link.removeFromSuperview()
            tv_entity_link.attributedText = NSMutableAttributedString(string: NSLocalizedString("linkNotAvailable", comment: ""), attributes: attributes)
        }
    }
    
    @objc func goHome(){
        performSegue(withIdentifier: "detailsToMainSegue", sender: nil)
    }
    
    @objc func mapsListener(){
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: entity.latitude, longitude: entity.longitude)))
        destination.name = entity.entityName
               
        MKMapItem.openMaps(with: [destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    @objc func callPhoneListener(){
        guard let number = URL(string: "tel://" + entity.phoneNumber) else { return }
        UIApplication.shared.open(number)
    }
    
    @objc func callPhone2Listener(){
        guard let number = URL(string: "tel://" + entity.phoneNumber2) else { return }
        UIApplication.shared.open(number)
    }
    
    @objc func emailListener(){
        guard let email = URL(string: "mailto:" + entity.email) else { return}
        UIApplication.shared.open(email)
    }
    
    @objc func linkListener(){
        guard let link = URL(string: entity.link) else { return}
        UIApplication.shared.open(link)
    }
}
