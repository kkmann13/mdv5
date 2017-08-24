//
//  InterfaceController.swift
//  MannKristofer_WearableProject WatchKit Extension
//
//  Created by Kristofer Klae Mann on 8/13/17.
//  Copyright © 2017 Kristofer Klae Mann. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController, SettingsDelegate {
    
    @IBOutlet var lengthLabel: WKInterfaceLabel!
    
    let lowerCaseArray = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    let upperCaseArray = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    let numbersArray = ["1","2","3","4","5","6","7","8","9","0"]
    var symbolsArray = ["`","~","!","@","#","$","%","^","&","*","(",")","-","_","=","+","[","]","{","}",";",":","'",",",".","<",">","/","?"]
    var allCharactersArray = [[String]]()
    var randomCharactersArray = [[String]]()
    var charactersUsedArray = [[String]]()
    var charactersForPasswordArray = [[String]]()
    var randomizePasswordArray = [String]()
    var passwordsArray = [String]()
    var length = 8
    var switchValueArray = [true,true,true,true]

    // MARK: Actions
    // This sets the length of the passwords generated to its variable that is used in the generatePasswords function
    // It also sets the text of the label to the value to inform the user of the change
    @IBAction func sliderChangedValue(_ value: Int) {
        lengthLabel.setText("\(value)")
        length = value
    }
    
    // This is the action that generates the passwords when the Generate button is pressed
    // It first makes sure that the charactersUsedArray is not empty just in case the user turned off all the settings
    // If it isn't empty, it sets the randomCharactersArray to the charactersUsedArray so that only one gets altered
    // Then the passswordsArray removes all just in case the user wanted to generate another set of passwords
    // The entire process of generating passwords loops 10 times to generate 10 random passwords that will be added to the passwordsArray which will be sent to the PasswordInterfaceController
    @IBAction func generatePasswords() {
        if !charactersUsedArray.isEmpty{
            randomCharactersArray = charactersUsedArray
            passwordsArray.removeAll()
            for _ in 1...10 {
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
            pushController(withName: "PasswordsTable", context: passwordsArray)
        }
    }
    
    // This goes to the SettingsInterface and sends its self for the delgate in that Interface
    @IBAction func settingsButton() {
        pushController(withName: "SettingsInterface", context: self)
    }
    
    
    // This function is used to randomly add an array of characters to the charactersForPasswordArray
    // This is so that each password gets a different set of characters based upon the switches and length
    // The randomCharactersArray then removes the array so that each required character array is used
    func getRandomArrayOfCharacters(){
        let randomNumber = Int(arc4random_uniform(UInt32(randomCharactersArray.count)))
        charactersForPasswordArray.append(randomCharactersArray[randomNumber])
        randomCharactersArray.remove(at: randomNumber)
    }
    
    // This sets the allCharactersArray to an array of each character type for the charactersUsedArry to access
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        allCharactersArray = [lowerCaseArray,upperCaseArray,numbersArray,symbolsArray]
    }
    
    // MARK - SettingsDelegate
    // This receives an array of boolean values based upon the switches being on/off in the SettingsInterface
    // It sets its value to that of the switchValueArray for the willActivate method to use
    func changedSettings(valueArray: [Bool]) {
        switchValueArray = valueArray
    }
    
    // This removes all arrays from the charactersUsedArray so that it starts out empty each time
    // The it loops through the switchValueArray to determine which switch is on/off
    // If on is true, then it appends that array from the allCharactersArray based upon the index
    // The password generator will only use the array of characters within the charactersUsedArray until the settings are changed
    override func willActivate() {
        super.willActivate()
        charactersUsedArray.removeAll()
        for index in 0...3{
            if switchValueArray[index] {
                charactersUsedArray.append(allCharactersArray[index])
            }
        }
        
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }

}
