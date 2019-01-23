//
//  ViewController.swift
//  Palindrome
//
//  Created by Chinonso Obidike on 1/23/19.
//  Copyright © 2019 Chinonso Obidike. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var instrLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var displayTextView: UITextView!
   
    @IBOutlet weak var enterButtn: bevelButton!
    
    var count: Int = 0
    var level: Int = 1
   
 
    
    var correct: Bool = false
    var numCorrect: Int = 0
    var score: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        instrLabel.text = "You're now at level 1"
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
            displayTextView.text = "Correct palindromes: + points!"
        }
        var textInput: String = ""
        if let txt: String = inputTextField.text{
            textInput = txt.lowercased()
        }
        
        //call level one function if user input is a text
        if numCorrect < 4 {
            level = 1
        instrLabel.text = " Level 1: Enter a one word palindrome 4 times"
        levelOne(word: textInput)
        correct = oneWordPalindrome(word: textInput)
            if correct == true {
                inputTextField.resignFirstResponder()
                displayTextView.text += "\n\(textInput)"
               
                numCorrect += 1
                if numCorrect == 4{
                   changeText()
                }
                score += 5
        } else {
            numCorrect -= 1
            score -= 10
        }
            
            //call level two function if user scores correct 4 times
        }else if numCorrect >= 4 && numCorrect < 8 {
            
            displayTextView.text = "Correct palindromes: + points!"
            instrLabel.text = " Level 2: Enter a one word palindrome 4 times"
            let newText = levelTwo(word: textInput)
            if newText != "" {
            correct = oneWordPalindrome(word: textInput)
            correct = oneWordPalindrome(word: textInput)
            if correct == true {
                inputTextField.resignFirstResponder()
                displayTextView.text += "\n\(textInput)"
                
                numCorrect += 1
                score += 5
            } else {
                numCorrect -= 1
                score -= 10
            }
            }
            
            
            //call level three function if user scores correct 8 times
        } else if numCorrect >= 8 {
            
            displayTextView.text = "Correct palindromes: + points!"
            instrLabel.text = " Level 3: Enter a sentence palindrome"
            let newText = levelThree(word: textInput)
            correct = oneWordPalindrome(word: newText)
            correct = oneWordPalindrome(word: textInput)
            if correct == true {
                displayTextView.text += "\n\(textInput)"
                numCorrect += 1
                if numCorrect == 4{
                    level = 2
                    changeText()   //change text of instruction when level changes
                    
                }
                score += 5
            } else {
                numCorrect -= 1
                score -= 10
            }
           
        }
         scoreLabel.text = "Score: \(score)"
    }

    
    //MARK: - Change instruction texts when level changes
   func changeText(){
   // _ = Timer.scheduledTimer(withTimeInterval: 0.0, repeats: true) { timer in
        if self.level + 1 == 2{
            self.instrLabel.text = "Congratulations Level 2! Enter a two-word palindrome 4 times"
            self.inputTextField.placeholder = "Level 2: Enter a two-word palindrome 4 times"
            self.displayTextView.text = "Correct palindromes: +  5 points!\n\n Level 2: Only two words\n\nPunctuatiions not allowed. GO!"
            score += 5
            scoreLabel.text = "Score\(score)"
        } else if self.level + 1 == 3 {
            self.instrLabel.text = "Congratulations Level 3! Enter a sentence that is a palindrome"
            self.inputTextField.placeholder = "Level 2: Enter a two-word palindrome 4 times"
            self.displayTextView.text = "Correct palindromes: + 5 points!\n\n Level 3: Only sentences\n\nPunctuatiions allowed. GO!"
            score += 5
            scoreLabel.text = "Score\(score)"
       // }
        
    }
    }
    
    func countNumButtonPressed(){
        count += 1
    }
    
    //MARK: - Define Levels
    
    func numWords(words: String) -> Int{
        var wordCount: Int = 0
        let numwords = words.components(separatedBy: " '")
        wordCount = numwords.count
        return wordCount
    }
    
    func levelOne(word: String){
        let wordCount = numWords(words: word)
        if wordCount != 1{
            instrLabel.text = "You entered wrong number of words"
        }
    }
    
    func  levelTwo(word: String) -> String{
        var newWord: String = ""
        let wordCount = numWords(words: word)
        if wordCount != 2{
            instrLabel.text = "You entered wrong number of words"
        }else {
            let condensed = String(word.filter{ (!" \n\t\r\',".contains($0))})
                newWord = condensed
            }
        return newWord
    }
    
    func  levelThree(word: String) -> String{
        var newWord: String = ""
        let wordCount = numWords(words: word)
        if wordCount < 2{
            instrLabel.text = "You entered wrong number of words"
        } else {
        let condensed = String(word.filter{ (!" \n\t\r\',".contains($0))})
            newWord = condensed
        }
       return newWord
    }
    
    //MARK: - check for palindrome
    func oneWordPalindrome(word: String) -> Bool {
         var isPal: Bool = false
        let reverse = String(word.reversed())
                if reverse == word{
                    isPal = true
                }else {
                    isPal = false
                }
            
        
            return isPal
        
    }
    
    

}

