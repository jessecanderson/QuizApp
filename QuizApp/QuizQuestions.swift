//
//  QuizQuestions.swift
//  TrueFalseStarter
//
//  Created by Jesse Anderson on 2/10/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

struct QuizQuestions {
    
    let questionText: String?
    let numOfAnswers: Int?
    let optionOne: String?
    let optionTwo: String?
    let optionThree: String?
    let optionFour: String?
    let answer: Int?
    
    let twoTrivia: [[String : String]] = [
        ["Question": "Only female koalas can whistle", "Answer": "False"],
        ["Question": "Blue whales are technically whales", "Answer": "True"],
        ["Question": "Camels are cannibalistic", "Answer": "False"],
        ["Question": "All ducks are birds", "Answer": "True"]
    ]
    
    let fourTrivia: [[String: String]] = [
        ["Question": "This was the only US President to serve more than two consecutive terms.",
         "One": "George Washington", "Two": "Franklin D. Roosevelt", "Three": "Woodrow Wilson", "Four": "Andrew Jackson",
         "Answer": "Two"],
        ["Question": "Which of the following countries has the most residents?",
         "One": "Nigeria", "Two": "Russia", "Three": "Iran", "Four": "Vietnam",
         "Answer": "One"],
        ["Question": "In what year was the United Nations founded?",
         "One": "1918", "Two": "1919", "Three": "1945", "Four": "1954",
         "Answer": "Three"],
        ["Question": "The Titanic departed from the United Kingdom, where was it supposed to arrive?",
         "One": "Paris", "Two": "Washington D.C.", "Three": "New York City", "Four": "Boston",
         "Answer": "Three"],
        ["Question": "Which nation produces the most oil?",
         "One": "Iran", "Two": "Iraq", "Three": "Brazil", "Four": "Canada",
         "Answer": "Four"],
        ["Question": "Which country has most recently won consecutive World Cups in Soccer?",
         "One": "Italy", "Two": "Brazil", "Three": "Argetina", "Four": "Spain",
         "Answer": "Two"],
        ["Question": "Which of the following rivers is longest?",
         "One": "Yangtze", "Two": "Mississippi", "Three": "Congo", "Four": "Mekong",
         "Answer": "Two"],
        ["Question": "Which city is the oldest?",
         "One": "Mexico City", "Two": "Cape Town", "Three": "San Juan", "Four": "Sydney",
         "Answer": "One"],
        ["Question": "Which country was the first to allow women to vote in national elections?",
         "One": "Poland", "Two": "United States", "Three": "Sweden", "Four": "Senegal",
         "Answer": "One"],
        ["Question": "Which of these countries won the most medals in the 2012 Summer Games?",
         "One": "France", "Two": "Germany", "Three": "Japan", "Four": "Great Britian",
         "Answer": "Four"]
        
    ]
    
}
