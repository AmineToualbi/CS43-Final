//
//  Question.swift
//  WorldQuiz
//
//  Created by TOUALBI Amine  on 11/04/2020.
//  Copyright © 2020 ToualbiApps. All rights reserved.
//

import Foundation

class Question {
    var questionText: String
    var answer: Bool
    
    init(questionText: String, answer: Bool) {
        self.questionText = questionText
        self.answer = answer
    }
}
