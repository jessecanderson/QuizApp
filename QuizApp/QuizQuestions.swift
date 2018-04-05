//
//  QuizQuestions.swift
//  TrueFalseStarter
//
//  Created by Jesse Anderson on 2/10/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

struct TriviaDetails {
    
    let questionNumber: Int
    let questionText: String
    let numberOfOptions: Int
    let options: [String]
    let answer: Int
    
    
}

struct TriviaQuesions {
    
    
    var questionsList: [TriviaDetails]  {
        
        let question0 = TriviaDetails(
            questionNumber: 0,
            questionText: "This was the only US President to serve more than two consecutive terms.",
            numberOfOptions: 4,
            options: ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"],
            answer: 1)
        
        let question1 = TriviaDetails(
            questionNumber: 1,
            questionText: "Which of the following countries has the most residents?",
            numberOfOptions: 4,
            options: ["Nigeria", "Russia", "Iran", "Vietnam"],
            answer: 0)
        
        let question2 = TriviaDetails(
            questionNumber: 2,
            questionText: "In what year was the United Nations founded?",
            numberOfOptions: 4,
            options: ["1918", "1919", "1945","1954"],
            answer: 2)
        
        let question3 = TriviaDetails(
            questionNumber: 3,
            questionText: "The Titanic departed from the United Kingdom, where was it supposed to arrive?",
            numberOfOptions: 4,
            options: ["Paris", "Washington D.C.", "New York City", "Boston"],
            answer: 2)
        
        let question4 = TriviaDetails(
            questionNumber: 4,
            questionText: "Which nation produces the most oil?",
            numberOfOptions: 4,
            options: ["Iran", "Iraq", "Brazil", "Canada"],
            answer: 3)
        
        let question5 = TriviaDetails(
            questionNumber: 5,
            questionText: "Which country has most recently won consecutive World Cups in Soccer?",
            numberOfOptions: 4,
            options: ["Italy", "Brazil", "Argetina", "Spain"],
            answer: 1)
        
        let question6 = TriviaDetails(
            questionNumber: 6,
            questionText: "Which of the following rivers is longest?",
            numberOfOptions: 4,
            options: ["Yangtze", "Mississippi", "Congo", "Mekong"],
            answer: 1)
        
        let question7 = TriviaDetails(
            questionNumber: 7,
            questionText: "Which city is the oldest?",
            numberOfOptions: 4,
            options: ["Mexico City", "Cape Town", "San Juan", "Sydney"],
            answer: 0)
        
        let question8 = TriviaDetails(
            questionNumber: 8,
            questionText: "Which country was the first to allow women to vote in national elections?",
            numberOfOptions: 4,
            options: ["Poland", "United States", "Sweden", "Senegal"],
            answer: 0)
        
        let question9 = TriviaDetails(
            questionNumber: 9,
            questionText: "Which of these countries won the most medals in the 2012 Summer Games?",
            numberOfOptions: 4,
            options: ["France", "Germany", "Japan", "Great Britian"],
            answer: 3)
        
        let question10 = TriviaDetails(
            questionNumber: 10,
            questionText: "Only female koalas can whistle",
            numberOfOptions: 2,
            options: ["True", "False"],
            answer: 1)
        
        let question11 = TriviaDetails(
            questionNumber: 11,
            questionText: "Blue whales are technically whales",
            numberOfOptions: 2,
            options: ["True", "False"],
            answer: 0)
        
        let question12 = TriviaDetails(
            questionNumber: 12,
            questionText: "Camels are cannibalistic",
            numberOfOptions: 2,
            options: ["True", "False"],
            answer: 1)
        
        let question13 = TriviaDetails(
            questionNumber: 13,
            questionText: "All ducks are birds",
            numberOfOptions: 2,
            options: ["True", "False"],
            answer: 0)
        
        let array = [question0, question1, question2, question3, question4, question5, question6, question7, question8, question9, question10, question11, question12, question13]
        
        return array
    }
}
