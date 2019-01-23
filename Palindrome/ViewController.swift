//
//  ViewController.swift
//  Palindrome
//
//  Created by Chinonso Obidike on 1/23/19.
//  Copyright © 2019 Chinonso Obidike. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var instrLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var displayTextView: UITextView!
   
    @IBOutlet weak var enterButtn: bevelButton!
    
    //MARK: - Variables
    var count: Int = 0
   
    var correct: Bool = false
    var numCorrect: Int = 0
    var score: Int = 0
    
    //MARL: - VIEW
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        instrLabel.text = "You're now at level 1. Enter a one word palindrome 4 times"
        scoreLabel.text = "Score: \(score)"
        displayTextView.text = """
            ⚠️Please only enter buttons work now. Return key is just to dismiss keyboard.
            Thanks for understanding
            Instructions:
            A palindrome is a text that reads the same backwards and forwards.
            Level 1: You'll enter a one-word palindrome, no punctuations\n
            Level 2: You'll enter a two-word palindrome, no punctuations\n
            Level3: You'll enter a more than two-word palindrome, punctuation is allowed.\n
            You'll need to enter 4 words each in level 1 and level 2. A sentence will do in level 3
            Goood luck

            """
    }
    
    @IBAction func returnButtonPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
       
    }
    
    //MARK: - Button presson action
    @IBAction func enterButtonPressed(_ sender: bevelButton) {
        
        countNumButtonPressed()
        if count == 1 {
            displayTextView.text = ""
        }
        var textInput: String = ""
        if let txt: String = inputTextField.text{
            textInput = txt.lowercased()
        }
       
        
        //call level one function if user input is a text
        if numCorrect < 4 {
            if let newText = levelOne(word: textInput){
                correct = oneWordPalindrome(word: newText)
                if correct == true {
                    inputTextField.resignFirstResponder()
                    displayTextView.text += "\nCorrect + points! palindrome: \(textInput)"
                    numCorrect += 1
                    score += 5
                    if numCorrect == 4{
                        changeText()
                    }
                } else {
                    score -= 10
                }
            }
            //call level two function if user scores correct 4 times
        }else if numCorrect < 8 {
            if let newText = levelTwo(word: textInput) {
                correct = oneWordPalindrome(word: newText)
                if correct{
                    displayTextView.text = "\nCorrect + points! palindrome: \(textInput)"
                    instrLabel.text = "Level 2: Enter a two-word palindrome 4 times"
                    inputTextField.resignFirstResponder()
                    numCorrect += 1
                    score += 5
                    if numCorrect == 8{
                        changeText()
                    }
                }else {
                    score -= 10
                }
            }
            
            
            //call level three function if user scores correct 8 times
        } else {
            displayTextView.text = "Correct palindromes: + points!"
            if let newText = levelThree(word: textInput){
                correct = oneWordPalindrome(word: newText)
                if correct{
                    displayTextView.text += "\n\(textInput)"
                    numCorrect += 1
                    score += 5
                    if numCorrect == 8{
                        changeText()
                    }
                } else {
                    score -= 10
                }
            }
        }
        scoreLabel.text = "Score: \(score)"
    }

    
    //MARK: - Change instruction texts when level changes
   func changeText(){

        if numCorrect == 4{
            instrLabel.text = "Congratulations Level 2! Enter a two-word palindrome 4 times"
            inputTextField.placeholder = "Level 2: Enter a two-word palindrome 4 times"
            displayTextView.text = "Correct palindromes: +  5 points!\n\n Level 2: Only two words\n\nPunctuatiions not allowed. GO!"
            self.score += 5
            scoreLabel.text = "Score\(self.score)"
        } else if numCorrect == 8 {
            instrLabel.text = "Congratulations Level 3! Enter a sentence that is a palindrome"
            inputTextField.placeholder = "Level 3: Enter a two-word palindrome 4 times"
            self.displayTextView.text = "Correct palindromes: + 5 points!\n\n Level 3: Only sentences\n\nPunctuatiions allowed. GO!"
            score += 5
            self.scoreLabel.text = "Score\(self.score)"
        }
    }
    
    func countNumButtonPressed(){
        count += 1
    }
    
    //MARK: - Define Levels
    
    func numWords(words: String) -> Int{
        let numwords: [String] = words.components(separatedBy: " ")
        return numwords.count
    }
    
    func levelOne(word: String) -> String?{
        let wordCount = numWords(words: word)
        if wordCount != 1{
            instrLabel.text = "You entered wrong number of words"
            return nil
        }else {
            return word
        }
    }
    
    func  levelTwo(word: String) -> String?{
        let wordCount = numWords(words: word)
        if wordCount != 2{ 
         instrLabel.text = "You entered wrong number of words"
            return nil
        }else {
            let condensed = String(word.filter{ (!" \n\t\r\',".contains($0))})
            let newWord = condensed
            return newWord
        }
    }
    
    func  levelThree(word: String) -> String?{
        let wordCount = numWords(words: word)
        if wordCount < 3{
            instrLabel.text = "You entered wrong number of words"
            return nil
        } else {
            let condensed = String(word.filter{ (!" \n\t\r\',".contains($0))})
            let newWord = condensed
            return newWord
        }
    }
    
    //MARK: - check for palindrome
    func oneWordPalindrome(word: String) -> Bool {
            return String(word.reversed()) == word
    }
    
    

}

