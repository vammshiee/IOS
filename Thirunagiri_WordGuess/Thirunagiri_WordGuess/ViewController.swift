//
//  ViewController.swift
//  Thirunagiri_WordGuess
//
//  Created by student on 03/29/22.
//
import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var wordsGuessedLabel: UILabel!
    @IBOutlet weak var wordsMissedLabel: UILabel!
    @IBOutlet weak var wordsRemainingLabel: UILabel!
    @IBOutlet weak var totalWordsLabel: UILabel!
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessLetterField: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    var wordsRemaining:Int=0
    var presentWord = 0
    var guessLetter =  ""
    var wordGussedForNow = ""
    var guessedWord = 0
    var maxNumOfWrongGuesses  = 10
    var wrongGuess = 0
    var missedGuess = 0
    var arrayWords = [ ["Microsoft","Software company"],
                         ["Tulips","Flowers"],
                         ["Buggati","Car company"],
                          ["APPLE","Fruit"],
                          ["HP","Monitors"],
                          ["Samsung","Mobile Phone"]]
    var arrayImages = ["carrot","Tulips","Buggati","APPLE","HP","Samsung"]
    override func viewDidLoad() {
        super.viewDidLoad()
                guessButton.isEnabled = false
                playAgainButton.isHidden = true
                wordsRemaining = arrayWords.count
                myImageView.isHidden = true
                updateLabels()
                guessCountLabel.text = "You have made \(wrongGuess) guesses"
                userGuessLabel.text = ""
                updateGuessingLetterWord(presentWord)
    }
    

    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessButtonAction()
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        presentWord += 1
                myImageView.isHidden = true
                guessCountLabel.text = "You have made \(wrongGuess) guesses"
                if presentWord == arrayWords.count{
                    presentWord = 0
                    guessedWord = 0
                    wordsRemaining = 0
                    missedGuess = 0
                    updateGuessingLetterWord(presentWord)
                }else{
                    
                    updateGuessingLetterWord(presentWord)
                }
                updateLabels()
    }
    func guessButtonAction(){
        guessCountLabel.isHidden = false
                wordGussedForNow =  ""
                userGuessLabel.text = ""
                
                guessLetter += guessLetterField.text!.uppercased()
                for letter in arrayWords[presentWord][0].uppercased(){
                    if guessLetter.contains(letter) {
                        wordGussedForNow += "\(letter)"
                        
                    }else{
                        wordGussedForNow += "_ "
                        
                    }
                }
                guessLetterField.resignFirstResponder()
                print(wordGussedForNow)
                userGuessLabel.text! = wordGussedForNow
                guessLetterField.text = ""
                disableGuessButton()
                wrongGuess += 1
                updateGuesses()
    }
    func updateGuesses() {
        print("")
        if wordGussedForNow == arrayWords[presentWord][0].uppercased(){
                    myImageView.isHidden =  false
                    guessedWord += 1
                    if presentWord == arrayWords.count-1{
                        guessCountLabel.text = "Great work!, You can start again"
                        myImageView.image = UIImage(named:arrayImages[presentWord])
                        animate()
                    }else{
                        guessCountLabel.text = "Nice Guess! You took \(wrongGuess) guesses to get the word"
                        myImageView.image = UIImage(named:arrayImages[presentWord])
                        animate()
                    }
                    wordsGuessedLabel.text! = "Words Guessed: \(guessedWord)"
                    wordsRemainingLabel.text! = "Words Remaining: \(arrayWords.count - guessedWord)"
                    playAgainButton.isHidden = false
                    guessLetterField.isEnabled = false
                    
                    
                }else{
                    guessCountLabel.text = "You have made \(wrongGuess) guesses"
                    
                }
                
                if wrongGuess == maxNumOfWrongGuesses  {
                    myImageView.isHidden =  false
                    if presentWord == arrayWords.count {
                        print(presentWord)
                        guessCountLabel.text = "Great, Guessed right!, Keep going for new words"
                        myImageView.image = UIImage(named:arrayImages[presentWord])
                        animate()
                    }else{
                        print(presentWord)
                        guessCountLabel.text = "Ran out of guesses, don't worry! Try again"
                        myImageView.image = UIImage(named:arrayImages[presentWord])
                        animate()
                        missedGuess += 1
                        disableGuessButton()
                        playAgainButton.isHidden = false
                        guessLetterField.isEnabled = false
                        wordsMissedLabel.text = "Words Missed: \(missedGuess)"
                        wrongGuess = 0
                    }
                }
        
        
    }
    
    func animate(){
        let originalImageFrame = myImageView.frame
                let imageWidthShrink: CGFloat = 20
                let imageHeightShrink: CGFloat = 20
                let smallerImageFrame = CGRect(
                    x: myImageView.frame.origin.x + imageWidthShrink,
                    y: myImageView.frame.origin.y + imageHeightShrink,
                    width: myImageView.frame.width - (imageWidthShrink * 2),
                    height: myImageView.frame.height - (imageHeightShrink * 2))
                
                myImageView.frame = smallerImageFrame
                
                UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10.0, options: [.curveEaseIn], animations: {
                    self.myImageView.frame = originalImageFrame
                })
    }
    
    func disableGuessButton(){
        if guessLetterField.text!.count>0{
                    guessButton.isEnabled = true
                    let lastCharacter = guessLetterField.text!.last
                    guessLetterField.text = String(lastCharacter!).trimmingCharacters(in: .whitespaces)
                }else{
                    guessButton.isEnabled = false
                }
    }
    func updateLabels(){
        wordsMissedLabel.text! = "Words Missed: \(missedGuess)"
                wordsGuessedLabel.text! = "Words Guessed: \(guessedWord)"
                wordsRemainingLabel.text! = "Words Remaining: \(arrayWords.count - guessedWord)"
                totalWordsLabel.text! = "Words in Game:  \(arrayWords.count)"
    }
    func updateGuessingLetterWord(_ currentNumber:Int){
        userGuessLabel.text = ""
                
                for _ in 0..<arrayWords[currentNumber][0].count {
                    userGuessLabel.text! += "_ "
                }
                hintLabel.text = "HINT: \(arrayWords[currentNumber][1])"
                guessLetter = ""
                playAgainButton.isHidden = true
                guessLetterField.isEnabled = true
                wrongGuess = 0
                
                guessCountLabel.text = "You have made \(wrongGuess) guesses"
        
    }
    @IBAction func guessLetterWordEdited(_ sender: Any) {
        disableGuessButton()
    }
    
    @IBAction func doneKeyPressed(_ sender: Any) {
        guessButtonAction()
    }
}
