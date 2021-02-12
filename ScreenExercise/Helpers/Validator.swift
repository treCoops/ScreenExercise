//
//  Validator.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-02-03.
//

import Foundation

class Validator {
    
    static func isEmpty(_ text: String) -> Bool {
        if text == ""{
            return true
        }else{
            return false
        }
    }
    
    static func isValidName(_ name: String) -> Bool{
        let nameRegEx = "(?<! )[-a-zA-Z' ]{2,26}"
        let namePred = NSPredicate(format:"SELF MATCHES %@", nameRegEx)

        return namePred.evaluate(with: name)
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

        return emailPred.evaluate(with: email)
    }
    
    static func isValidPhoneNumber(_ phone: String) -> Bool{
        let phoneRegEx = "^(/+94))[0-9]{9}$"
        let phonePred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)

        return phonePred.evaluate(with: phone)
    }
    
    static func checkLenght(_ text: String, _ count: Int) -> Bool{
        if text.count != count {
            return true
        }else{
            return false
        }
    }
    
    static func isNumber(_ text: String) -> Bool{
        let numberRegEx = "^[0-9]{1,2}$"
        let numberPred = NSPredicate(format:"SELF MATCHES %@", numberRegEx)

        return numberPred.evaluate(with: text)
    }
}
