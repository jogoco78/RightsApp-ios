//
//  LanguageViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 10/06/2019.
//  Copyright © 2019 Jorge Gonzalez Conejero. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var pvSelectLanguage = UIPickerView()
    var tvSelectLanguage = UITextView()
    var tvAlertCloseApp = UITextView()
    var btnAccept = UIButton()
    @IBOutlet weak var tabBar: UITabBarItem!
    
    let languages = [NSLocalizedString("spanish",comment: ""), NSLocalizedString("english",comment: ""), NSLocalizedString("portuguese",comment: ""), NSLocalizedString("italian",comment: "")]
    let languageCodes = ["es","en","por","it"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //line spacing
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        
        view.addSubview(pvSelectLanguage)
        view.addSubview(tvSelectLanguage)
        view.addSubview(tvAlertCloseApp)
        view.addSubview(btnAccept)
        
        pvSelectLanguage.delegate = self
        pvSelectLanguage.dataSource = self
        
        tvSelectLanguage.translatesAutoresizingMaskIntoConstraints = false
        tvSelectLanguage.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        tvSelectLanguage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        tvSelectLanguage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        tvSelectLanguage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        var s = NSMutableAttributedString(string: NSLocalizedString("languageText",comment: ""), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        tvSelectLanguage.attributedText = s
        
        tvAlertCloseApp.translatesAutoresizingMaskIntoConstraints = false
        tvAlertCloseApp.topAnchor.constraint(equalTo: tvSelectLanguage.bottomAnchor, constant: 20).isActive = true
        tvAlertCloseApp.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        tvAlertCloseApp.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        tvAlertCloseApp.heightAnchor.constraint(equalToConstant: 70).isActive = true
        s = NSMutableAttributedString(string: NSLocalizedString("alertLanguageChange",comment: ""), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        tvAlertCloseApp.attributedText = s
        
        btnAccept.translatesAutoresizingMaskIntoConstraints = false
        btnAccept.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        btnAccept.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        btnAccept.widthAnchor.constraint(equalToConstant: 70).isActive = true
        btnAccept.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnAccept.setTitle(NSLocalizedString("accept",comment: ""), for: .normal)
        btnAccept.setTitleColor(UIColor.blue, for: .normal)
        btnAccept.addTarget(self, action: #selector(btnAcceptListener), for: .touchUpInside)
        
        
        pvSelectLanguage.translatesAutoresizingMaskIntoConstraints = false
        pvSelectLanguage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pvSelectLanguage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        pvSelectLanguage.widthAnchor.constraint(equalToConstant: 275).isActive = true
        pvSelectLanguage.heightAnchor.constraint(equalToConstant: 275).isActive = true
        
    }
    
    @objc func btnAcceptListener(sender: UIButton){
        let selectedLanguage = pvSelectLanguage.selectedRow(inComponent: 0)
        UserDefaults.standard.set([languageCodes[selectedLanguage]], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        let alertController = UIAlertController(title: NSLocalizedString("language",comment: ""), message: NSLocalizedString("alertLanguageChange",comment: ""), preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("accept",comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            exit(0)
        }
        /*let cancelAction = UIAlertAction(title: "Restart later".localized(), style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }*/
        alertController.addAction(okAction)
        //alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarItem.title = NSLocalizedString("language",comment: "")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarItem.title = ""
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
    }

    @IBAction func selectLanguage(_ sender: UIButton) {
        /*let vc = self.storyboard?.instantiateViewController(withIdentifier: "Language") as! ViewController
        let appDlg = UIApplication.shared.delegate as? AppDelegate
        appDlg?.window?.rootViewController = vc*/
    }
    
}
