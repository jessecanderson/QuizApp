//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // Array of trivia questions created in QuizQuestions.swift
    let triviaQuestions = TriviaQuesions()
    
    @objc let questionsPerRound = 4
    @objc var questionsAsked = 0
    @objc var correctQuestions = 0
    @objc var indexOfSelectedQuestion: Int = 0
    @objc var questionsNumberAsked: [Int] = []
    
    // Using this array of buttons to hide, change the colors, and update text colors later
    @objc var buttons: [UIButton]? = []
    
    // Game Sounds System ID's. Need to look into this more.
    @objc var gameSound: SystemSoundID = 0
    var wrongSound: SystemSoundID = 0
    var rightSound: SystemSoundID = 0
    // Single place to add sound file names, if they needed to be changed or updated
    // I didn't implement this like I thought I would. Need to revisit to see if I can find a better way.
    let soundEffectNames: [String] = ["GameSound", "RightAnswer", "WrongAnswer"]
    // value to change if audio plays or not
    var muteIsOn: Bool = false
    
    // Timer variables and label
    var swiftTimer = Timer()
    var swiftCounter = 0
    @IBOutlet weak var timerLabel: UILabel!
    var selectedQuestion: TriviaDetails?
    
    // Button and field IBOutlets
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var muteButton: UIButton!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add all the buttons to the array for later
        buttons = [button1, button2, button3, button4]
        
        // Load game start sound
        // loadGameStartSound()
        loadGameSounds()
        
        // Start game
        playGameSound(SoundState.start, isMuteOn: muteIsOn)
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Main play function. Sets up the play, starts the timeer, and loads up the questions
    @objc func displayQuestion() {
        timerLabel.isHidden = false
        // Select a random number
        selectRandomNumber()
        swiftCounter = 15
        // Pick a question from the arry and assign it to selectedQuestion
        selectedQuestion = triviaQuestions.questionsList[indexOfSelectedQuestion]
        
        // Because selectedQuestion is optional, we check that there is a value and then unwrap that value.
        if let selectedQuestion = selectedQuestion{
            // Check if the question has been asked before?
            if questionsWasAsked(selectedQuestion) == true {
                // If yes, then select a new random number and restart this function to redo the check. Was thinking of doing this in a while loop, but went with this instead.
                selectRandomNumber()
                displayQuestion()
            } else {
                // We make sure the button background and title color and text color are all correct here.
                questionField.textColor = UIColor.white
                if let buttons = buttons {
                    for button in buttons {
                        button.backgroundColor = UIColor(red:0.05, green:0.47, blue:0.59, alpha:1.0)
                        button.setTitleColor(UIColor.white, for: .normal)
                    }
                }
                
                // Set question text and starting the timer.
                questionField.text = selectedQuestion.questionText
                timerLabel.text = String(swiftCounter)
                
                swiftTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
                
                // How many buttons do we need to assign? This can be expanded if needed, and working on moving the buttons to make it look nicer.
                switch selectedQuestion.numberOfOptions {
                case 2:
                    button1.setTitle(selectedQuestion.options[0], for: .normal)
                    button2.setTitle(selectedQuestion.options[1], for: .normal)
                    button3.isHidden = true
                    button4.isHidden = true
                default:
                    unhideButtons()
                    button1.setTitle(selectedQuestion.options[0], for: .normal)
                    button2.setTitle(selectedQuestion.options[1], for: .normal)
                    button3.setTitle(selectedQuestion.options[2], for: .normal)
                    button4.setTitle(selectedQuestion.options[3], for: .normal)
                }
            }
        }
        playAgainButton.isHidden = true
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1

        if let selectedQuestion = selectedQuestion {
            let correctAnswer = (selectedQuestion.answer, sender.tag)
            
            // For simplicity here, I just set the button sender to the same value as what is in the array. If the two match up, it is correct, else it's not. Case statment looked nicer then a bunch of If/If Else/Else statments.
            switch correctAnswer {
            case (0,0):
                setCorrectAnswer(listOfButtons: buttons, correct: button1)
            case (1,1):
                setCorrectAnswer(listOfButtons: buttons, correct: button2)
            case (2,2):
                setCorrectAnswer(listOfButtons: buttons, correct: button3)
            case (3,3):
                setCorrectAnswer(listOfButtons: buttons, correct: button4)
            default:
                setWrongAnswer(listOfButtons: buttons, questionIndex: selectedQuestion.answer)
            }

            questionsNumberAsked.append(selectedQuestion.questionNumber)
            print(questionsNumberAsked)
            loadNextRoundWithDelay(seconds: 2)

        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        unhideButtons()
        questionsAsked = 0
        correctQuestions = 0
        questionsNumberAsked = []
        nextRound()
    }
    
    @IBAction func muteAudio(_ sender: Any) {
        if muteIsOn == false {
            muteIsOn = true
            muteButton.setImage(#imageLiteral(resourceName: "Unmute"), for: .normal)
        } else {
            muteIsOn = false
            muteButton.setImage(#imageLiteral(resourceName: "Mute"), for: .normal)
        }
    }
    
    @objc func nextRound() {
        timerLabel.isHidden = true
        stopTimer()
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @objc func displayScore() {
        // Hide the answer buttons
        if let buttons = buttons {
            for button in buttons {
                button.isHidden = true
            }
        }
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    
    // MARK: Helper Methods
    
    // I was doing this a few times, figured it would be easier to call the function to do it.
    // Later, I will go back and make this both hide and unhide buttons as I do that a few times as well.
    func unhideButtons() {
        if let buttons = buttons {
            for button in buttons {
                button.isHidden = false
            }
        }
    }
    
    // Select a random number for the questions
    func selectRandomNumber() {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: triviaQuestions.questionsList.count)
    }
    
    // Keep track of which questions have been asked per round
    func questionsWasAsked(_ selectedQuestion: TriviaDetails) -> Bool {
        if questionsNumberAsked.contains(selectedQuestion.questionNumber) {
            return true
        } else {
            return false
        }
    }
    
    // MARK: Audio Functions
    @objc func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }

    func loadGameSounds() {
        for fileName in soundEffectNames {
            let pathToSoundFile = Bundle.main.path(forResource: fileName, ofType: "wav")
            if let pathToSoundFile = pathToSoundFile {
                switch fileName {
                case "GameSound":
                    let soundURL = URL(fileURLWithPath: pathToSoundFile)
                    AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
                case "RightAnswer":
                    let soundURL = URL(fileURLWithPath: pathToSoundFile)
                    AudioServicesCreateSystemSoundID(soundURL as CFURL, &rightSound)
                case "WrongAnswer":
                    let soundURL = URL(fileURLWithPath: pathToSoundFile)
                    AudioServicesCreateSystemSoundID(soundURL as CFURL, &wrongSound)
                default:
                    print("Something went wrong loading the sounds.")
                    break
                }
                
            }
        }
    }
    
    func playGameSound(_ state: SoundState, isMuteOn: Bool) {
        if isMuteOn == false {
            switch state {
            case .start:
                AudioServicesPlaySystemSound(gameSound)
            case .rightAnswer:
                AudioServicesPlaySystemSound(rightSound)
            case .wrongAnswer:
                AudioServicesPlaySystemSound(wrongSound)
            }
        } else {
            print("Someone turned on mute, no audio")
        }
    }
    
    // MARK: Timer Functions
    @objc func updateTimer() {
        if swiftCounter != 0 {
            swiftCounter -= 1
            print(swiftCounter)
            timerLabel.text = String(swiftCounter)
        } else {
            if let selectedQuestion = selectedQuestion {
                // This could be cleaned up. Since some functionality is repeated here, I wonder if I could take it out of their functions and keep things more modular?
                // Work on this more later. 
                questionsAsked += 1
                stopTimer()
                setWrongAnswer(listOfButtons: buttons, questionIndex: selectedQuestion.answer)
                questionsNumberAsked.append(selectedQuestion.questionNumber)
                print(questionsNumberAsked)
                loadNextRoundWithDelay(seconds: 2)
            }
            
        }
    }
    
    func stopTimer() {
        swiftTimer.invalidate()
    }
    
    
    // MARK: Display Functions
    // Set the display if the question was answered correctly
    func setCorrectAnswer(listOfButtons: [UIButton]?, correct: UIButton) {
        stopTimer()
        correctQuestions += 1
        questionField.text = "Correct!"
        questionField.textColor = UIColor.green
        correct.backgroundColor = UIColor(red:0.05, green:0.47, blue:0.59, alpha:1.0)
        
        if let buttons = listOfButtons {
            for button in buttons {
                if button != correct {
                    button.backgroundColor = UIColor.darkGray
                    button.setTitleColor(.lightGray, for: .normal)
                }
            }
        } else {
            print("The buttons didn't show up correctly")
        }
        
        playGameSound(SoundState.rightAnswer, isMuteOn: muteIsOn)
    }
    
    // Set the display if the question was answered wrong
    func setWrongAnswer(listOfButtons: [UIButton]?, questionIndex: Int) {
        stopTimer()
        questionField.text = "Sorry, wrong answer!"
        questionField.textColor = UIColor.orange
        if var buttons = listOfButtons {
            buttons[questionIndex].backgroundColor = UIColor(red:0.05, green:0.47, blue:0.59, alpha:1.0)
            buttons.remove(at: questionIndex)
            for button in buttons {
                button.backgroundColor = UIColor.darkGray
            }
        }
        playGameSound(SoundState.wrongAnswer, isMuteOn: muteIsOn)
    }
}



