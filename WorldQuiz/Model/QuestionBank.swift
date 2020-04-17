//
//  QuestionBank.swift
//  WorldQuiz
//
//  Created by TOUALBI Amine  on 11/04/2020.
//  Copyright © 2020 ToualbiApps. All rights reserved.
//

import Foundation

class QuestionBank {
    
    var listOfQuestions = [Question]()
    
    init(country: String) {
        switch country{
            case "France":
                listOfQuestions.append(Question(questionText: "In Paris, most people drive their cars to get around.", answer: false))
                
                listOfQuestions.append(Question(questionText: "Dinner is usually around 6 p.m.", answer: false))
                
                listOfQuestions.append(Question(questionText: "You greet friends and family by kissing them on the cheeks.", answer: true))
                
                listOfQuestions.append(Question(questionText: "It is common to ask random people about their day or how they are doing.", answer: false))
                
                listOfQuestions.append(Question(questionText: "You need a visa to travel to Italy from France.", answer: false))

                listOfQuestions.append(Question(questionText: "It is uncommon to be interrupted when starting a conversation without saying hello (bonjour).", answer: false))
                
                listOfQuestions.append(Question(questionText: "Most grocery stores are closed on Sunday.", answer: true))
                            
                listOfQuestions.append(Question(questionText: "The metro in Paris is open 24/7.", answer: false))
                
                listOfQuestions.append(Question(questionText: "Most french people speak fluently English and you can interact directly with them in English.", answer: false))
                
                listOfQuestions.append(Question(questionText: "At restaurants, drink prices include a certain number of refills.", answer: false))
            
            //    listOfQuestions.shuffle()
            
            case "China":
                listOfQuestions.append(Question(questionText: "Most Chinese people love eating dogs", answer: false))
                
                listOfQuestions.append(Question(questionText: "Time in China varies in different cities", answer: false))
                
                listOfQuestions.append(Question(questionText: "1 RMB = 7 USD", answer: true))
                
                listOfQuestions.append(Question(questionText: "Hong Kong is part of China", answer: true))
                
                listOfQuestions.append(Question(questionText: "Guangzhou is the capital of China", answer: false))
                
                listOfQuestions.append(Question(questionText: "There are six stars on the Chinese national flag", answer: false))
                
                listOfQuestions.append(Question(questionText: "Chinese people drive on the left side", answer: true))
                            
                listOfQuestions.append(Question(questionText: "You can watch Youtube in China", answer: false))
                
                listOfQuestions.append(Question(questionText: "The official language in China is Cantonese", answer: false))
                
                listOfQuestions.append(Question(questionText: "People in China are allowed to carry guns", answer: false))
            
             //   listOfQuestions.shuffle()
            
            case "Japan":
                listOfQuestions.append(Question(questionText: "There are 100 million people in Japan", answer: true))
                
                listOfQuestions.append(Question(questionText: "Most Japanese eat with chopsticks", answer: true))
                
                listOfQuestions.append(Question(questionText: "1 USD > 100 JPY", answer: true))
                
                listOfQuestions.append(Question(questionText: "Nintendo is not a Japanese company", answer: false))
                
                listOfQuestions.append(Question(questionText: "Tokyo is the capital of Japan", answer: true))
                
                listOfQuestions.append(Question(questionText: "The red circle on the Japanese national flag represents red flower", answer: false))
                
                listOfQuestions.append(Question(questionText: "Japan is an island country", answer: true))
                            
                listOfQuestions.append(Question(questionText: "You can not watch Youtube in Japan", answer: false))
                
                listOfQuestions.append(Question(questionText: "Main dish in Japan is noodles", answer: false))
                
                listOfQuestions.append(Question(questionText: "You don't need to worry about earthquakes in Japan", answer: false))
            
               // listOfQuestions.shuffle()
            
            case "UK":
                listOfQuestions.append(Question(questionText: "The current monarch of UK is Elizabeth III", answer: false))
                
                listOfQuestions.append(Question(questionText: "1 USD > 1 GBP", answer: false))
                
                listOfQuestions.append(Question(questionText: "London is the capital of UK but not the largest city", answer: false))
                
                listOfQuestions.append(Question(questionText: "You need TV license to watch TV", answer: true))
                
                listOfQuestions.append(Question(questionText: "You need to tip 10% ~ 15% at restaurants", answer: true))
                
                listOfQuestions.append(Question(questionText: "Climate in UK doesn't change often", answer: false))
                
                listOfQuestions.append(Question(questionText: "Restaurants close early in UK", answer: true))
                            
                listOfQuestions.append(Question(questionText: "Ground floor is the same as first floor", answer: false))
                
                listOfQuestions.append(Question(questionText: "UK people often say sorry", answer: true))
                
                listOfQuestions.append(Question(questionText: "Prince Charles is the King of UK", answer: false))
            
              //  listOfQuestions.shuffle()
            
            case "Germany":
                listOfQuestions.append(Question(questionText: "Checking travel tickets is essential in Germany", answer: false))
                
                listOfQuestions.append(Question(questionText: "Munich is the capital of Germany", answer: false))
                
                listOfQuestions.append(Question(questionText: "Tips are not required in German restaurants", answer: false))
                
                listOfQuestions.append(Question(questionText: "Most German families do not have AC", answer: true))
                
                listOfQuestions.append(Question(questionText: "German sausage is famous in the world", answer: true))
                
                listOfQuestions.append(Question(questionText: "There are 17 states in Germany", answer: false))
                
                listOfQuestions.append(Question(questionText: "Most taxis in Germany is BMW", answer: false))
                            
                listOfQuestions.append(Question(questionText: "Most shops in Germany close on Sunday", answer: true))
                
                listOfQuestions.append(Question(questionText: "You can use Euro in Germany", answer: true))
                
                listOfQuestions.append(Question(questionText: "It's safe to drink tap water in most German cities", answer: true))
            
                //listOfQuestions.shuffle()
            default:
                print("Invalid Country")
        }
    }
    
}
