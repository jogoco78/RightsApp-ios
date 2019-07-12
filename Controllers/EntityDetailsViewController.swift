//
//  EntityDetailsViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 27/06/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class EntityDetailsViewController: UIViewController {
    
    var entity: EntityModel!
    var tvEntityDetails = UITextView()
    var btnCall = UIButton()
    var btnNavigate = UIButton()
    
    var language = LocalizationSystem.sharedInstance.getLanguage()
    var entityID = UserDefaults.standard.integer(forKey: Constants.shared.entitySelected)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Sets right bar button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "AppIcon"), style: .plain, target: self, action: #selector(self.goHome))
        
        if DatabaseHelper.shared.openDatabase(){
            entity = DatabaseHelper.shared.getEntitiesList(idEntity: entityID, idCategory: nil, idCountry: nil, idCity: nil, language: language)[0]
        }
        
        view.addSubview(tvEntityDetails)
        view.addSubview(btnCall)
        view.addSubview(btnNavigate)
        
        //TextView properties
        tvEntityDetails.translatesAutoresizingMaskIntoConstraints = false
        tvEntityDetails.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        tvEntityDetails.bottomAnchor.constraint(equalTo: btnCall.topAnchor, constant: -5).isActive = true
        tvEntityDetails.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        tvEntityDetails.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        tvEntityDetails.isEditable = false
        
        //Text View text
        //line spacing
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        paragraphStyle.paragraphSpacing = 15
        
        var s = NSMutableAttributedString(string: entity.entityName + "\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let attributedText = s
        
        if entity.entityDescription != nil {
            s = NSMutableAttributedString(string: entity.entityDescription, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        }else {
            s = NSMutableAttributedString(string: NSLocalizedString("descriptionNotAvailable", comment: ""), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        }
        
        s.append(NSMutableAttributedString(string: Constants.shared.newLine, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]))
        attributedText.append(s)
        
        if entity.address != nil {
            s = NSMutableAttributedString(string: NSLocalizedString("address",comment: "") + ": " + entity.address, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
            if entity.cityName != nil {
                s.append(NSMutableAttributedString(string: ", " + entity.cityName , attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle]))
            }
        }else {
            s = NSMutableAttributedString(string: NSLocalizedString("addressNotAvailable", comment: ""), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        }
        
        attributedText.append(s)
        
        if entity.phoneNumber != nil {
            s = NSMutableAttributedString(string: "\n" + NSLocalizedString("phone",comment: "") + ": " + entity.phoneNumber, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        }else {
            s = NSMutableAttributedString(string: "\n" + NSLocalizedString("phoneNotAvailable", comment: ""), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        }
        attributedText.append(s)
        
        if entity.phoneNumber2 != nil {
            s = NSMutableAttributedString(string: "\n" + NSLocalizedString("phone",comment: "") + ": " + entity.phoneNumber2, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
            attributedText.append(s)
        }
        
        if entity.link != nil {
            s = NSMutableAttributedString(string: "\n" + NSLocalizedString("link",comment: "") + ": " + entity.phoneNumber2, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        }else {
            s = NSMutableAttributedString(string: "\n" + NSLocalizedString("linkNotAvailable", comment: ""), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        }
        attributedText.append(s)
        
        if entity.email != nil {
            s = NSMutableAttributedString(string: "\n" + NSLocalizedString("email",comment: "") + ": " + entity.email, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        }else {
            s = NSMutableAttributedString(string: "\n" + NSLocalizedString("emailNotAvailable", comment: ""), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        }
        attributedText.append(s)
        
        tvEntityDetails.attributedText = attributedText
        
        //Call button properties
        btnCall.translatesAutoresizingMaskIntoConstraints = false
        btnCall.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        //btnCall.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        btnCall.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        btnCall.setTitle(NSLocalizedString("call", comment: ""), for: .normal)
        btnCall.setTitleColor(UIColor.blue, for: .normal)
        
        btnCall.addTarget(self, action: #selector(btnCallListener), for: .touchUpInside)
        
        //Navigate button properties
        btnNavigate.translatesAutoresizingMaskIntoConstraints = false
        btnNavigate.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        btnNavigate.centerYAnchor.constraint(equalTo: btnCall.centerYAnchor).isActive = true
        btnNavigate.setTitle(NSLocalizedString("navigate", comment: ""), for: .normal)
        btnNavigate.setTitleColor(UIColor.blue, for: .normal)
        
        btnNavigate.addTarget(self, action: #selector(btnNavigateListener), for: .touchUpInside)
    }
    
    @objc func goHome(){
        performSegue(withIdentifier: "detailsToMainSegue", sender: nil)
    }
    
    @objc func btnNavigateListener(sender: UIButton) {
        //let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng)))
        //source.name = "Source"
        
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: entity.latitude, longitude: entity.longitude)))
        destination.name = "Destination"
        
        MKMapItem.openMaps(with: [destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    @objc func btnCallListener(sender: UIButton) {
        if entity.phoneNumber != nil {
            guard let number = URL(string: "tel://" + entity.phoneNumber) else { return }
                UIApplication.shared.open(number)
        } else {
            if entity.phoneNumber2 != nil {
                guard let number = URL(string: "tel://" + entity.phoneNumber2) else { return }
                UIApplication.shared.open(number)
            }else {
                //Shows an alert: terms and conditions must be accepted
                let alert = UIAlertController(title: nil, message: NSLocalizedString("phoneNotAvailable", comment: ""), preferredStyle: .alert)
                alert.view.backgroundColor = UIColor.black
                alert.view.alpha = 0.6
                alert.view.layer.cornerRadius = 15
                
                self.present(alert, animated: true)
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
                    alert.dismiss(animated: true)
                }
            }
        }
    }
}
