//
//  ViewController.swift
//  MannKristofer_WearableProject
//
//  Created by Kristofer Klae Mann on 8/24/17.
//  Copyright © 2017 Kristofer Klae Mann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    let lowerCaseArray = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    let upperCaseArray = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    let numbersArray = ["1","2","3","4","5","6","7","8","9","0"]
    var symbolsArray = ["`","~","!","@","#","$","%","^","&","*","(",")","-","_","=","+","[","]","{","}",";",":","'",",",".","<",">","/","?"]
    var randomCharactersArray = [[String]]()
    var allCharactersArray = [[String]]()
    var charactersUsedArray = [[String]]()
    var charactersForPasswordArray = [[String]]()
    var randomizePasswordArray = [String]()
    var passwordsArray = [String]()
    var switchValueArray = [true,true,true,true]
    var length = 8
    
    // allCharactersArray to all of the character arrays
    // Then it sets the charactersUsedArray to it for the initial start up of the app
    override func viewDidLoad() {
        super.viewDidLoad()
        allCharactersArray = [lowerCaseArray,upperCaseArray,numbersArray,symbolsArray]
        charactersUsedArray = allCharactersArray
        
    }
    
    // This sets the value of the length and sliderValueLabel text
    @IBAction func valueChanged(_ sender: UISlider) {
        length = Int(sender.value)
        sliderValueLabel.text = "\(length)"
    }
    
    // MARK: - Actions
    
    // This calls the getSwitchValues methohd and provides it with the sender tag and isOn values
    @IBAction func switchChanged(_ sender: UISwitch) {
        getSwitchValues(index: sender.tag, value: sender.isOn)
    }

    // This is the action that generates the passwords when the Generate button is pressed
    // It first makes sure that the charactersUsedArray is not empty just in case the user turned off all the settings
    // If it isn't empty, it sets the randomCharactersArray to the charactersUsedArray so that only one gets altered
    // Then the passswordsArray removes all just in case the user wanted to generate another set of passwords
    // Finally, it performs a segue to the passwords table view to show all of the passwords
    @IBAction func generateButton(_ sender: UIButton) {
        if !charactersUsedArray.isEmpty{
            randomCharactersArray = charactersUsedArray
            passwordsArray.removeAll()
            for _ in 1...20 {
                var password = ""
                // This loops as many times as the user set the length of the password to be
                // It checks if the randomCharactersArray is empty or not because it will be at a length greater than four
                // Both cases the getRandomArrayOfCharacters is called to randomly mix up the order of arrays within the array
                // If it is empty then it sets the randomCharactersArray to charactersUsedArry again to start the process over
                for _ in 1...length{
                    if !randomCharactersArray.isEmpty{
                        getRandomArrayOfCharacters()
                    }else {
                        randomCharactersArray = charactersUsedArray
                        getRandomArrayOfCharacters()
                    }
                }
                // This loops through as many times as the length
                // It retrieves a random number from each of the arrays within the charactersForPasswordArray based upon count
                // Then it adds the random character to the randomizePassword array to get mixed up randomly in the next loop
                for index in 0..<length {
                    let randomNumber = Int(arc4random_uniform(UInt32(charactersForPasswordArray[index].count)))
                    randomizePasswordArray.append(charactersForPasswordArray[index][randomNumber])
                }
                // This loops through as many times as the length and retrieves a random number based upon the array's count
                // The password then receives a random character from the randmizePasswordArray
                // Then that character is removed from the array so that it cannot be used in the next loop
                for _ in 1...length{
                    let randomNumber = Int(arc4random_uniform(UInt32(randomizePasswordArray.count)))
                    password += randomizePasswordArray[randomNumber]
                    randomizePasswordArray.remove(at: randomNumber)
                }
                passwordsArray.append(password)
                charactersForPasswordArray.removeAll()
            }
            performSegue(withIdentifier: "GoToTableView", sender: sender)
        }

    }
    
    // MARK: - Functions
    
    // This function is used to randomly add an array of characters to the charactersForPasswordArray
    // This is so that each password gets a different set of characters based upon the switches and length
    // The randomCharactersArray then removes the array so that each required character array is used
    func getRandomArrayOfCharacters(){
        let randomNumber = Int(arc4random_uniform(UInt32(randomCharactersArray.count)))
        charactersForPasswordArray.append(randomCharactersArray[randomNumber])
        randomCharactersArray.remove(at: randomNumber)
    }
    
    // This receives an integer and a boolean to change the value of an array item by the index
    // Then it loops thruogh the switchValuArray to add the character arrays if the switch is turned on
    func getSwitchValues(index: Int, value: Bool){
        charactersUsedArray.removeAll()
        switchValueArray[index] = value
        for num in 0..<switchValueArray.count{
            if switchValueArray[num]{
                charactersUsedArray.append(allCharactersArray[num])
            }
        }
    }
    
    // MARK: - Navigation

    // This sends the array of passwords to the TableViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! TableViewController
        destination.passwordsArray = passwordsArray
    }
 

}
