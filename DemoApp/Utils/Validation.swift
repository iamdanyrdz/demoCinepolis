//
//  Validation.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import Foundation

public class Validation {
    
    public static func validateEmailId(emailID: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let trimmedString = emailID.trimmingCharacters(in: .whitespaces)
        let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValidateEmail = validateEmail.evaluate(with: trimmedString)
        return isValidateEmail
    }
    
    public static func validarEmailRegistroFormulario(emailID: String) -> String {
        //Se verifica que exita un @
        let arregloLetras = Array(emailID)
        if arregloLetras.count > 241{
            return "Solo se permiten 241 caracteres"
        }
        if !arregloLetras.contains("@"){
            return "El correo no tiene formato válido"
            //return "Por favor incluye '@' en tu correo electrónico"
        }
        let posicionArroba = arregloLetras.firstIndex(of: "@") ?? 0
        if posicionArroba > 64{
            return "El nombre no puede contener mas de 64 caracteres"
        }
        let diferenciaCaracteres = arregloLetras.count - posicionArroba
        if diferenciaCaracteres > 177{
            return "El dominio no puede contener mas de 177 caracteres"
        }
        if arregloLetras.contains("ñ") || arregloLetras.contains("Ñ"){
            return "El correo no puede contener ñ"
        }
        if arregloLetras.contains("á") || arregloLetras.contains("Á") || arregloLetras.contains("é") || arregloLetras.contains("É") || arregloLetras.contains("í") || arregloLetras.contains("Í") || arregloLetras.contains("ó") || arregloLetras.contains("Ó") || arregloLetras.contains("ú") || arregloLetras.contains("Ú"){
            return "El correo no puede contener acentos"
        }
        if  arregloLetras.contains("!") || arregloLetras.contains("´") || arregloLetras.contains("#") || arregloLetras.contains("$") || arregloLetras.contains("%") || arregloLetras.contains("&") || arregloLetras.contains("/") || arregloLetras.contains("(") || arregloLetras.contains(")") || arregloLetras.contains("=") || arregloLetras.contains("?") || arregloLetras.contains("¿") || arregloLetras.contains("¡") || arregloLetras.contains("*") || arregloLetras.contains("+") || arregloLetras.contains("[") || arregloLetras.contains("]") || arregloLetras.contains("{") || arregloLetras.contains("}") || arregloLetras.contains("<") ||  arregloLetras.contains(">") || arregloLetras.contains(",") || arregloLetras.contains(";") || arregloLetras.contains(":") || arregloLetras.contains("|") || arregloLetras.contains("°") || arregloLetras.contains("≠"){
            return "El correo no puede contener caracteres especiales"
        }
        print(arregloLetras)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let trimmedString = emailID.trimmingCharacters(in: .whitespaces)
        let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValidateEmail = validateEmail.evaluate(with: trimmedString)
        if isValidateEmail{
            return ""
        }
        return "El correo no tiene formato válido"
    }
    
    public static func validatePassword(password: String) -> Bool {
        let passRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,10}$"
        let trimmedString = password.trimmingCharacters(in: .whitespaces)
        let validatePassord = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        let isvalidatePass = validatePassord.evaluate(with: trimmedString)
        return isvalidatePass
    }
    
    public static func validarPasswordRegistroFormulario(password: String) -> String {
        //Se verifica que exita un @
        let arregloLetras = Array(password)
        if arregloLetras.count < 8 {
            return "La contraseña debe tener mínimo 8 caracteres"
        }
        
        if arregloLetras.count > 10 {
            return "La contraseña no puede contener mas de 10 caracteres"
        }
        
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: password)
        
        if !capitalresult {
            return "La contraseña debe contener al menos una mayúscula y un número"
            //return "Por favor incluye una mayuscula en tu contraseña"
        }
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = texttest1.evaluate(with: password)
        
        if !numberresult {
            return "La contraseña debe contener al menos una mayúscula y un número"
        }
        let passRegEx = "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,10}$"
        let trimmedString = password.trimmingCharacters(in: .whitespaces)
        let validatePassord = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        let isvalidatePass = validatePassord.evaluate(with: trimmedString)
        if isvalidatePass {
            return ""
        }
        return "La contraseña no cumple con los requisitos"
    }
    
    public static func validateAlphaNumeric(letter: String) -> Bool {
        let otherRegexString = ".*[A-Za-z0-9].*"
        let trimmedString = letter.trimmingCharacters(in: .whitespaces)
        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", otherRegexString)
        let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
        return isValidateOtherString
    }
}
