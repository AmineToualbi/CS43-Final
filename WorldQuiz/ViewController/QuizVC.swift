//
//  ViewController.swift
//  WorldQuiz
//
//  Created by TOUALBI Amine  on 11/04/2020.
//  Copyright © 2020 ToualbiApps. All rights reserved.
//

import UIKit
import PKHUD

class QuizVC: UIViewController {
    
    
    //UI Elements:
    var questionLabel: UILabel!
    var trueButton: UIButton!
    var falseButton: UIButton!
    var scoreLabel: UILabel!
    var highScoreLabel: UILabel!
    var quizStatus: UILabel!
    
    var quizCountry: String!
    var questionBank: QuestionBank!
    var quizQuestions = [Question]()
    var questionNumber: Int!
    var numberOfQuestions: Int!
    var score: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //blue is bad taste
        //view.backgroundColor = .blue
                
        questionLabel = UILabel()
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.contentMode = .scaleAspectFill
        questionLabel.clipsToBounds = true
        questionLabel.textColor = .black //changed to black to accommodate white background
        questionLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        questionLabel.adjustsFontSizeToFitWidth = false
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        questionLabel.text = "QUESTION"
        view.addSubview(questionLabel)
        
        trueButton = UIButton()
        trueButton.translatesAutoresizingMaskIntoConstraints = false
        trueButton.contentMode = .scaleAspectFill
        trueButton.clipsToBounds = true
        trueButton.setTitle("True", for: .normal)
        trueButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        trueButton.titleLabel?.textColor = .white
        trueButton.backgroundColor = .green
        view.addSubview(trueButton)
        trueButton.addTarget(self, action: #selector(truePressed), for: .touchUpInside)
        
        falseButton = UIButton()
        falseButton.translatesAutoresizingMaskIntoConstraints = false
        falseButton.contentMode = .scaleAspectFill
        falseButton.clipsToBounds = true
        falseButton.setTitle("False", for: .normal)
        falseButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        falseButton.titleLabel?.textColor = .white
        falseButton.backgroundColor = .red
        view.addSubview(falseButton)
        falseButton.addTarget(self, action: #selector(falsePressed), for: .touchUpInside)
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.contentMode = .scaleAspectFill
        scoreLabel.clipsToBounds = true
        scoreLabel.textColor = .black //changed to black to accommodate white background
        scoreLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.textAlignment = .center
        scoreLabel.text = "Score: 7"
        view.addSubview(scoreLabel)
        
        highScoreLabel = UILabel()
        highScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        highScoreLabel.contentMode = .scaleAspectFill
        highScoreLabel.clipsToBounds = true
        highScoreLabel.textColor = .black //changed to black to accommodate white background
        highScoreLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        highScoreLabel.adjustsFontSizeToFitWidth = true
        highScoreLabel.textAlignment = .center
        highScoreLabel.text = "High Score: 7"
        view.addSubview(highScoreLabel)
        
        quizStatus = UILabel()
        quizStatus.translatesAutoresizingMaskIntoConstraints = false
        quizStatus.contentMode = .scaleAspectFill
        quizStatus.clipsToBounds = true
        quizStatus.textColor = .black //changed to black to accommodate white background
        quizStatus.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        quizStatus.adjustsFontSizeToFitWidth = true
        quizStatus.textAlignment = .center
        quizStatus.text = "x/10"
        view.addSubview(quizStatus)
        
        setupNavigationBar()
        setupConstraints()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        /*
         Once all the UI is loaded & laid out correctly on the screen,
         retrieve the country for the quiz that was passed from the cell clicked in the previous table view controller.
         Make sure to pass the string with first letter capitalized, important to retrieve high score.
         For now, I will hardcode it to be "France".
         */
        //quizCountry = "France"
        questionBank = QuestionBank(country: quizCountry)
        quizQuestions = questionBank.listOfQuestions
        score = getScore()
        questionNumber = getQuestionNumber()
        numberOfQuestions = quizQuestions.count
                
        updateUI()
        nextQuestion()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "WorldQuiz"
       // self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func updateUI() {
        scoreLabel.text = "Score: " + String (score)
        highScoreLabel.text = "High Score: " + String (getHighScore())
        if questionNumber + 1 > numberOfQuestions {     //game over, avoid having 11/10.
            quizStatus.text = String (numberOfQuestions) + "/\(numberOfQuestions!)"
        }
        else {
            quizStatus.text = String (questionNumber + 1) + "/\(numberOfQuestions!)"
        }
    }
    
    func nextQuestion() {
        if questionNumber < numberOfQuestions {
            questionLabel.text = quizQuestions[questionNumber].questionText
        }
        else {
            saveHighScore()
            var endMessage = ""
            if score > numberOfQuestions - 1 {
                print("YOU PASSED.")
                endMessage = "Congratulations, you passed!"
                saveCompletedQuiz()
            }
            else {
                print("YOU FAILED.")
                endMessage = "You failed, try again!"
            }
            
            let alert = UIAlertController(title: "End of the Quiz!", message: endMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { (action: UIAlertAction!) in
                self.restart()
            }))

            alert.addAction(UIAlertAction(title: "Go To Main Menu", style: .cancel, handler: { (action: UIAlertAction!) in
                self.goToMainMenu()
            }))

            present(alert, animated: true, completion: nil)
        }
    }
    
    func saveCompletedQuiz() {
        let completedQuizKey = "\(quizCountry!)-completed"
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: completedQuizKey)
        print("KEY = \(completedQuizKey) SAVED TRUE")
    }
    
    func saveHighScore() {
        let quizScoreKey = "\(quizCountry!)-highscore"
        let defaults = UserDefaults.standard
        let lastHighScore = defaults.integer(forKey: quizScoreKey)
        print("Last high score = \(lastHighScore)")
        if score > lastHighScore {
            defaults.set(score, forKey: quizScoreKey)
            print("NEW HIGH SCORE = \(score)")
        }
    }
    
    func getHighScore() -> Int {
        let quizScoreKey = "\(quizCountry!)-highscore"
        let defaults = UserDefaults.standard
        var lastHighScore = defaults.integer(forKey: quizScoreKey)
        return lastHighScore
    }
    
    func restart() {
        questionNumber = 0
        score = 0
        logCurrentStatus()
        updateUI()
        nextQuestion()
    }

    func goToMainMenu() {
        questionNumber = 0
        score = 0
        logCurrentStatus()
        quizNotFinished(notFinished: false)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            questionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            questionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -10),
            questionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
        
        NSLayoutConstraint.activate([
            trueButton.heightAnchor.constraint(equalToConstant: 56),
            trueButton.widthAnchor.constraint(equalToConstant: 128),
            trueButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            trueButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -25)
        ])
        
        NSLayoutConstraint.activate([
            falseButton.heightAnchor.constraint(equalToConstant: 56),
            falseButton.widthAnchor.constraint(equalToConstant: 128),
            falseButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            falseButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            scoreLabel.heightAnchor.constraint(equalToConstant: 21),
            scoreLabel.widthAnchor.constraint(equalToConstant: 116),
            scoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            scoreLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            quizStatus.heightAnchor.constraint(equalToConstant: 21),
            quizStatus.widthAnchor.constraint(equalToConstant: 52),
            quizStatus.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            quizStatus.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            highScoreLabel.heightAnchor.constraint(equalToConstant: 21),
            highScoreLabel.widthAnchor.constraint(equalToConstant: 116),
            highScoreLabel.trailingAnchor.constraint(equalTo: scoreLabel.trailingAnchor),
            highScoreLabel.bottomAnchor.constraint(equalTo: scoreLabel.topAnchor, constant: -5)
        ])
    }
    
    @objc func truePressed(sender: UIButton) {
        verifyAnswer(choice: true)
        nextQuestion()
    }
    @objc func falsePressed(sender: UIButton) {
        verifyAnswer(choice: false)
        nextQuestion()
    }
    
    
    func verifyAnswer(choice: Bool) {
        if questionNumber < numberOfQuestions {
            let correctAnswer = quizQuestions[questionNumber].answer
            
            if choice == correctAnswer {
                print("Good answer.")
                showHUD(success: true)
                score += 1
                questionNumber += 1
            }
            else {
                print("Wrong answer.")
                showHUD(success: false)
                questionNumber += 1
            }
        }
        updateUI()
    }
    
    func showHUD(success: Bool) {
        HUD.dimsBackground = false
        HUD.allowsInteraction = false
        if success {
            PKHUD.sharedHUD.contentView = PKHUDSuccessView()
            PKHUD.sharedHUD.show()
            PKHUD.sharedHUD.hide(afterDelay: 1.0)
        }
        else {
            PKHUD.sharedHUD.contentView = PKHUDErrorView()
            PKHUD.sharedHUD.show()
            PKHUD.sharedHUD.hide(afterDelay: 0.5)
        }
    }
    
    @objc func appMovedToBackground() {
        print("App moved to background!")
        quizNotFinished(notFinished: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("DISAPPEARED.")
        if questionNumber != 0 {     
            quizNotFinished(notFinished: true)
        }
    }
    
    func quizNotFinished(notFinished: Bool) {
        if notFinished == true {
            logCurrentStatus()
        }
        let quizToCompleteKey = "\(quizCountry!)-to-complete"
        let defaults = UserDefaults.standard
        defaults.set(notFinished, forKey: quizToCompleteKey)
        print("KEY = \(quizToCompleteKey) SAVES \(notFinished).")
    }
    
    func logCurrentStatus() {
        let quizScoreKey = "\(quizCountry!)-score"
        let quizQuestionKey = "\(quizCountry!)-questionNumber"
        let defaults = UserDefaults.standard
        defaults.set(score, forKey: quizScoreKey)
        defaults.set(questionNumber, forKey: quizQuestionKey)
        print("Score saved = \(score)")
    }
    
    func getScore() -> Int {
        let quizScoreKey = "\(quizCountry!)-score"
        let defaults = UserDefaults.standard
        var lastScore = defaults.integer(forKey: quizScoreKey)
        print("getScore() -> \(lastScore)")
        return lastScore
    }
    
    func getQuestionNumber() -> Int {
        let quizQuestionKey = "\(quizCountry!)-questionNumber"
        let defaults = UserDefaults.standard
        var lastQuestion = defaults.integer(forKey: quizQuestionKey)
        print("getQuestionNumber() -> \(lastQuestion)")
        return lastQuestion
    }
    
    
    
}

