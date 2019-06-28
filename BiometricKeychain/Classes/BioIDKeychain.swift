//
//  BioIDKeychain.swift
//  BIOKeychainTest
//
//  Created by Dragos Dobrean on 28/06/2019.
//  Copyright © 2019 APPSSEMBLE-SOFT. All rights reserved.
//

import Foundation
import LocalAuthentication

public typealias SetBioIDCompletion = (_ success: Bool) -> Void
public typealias DeleteBioIDCompletion = (_ success: Bool) -> Void

public typealias GetBioIDDataCompletion = (_ success: Bool, _ data: Data?) -> Void
public typealias GetBioIDStringCompletion = (_ success: Bool, _ string: String?) -> Void
public typealias GetBioIDNumberCompletion = (_ success: Bool, _ number: NSNumber?) -> Void
public typealias GetBioIDBoolCompletion = (_ success: Bool, _ bool: Bool?) -> Void

public enum BioType {
    case touchID
    case faceID
    case none
}

@objcMembers
public class BioIDKeychain {

    private let keychain = BioIDHelper()

    // Returns weather or not the device support biometric authenticaion

    public var hasBiometricAuthentication: Bool {
        let context = LAContext()

        if !context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            return false
        }

        return true
    }

    // Returns the type of biometric authentication

    public var bioType: BioType {
        let context = LAContext()
        guard #available(iOS 11.0, *) else {
            return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touchID : .none
        }

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            if context.biometryType == .touchID {
                return .touchID
            }
            if context.biometryType == .faceID {
                return .faceID
            }
        }

        return .none
    }
    
    public init() {
        // Public init
    }

    /**
     Saves a string object protected by Biometric authentication for the specified key

     - Parameter data: the value which will be saved
     - Parameter key: the key for which the value will be saved
     - Parameter completion: closure which will be called once the save is completed or an error occured
     
     - it will overwritte previous existing value, IF BIO IS NOT SET UP ON THE DEVICE, IT WILL SAVE THE VALUE ANYWAY without the usage of biometrics
     */
    public func setStringForKey(string: String, forKey key: String, completion: @escaping SetBioIDCompletion) {
        keychain.setStringWithBioID(string: string, forKey: key, completion: completion)
    }

    /**
     Returns the saved string for the provided key, if this exists only after the user is authenticated

     - Parameter key: the key for which the value will be fetched
     - Parameter completion: closure which will be called once the value is retrived or an error occured

     - IF BIO IS NOT SET UP ON THE DEVICE, IT WILL FETCH THE VALUE ANYWAY
     */
    public func getString(forKey key: String, completion: @escaping GetBioIDStringCompletion) {
        keychain.getStringWithBioID(forKey: key, completion: completion)
    }

    /**
     Saves a data object protected by Biometric authentication for the specified key

     - Parameter data: the value which will be saved
     - Parameter key: the key for which the value will be saved
     - Parameter completion: closure which will be called once the save is completed or an error occured

     - it will overwritte previous existing value, IF BIO IS NOT SET UP ON THE DEVICE, IT WILL SAVE THE VALUE ANYWAY without the usage of biometrics
     */
    public func setDataForKey(data: Data, forKey key: String, completion: @escaping SetBioIDCompletion) {
        keychain.setDataWithBioID(data: data, forKey: key, completion: completion)
    }

    /**
     Returns the saved data for the provided key, if this exists only after the user is authenticated

     - Parameter key: the key for which the value will be fetched
     - Parameter completion: closure which will be called once the value is retrived or an error occured

     - IF BIO IS NOT SET UP ON THE DEVICE, IT WILL FETCH THE VALUE ANYWAY
     */
    public func getData(forKey key: String, completion: @escaping GetBioIDDataCompletion) {
        keychain.getDataWithBioID(forKey: key, completion: completion)
    }

    /**
     Saves a number object protected by Biometric authentication for the specified key

     - Parameter data: the value which will be saved
     - Parameter key: the key for which the value will be saved
     - Parameter completion: closure which will be called once the save is completed or an error occured

     - it will overwritte previous existing value, IF BIO IS NOT SET UP ON THE DEVICE, IT WILL SAVE THE VALUE ANYWAY without the usage of biometrics
     */
    public func setNumberForKey(number: NSNumber, forKey key: String, completion: @escaping SetBioIDCompletion) {
        keychain.setNumberWithBioID(number: number, forKey: key, completion: completion)
    }

    /**
     Returns the saved number for the provided key, if this exists only after the user is authenticated

     - Parameter key: the key for which the value will be fetched
     - Parameter completion: closure which will be called once the value is retrived or an error occured

     - IF BIO IS NOT SET UP ON THE DEVICE, IT WILL FETCH THE VALUE ANYWAY
     */
    public func getNumber(forKey key: String, completion: @escaping GetBioIDNumberCompletion) {
        keychain.getNumberWithBioID(forKey: key, completion: completion)
    }

    /**
     Saves a bool object protected by Biometric authentication for the specified key

     - Parameter data: the value which will be saved
     - Parameter key: the key for which the value will be saved
     - Parameter completion: closure which will be called once the save is completed or an error occured

     - it will overwritte previous existing value, IF BIO IS NOT SET UP ON THE DEVICE, IT WILL SAVE THE VALUE ANYWAY without the usage of biometrics
     */
    public func setBoolForKey(bool: Bool, forKey key: String, completion: @escaping SetBioIDCompletion) {
        let number = NSNumber.init(booleanLiteral: bool)

        keychain.setNumberWithBioID(number: number, forKey: key, completion: completion)
    }

    /**
      Returns the saved bool for the provided key, if this exists only after the user is authenticated

     - Parameter key: the key for which the value will be fetched
     - Parameter completion: closure which will be called once the value is retrived or an error occured

     - IF BIO IS NOT SET UP ON THE DEVICE, IT WILL FETCH THE VALUE ANYWAY
     */
    public func getBool(forKey key: String, completion: @escaping GetBioIDBoolCompletion) {
        keychain.getNumberWithBioID(forKey: key) { (success, number) in
            guard success == true,
                let numberValue = number else {

                completion(false, nil)

                return
            }

            completion(true, numberValue.boolValue)
        }
    }

    /**
     Deletes the value at the specified key if the value exists

     - Parameter key: the key for which the value will be deleted
     - Parameter completion: closure which will be called once the value is deleted or an error occured

     - IF BIO IS NOT SET UP ON THE DEVICE, IT WILL DELETE THE VALUE ANYWAY
     */
    public func deleteValue(forKey key: String, completion: @escaping DeleteBioIDCompletion) {
        keychain.deleteBioIDItem(forKey: key, completion: completion)
    }

}
