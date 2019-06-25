//
//  LanguageViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 10/06/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var tv_selectLanguage: UITextView!
    @IBOutlet weak var pv_selectLanguage: UIPickerView!
    @IBOutlet weak var bt_continue: UIButton!
    
    let languages = [NSLocalizedString("spanish",comment: ""), NSLocalizedString("english",comment: ""), NSLocalizedString("portuguese",comment: ""), NSLocalizedString("italian",comment: "")]
    let languageCodes = ["es","en","pt","it"]
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //line spacing
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        
        pv_selectLanguage.delegate = self
        pv_selectLanguage.dataSource = self
        bt_continue.setTitle(NSLocalizedString("continue", comment: ""), for: .normal)
        
        let s = NSMutableAttributedString(string: NSLocalizedString("languageText",comment: ""), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        tv_selectLanguage.attributedText = s
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
        let selectedLanguage = pv_selectLanguage.selectedRow(inComponent: 0)
        
        LocalizationSystem.sharedInstance.setLanguage(languageCode: languageCodes[selectedLanguage])
        viewDidLoad()
        
        //Shows an alert: the user should accept at least one option in the questionnaire
        //let alert = UIAlertController(title: nil, message: NSMutableAttributedString(string: NSLocalizedString("appOwnership",comment: "Comment"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)]), preferredStyle: .alert)
        
        let alert = UIAlertController(title: nil, message: NSLocalizedString("alertLanguageChange", comment: ""), preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 125)
        alert.view.addConstraint(height)
        
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
            alert.dismiss(animated: true)
        }
        /*let vc = self.storyboard?.instantiateViewController(withIdentifier: "Language") as! ViewController
        let appDlg = UIApplication.shared.delegate as? AppDelegate
        appDlg?.window?.rootViewController = vc*/
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
