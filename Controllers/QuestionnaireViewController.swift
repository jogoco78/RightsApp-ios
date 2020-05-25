//
//  QuestionnaireViewController.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 11/06/2019.
//  Copyright © 2019 Jorge Gonzalez Conejero. All rights reserved.
//

import UIKit

class QuestionnaireViewController: UIViewController {

    
    @IBOutlet var myView: UIView!
    @IBOutlet weak var btQuestionnaireContinue: UIButton!
    @IBOutlet weak var btn_main_screen: UIButton!
    
    let screenSize = UIScreen.main.bounds
    var tvQuestion = UITextView()
    var tvTitle = UITextView()
    var buttonsArrayImage = [UIButton]()
    var textViewAnswersArray = [UITextView]()
    var answersArray = [AnswerModel]()
    let language = LocalizationSystem.sharedInstance.getLanguage()
    var numberOfAnswers = 0
    var idCurrentQuestion = 1
    
    //Positions and margins
    let initTitleY = 30
    let initQuestionX = 20
    let initQuestionY = 100
    let questionMarginX = 40
    let questionHeight = 55
    let initButtonsX = 40
    let initButtonsY = 70
    let buttonsWidth = 25
    let buttonsHeight = 25
    let buttonsMarginY = 35
    let answersHeight = 70
    
    //Fonts
    let titleFont = UIScreen.main.bounds.height * 0.038 //24 in a height 667 screen
    let questionFont = UIScreen.main.bounds.height * 0.022 // 15 in a height 667 screen
    let answersFont = UIScreen.main.bounds.height * 0.017 // 14 in a height of 667 screen
    
    //Tags and parameters
    var tags = ""
    var parameters = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Remove previous stored tags
        UserDefaults.standard.removeObject(forKey: Constants.keys.tags)
        UserDefaults.standard.removeObject(forKey: Constants.keys.main_tag)
        UserDefaults.standard.removeObject(forKey: Constants.keys.side_tag)
        UserDefaults.standard.removeObject(forKey: Constants.keys.residence_tag)
        UserDefaults.standard.removeObject(forKey: Constants.keys.user_selected_tag)
        
        view.addSubview(tvTitle)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        tvTitle.translatesAutoresizingMaskIntoConstraints = false
        tvTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: screenSize.height * 0.07).isActive = true
        tvTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: screenSize.width * 0.05).isActive = true
        tvTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -screenSize.width * 0.05).isActive = true
        tvTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tvTitle.heightAnchor.constraint(equalToConstant: 60).isActive = true
        tvTitle.isEditable = false
        tvTitle.attributedText = NSMutableAttributedString(string: NSLocalizedString("questionnaire",comment: ""), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(titleFont)), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        updateQuestion()
        
        btQuestionnaireContinue.setTitle(NSLocalizedString("continue", comment: ""),for: .normal)
        btn_main_screen.setTitle(NSLocalizedString("main_screen", comment: ""), for: .normal)
    }
    
    func updateQuestion(){
        //let screenWidth = screenSize.width
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
        view.addSubview(tvQuestion)
        tvQuestion.translatesAutoresizingMaskIntoConstraints = false
        tvQuestion.topAnchor.constraint(equalTo: tvTitle.bottomAnchor, constant: screenSize.height * 0.02).isActive = true
        tvQuestion.leftAnchor.constraint(equalTo: view.leftAnchor, constant: screenSize.width * 0.10).isActive = true
        tvQuestion.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -screenSize.width * 0.10).isActive = true
        tvQuestion.heightAnchor.constraint(equalToConstant: CGFloat(questionHeight)).isActive = true
        tvQuestion.isEditable = false
        tvQuestion.attributedText = NSMutableAttributedString(string: getQuestionText(), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(questionFont))])
        
        //Sets the buttonImage
        var initButtonImage = tvQuestion.bottomAnchor
        var buttonsMargin = 0.032
        if (numberOfAnswers > 3){
            buttonsMargin = 0.02
        }
        for i in 0..<numberOfAnswers {
            let myButton = UIButton(type: UIButton.ButtonType.system)
            view.addSubview(myButton)
            myButton.translatesAutoresizingMaskIntoConstraints = false
            myButton.topAnchor.constraint(equalTo: initButtonImage, constant: screenSize.height * CGFloat(buttonsMargin)).isActive = true
            myButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: screenSize.width * 0.10).isActive = true
            myButton.widthAnchor.constraint(equalToConstant: CGFloat(buttonsWidth)).isActive = true
            myButton.heightAnchor.constraint(equalToConstant: CGFloat(buttonsHeight)).isActive = true
            myButton.setImage(UIImage(named: "ButtonUnchecked"), for: .normal)
            myButton.addTarget(self, action: #selector(whenButtonIsClicked), for: .touchUpInside)
            buttonsArrayImage.append(myButton)
            initButtonImage = myButton.bottomAnchor
        }
        
        //Sets the answers text
        for i in 0..<numberOfAnswers {
            let tvAnswer = UITextView()
            view.addSubview(tvAnswer)
            tvAnswer.translatesAutoresizingMaskIntoConstraints = false
            tvAnswer.isEditable = false
            tvAnswer.centerYAnchor.constraint(equalTo: buttonsArrayImage[i].centerYAnchor, constant: 15).isActive = true
            tvAnswer.leftAnchor.constraint(equalTo: buttonsArrayImage[i].rightAnchor, constant: screenSize.height * 0.01).isActive = true
            tvAnswer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -screenSize.width * 0.10).isActive = true
            tvAnswer.heightAnchor.constraint(equalToConstant: CGFloat(answersHeight)).isActive = true
            
            tvAnswer.attributedText = NSMutableAttributedString(string: answersArray[i].text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(answersFont))])
            textViewAnswersArray.append(tvAnswer)
        }
    }
    
    func getQuestionText() -> String {
        var results = ""
        
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
  
    @IBAction func btn_main_screen_listener(_ sender: Any) {
        //Shows an alert: the user should accept at least one option in the questionnaire
        let alert = UIAlertController(title: nil, message: NSLocalizedString("exit_questionnaire", comment: ""), preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        let okAction = UIAlertAction (title: NSLocalizedString("accept", comment: ""), style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            self.goHome()
        })

        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            print("Do nothing")
        })
    
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
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
                UserDefaults.standard.set("", forKey: Constants.keys.tags)
                UserDefaults.standard.set("", forKey: Constants.keys.parameters)
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
                UserDefaults.standard.set(tags.dropLast(), forKey: Constants.keys.tags)
                
                //Stores the parameters
                UserDefaults.standard.set(parameters.dropLast(), forKey: Constants.keys.parameters)
                
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
    
    @objc func goHome(){
        performSegue(withIdentifier: "questionnaireToMain", sender: nil)
    }
}
