//
//  GeneralKeyChain.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import Foundation
import SwiftKeychainWrapper

class GeneralKeychain {
    
    static let shared = GeneralKeychain()
    
    private init() {
        
    }
    
    func addKey(keyToSave: String, keyName: String) -> Bool {
        
        let succesful: Bool = KeychainWrapper.standard.set(keyToSave, forKey: keyName)
        return succesful
    }
    
    func getKey(keyName: String) -> String {
        var keyToReport = ""
        
        if KeychainWrapper.standard.string(forKey: keyName) != nil {
            keyToReport = KeychainWrapper.standard.string(forKey: keyName)!
        }
        
        return keyToReport
    }
    
    func addIntegerKey(keyToSave: Int, keyName: String) -> Bool {
       let succesful: Bool = KeychainWrapper.standard.set(keyToSave, forKey: keyName)
        return succesful
    }
    
    func getIntegerKey(keyName: String) -> Int {
        var keyToReport = 0
        
        if KeychainWrapper.standard.integer(forKey: keyName) != nil {
            keyToReport = KeychainWrapper.standard.integer(forKey: keyName)!
        }
        
        return keyToReport
    }
    
    func addBoolKey(keyToSave: Bool, keyName: String) -> Bool {
       let succesful: Bool = KeychainWrapper.standard.set(keyToSave, forKey: keyName)
        return succesful
    }
    
    func getBoolKey(keyName: String) -> Bool {
        var keyToReport = false
        
        if KeychainWrapper.standard.integer(forKey: keyName) != nil {
            keyToReport = KeychainWrapper.standard.bool(forKey: keyName)!
        }
        
        return keyToReport
    }
    
    func removeKey(keyToRemove: String) -> Bool {
        let removeSuccesful: Bool = KeychainWrapper.standard.removeObject(forKey: keyToRemove)
        return removeSuccesful
    }
}

