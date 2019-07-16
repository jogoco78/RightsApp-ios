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
    @IBOutlet weak var btQuestionnaireContinue: UIButton!
    
    
    let screenSize = UIScreen.main.bounds
    var tvQuestion = UITextView()
    var buttonsArrayImage = [UIButton]()
    var textViewAnswersArray = [UITextView]()
    var answersArray = [AnswerModel]()
    let language = LocalizationSystem.sharedInstance.getLanguage()
    var numberOfAnswers = 0
    var idCurrentQuestion = 1
    
    //Positions and margins
    let initTitleY = 30
    let initQuestionX = 20
    let initQuestionY = 50
    let questionMarginX = 40
    let questionHeight = 45
    let initButtonsX = 40
    let initButtonsY = 50
    let buttonsWidth = 20
    let buttonsHeight = 20
    let buttonsMarginY = 35
    let answersHeight = 45
    
    //Fonts
    let titleFont = 24
    let questionFont = 15
    let answersFont = 14
    
    //Tags and parameters
    var tags = ""
    var parameters = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if UserDefaults.standard.object(forKey: "tags") != nil {
            UserDefaults.standard.set("", forKey: "tags")
        }
        
        let tvTitle = makeTextView(text: NSLocalizedString("questionnaire",comment: ""), xPos: 0, yPos: initTitleY, width: 160, height: 40, font: titleFont)
        tvTitle.center.x = self.view.center.x
        self.view.addSubview(tvTitle)
        
        updateQuestion()
        
        btQuestionnaireContinue.setTitle(NSLocalizedString("continue", comment: ""),for: .normal)
    }
    
    func updateQuestion(){
        let screenWidth = screenSize.width
        answersArray = getAnswers()
        numberOfAnswers = answersArray.count
        
        //Delete previous buttons from the view
        if !buttonsArrayImage.isEmpty{
            for button in buttonsArrayImage{
                button.removeFromSuperview()
            }
            buttonsArrayImage = [UIButton]()
        }
        
        //Delete previous answers textviews from the view
        if !textViewAnswersArray.isEmpty {
            for textview in textViewAnswersArray{
                textview.removeFromSuperview()
            }
            textViewAnswersArray = [UITextView]()
        }
        
        //Sets the text and position of the question
        tvQuestion = makeTextView(text: getQuestionText(), xPos: initQuestionX, yPos: initQuestionY + initTitleY, width: (Int(screenWidth) - questionMarginX), height: questionHeight, font: questionFont)
    
        self.view.addSubview(tvQuestion)
        
        //Sets the buttonImage
        var yMargin = initButtonsY + initQuestionY + initTitleY
        for i in 0..<numberOfAnswers{
            buttonsArrayImage.append(makeButtonWithImage(xPos: initButtonsX, yPos: yMargin, width: buttonsWidth, height: buttonsHeight))
            yMargin = yMargin + buttonsMarginY
            self.view.addSubview(buttonsArrayImage[i])
        }
        
        //Sets the answers text
        yMargin = initButtonsY + initQuestionY + initTitleY - 5
        let textViewWidth = (Int(screenWidth) - initButtonsX - buttonsWidth - 20)
        for i in 0..<numberOfAnswers{
            textViewAnswersArray.append(makeTextView(text: answersArray[i].text, xPos: initButtonsX + buttonsWidth, yPos: yMargin, width: textViewWidth, height: answersHeight, font: answersFont))
            yMargin = yMargin + buttonsMarginY
            self.view.addSubview(textViewAnswersArray[i])
        }
    }
    
    func getQuestionText() -> String {
        var results = ""
        //var a: CityModel = CityModel()
        
        if DatabaseHelper.shared.openDatabase(){
            results = DatabaseHelper.shared.getQuestionText(id_question: idCurrentQuestion, language: language)
        }
        return results
    }
    
    func getAnswers() -> [AnswerModel]{
        var results = [AnswerModel]()
        
        if DatabaseHelper.shared.openDatabase(){
            results = DatabaseHelper.shared.getAnswersForQuestion(idQuestion: idCurrentQuestion, language: language)
        }
        return results
    }
    
    func getTagRaised(idQuestion: Int, idAnswer: Int) -> Int {
        var result = 0
        
        if DatabaseHelper.shared.openDatabase(){
            result = DatabaseHelper.shared.getTagRaised(idQuestion: idQuestion, idAnswer: idAnswer)
        }
        return result
    }
  
   
    @IBAction func btQuestionnaireContinue(_ sender: UIButton) {
        let idAnswer = getAnswerIDFromButton()
        
        if idAnswer == 0 {
            //Shows an alert: the user should accept at least one option in the questionnaire
            let alert = UIAlertController(title: nil, message: NSLocalizedString("alertSelectOneOption", comment: ""), preferredStyle: .alert)
            alert.view.backgroundColor = UIColor.black
            alert.view.alpha = 0.6
            alert.view.layer.cornerRadius = 15
            
            self.present(alert, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
                alert.dismiss(animated: true)
            }
        } else {
            //Initialize tags and parameters 
            if idCurrentQuestion == 1 {
                UserDefaults.standard.set("", forKey: Constants.shared.tags)
                UserDefaults.standard.set("", forKey: Constants.shared.parameters)
            }
            
            //Checks if any tag is raised with the current question and answer
            let tagRaised = getTagRaised(idQuestion: idCurrentQuestion, idAnswer: idAnswer)
            if tagRaised != 0 {
                tags.append(String(tagRaised) + ",")
            }
            
            //Appends the parameters
            parameters.append(String(idCurrentQuestion) + "," + String(idAnswer) + ",")
            
            //Gets the next question ID
            if DatabaseHelper.shared.openDatabase(){
                idCurrentQuestion = DatabaseHelper.shared.getNextQuestionID(idQuestion: idCurrentQuestion, idAnswer: idAnswer)
            }
            if idCurrentQuestion == 0 {
                //Stores the tags raised
                UserDefaults.standard.set(tags.dropLast(), forKey: Constants.shared.tags)
                
                //Stores the parameters
                UserDefaults.standard.set(parameters.dropLast(), forKey: Constants.shared.parameters)
                
                //Show particles
                //print(tags)
                //print(parameters)
                
                performSegue(withIdentifier: "questionnaireToParticles", sender: nil)
            } else {
                updateQuestion()
            }
        }
    }
    
    func getAnswerIDFromButton() -> Int{
        var idAnswer = 0
        var index = 0
        for button in buttonsArrayImage {
            if button.currentImage == UIImage(named: "ButtonChecked") {
                idAnswer = answersArray[index].id
                break
            }
            index += 1
        }
        
        return idAnswer
    }
    
    func makeTextView(text: String, xPos: Int, yPos: Int, width: Int, height: Int, font: Int) -> UITextView{
        let myTextView = UITextView(frame: CGRect(x: xPos, y: yPos, width: width, height: height))
        if font == 0 {
            myTextView.text = text
        } else {
            let s = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(font))])
            myTextView.attributedText = s
        }
        
        return myTextView
    }
    
    func makeButtonWithText(text: String, xPos: Int, yPos: Int, width: Int, height: Int) -> UIButton{
        let myButton = UIButton(type: UIButton.ButtonType.system)
        myButton.setTitle(text, for: .normal)
        myButton.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
        return myButton
    }
    
    func makeButtonWithImage(xPos: Int, yPos: Int, width: Int, height: Int) -> UIButton{
        let myButton = UIButton(type: UIButton.ButtonType.system)
        myButton.setImage(UIImage(named: "ButtonUnchecked"), for: .normal)
        myButton.addTarget(self, action: #selector(whenButtonIsClicked), for: .touchUpInside)
        
        myButton.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
        return myButton
    }
    
    @objc func whenButtonIsClicked(_ sender: UIButton){
        if !buttonsArrayImage.isEmpty {
            for button in buttonsArrayImage{
                button.setImage(UIImage(named: "ButtonUnchecked"), for: .normal)
            }
        }
        sender.setImage(UIImage(named: "ButtonChecked"), for: .normal)
    }
}
