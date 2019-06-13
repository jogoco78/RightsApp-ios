//
//  QuestionnaireViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 11/06/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

class QuestionnaireViewController: UIViewController {

    
    @IBOutlet var myView: UIView!
    @IBOutlet weak var tvQuestion: UITextView!
    @IBOutlet weak var btQuestionnaireContinue: UIButton!
    
    var idCurrentQuestion = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Sets the text of the current question
        tvQuestion.text = getQuestionText()
        
        btQuestionnaireContinue.setTitle(NSLocalizedString("continue", comment: ""),for: .normal)
    }
    
    func getQuestionText() -> String {
        var results = ""
        //var a: CityModel = CityModel()
        //print(a.id)
        //a.id = 6
        //print(a.id)
        if DBManager.shared.openDatabase(){
            results = DBManager.shared.getQuestionText(id_question: idCurrentQuestion, language: "en")
            print(results)
        }
        return results
        
        
       // let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
       // let databaseURL = fileURL.appendingPathComponent("rightsapp_v5_utf16.db")
       // let database = FMDatabase(path: databaseURL.absoluteString)
        
       // guard database.open() else {
       //     print("Unable to open database")
       //     return
       // }
        
       // do {
       //     let cities:FMResultSet = try database.executeQuery("SELECT * from cities", values: nil)
            
       //     while cities.next() {
       //         if let result = cities.string(forColumn: "city_es") {
       //             print(result)
       //         }
       //     }
       // } catch {
       //     print("OOPS, some sort of failure")
       // }
    }
  
   
    @IBAction func btQuestionnaireContinue(_ sender: UIButton) {
       //configureRefreshControl()
        idCurrentQuestion += 1
        print(idCurrentQuestion)
        tvQuestion.setNeedsDisplay()
    
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
