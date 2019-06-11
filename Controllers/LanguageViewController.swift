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
        pv_selectLanguage.selectedRow(inComponent: 0)
        //TODO: Change application language
        
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
