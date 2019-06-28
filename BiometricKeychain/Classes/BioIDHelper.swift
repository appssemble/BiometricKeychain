//
//  BioIDHelper.swift
//  BIOKeychainTest
//
//  Created by Dragos Dobrean on 28/06/2019.
//  Copyright © 2019 APPSSEMBLE-SOFT. All rights reserved.
//

import Foundation
import LocalAuthentication
import Security


class BioIDHelper {
    
    private struct Constants {
        static let serviceID = "com.appssemble.biokeychain.service"
    }
    
    // MARK: Public methods
    
    func setNumberWithBioID(number: NSNumber, forKey key: String, completion: @escaping SetBioIDCompletion) {
        let data = Data(from: number.doubleValue)
        
        setDataWithBioID(data: data, forKey: key, completion: completion)
    }
    
    func getNumberWithBioID(forKey key: String, completion: @escaping GetBioIDNumberCompletion) {
        getDataWithBioID(forKey: key) { (success, data) in
            var returnNumber: NSNumber? = nil
            
            if  success,
                let data = data,
                let doubleValue = data.to(type: Double.self) {
                
                // Success
                returnNumber = NSNumber(value: doubleValue)
            }
            
            DispatchQueue.main.async {
                // An error has occured
                completion(success, returnNumber)
            }
        }
    }
    
    func setStringWithBioID(string: String, forKey key: String, completion: @escaping SetBioIDCompletion) {
        if let data = string.data(using: .utf32) {
            setDataWithBioID(data: data, forKey: key, completion: completion)
        }
    }
    
    func getStringWithBioID(forKey key: String, completion: @escaping GetBioIDStringCompletion) {
        
        getDataWithBioID(forKey: key) { (success, data) in
            var returnStr: String? = nil
            
            if  success,
                let data = data,
                let str = String(data: data, encoding: .utf32) {
                
                // Success
                returnStr = str
            }
            
            DispatchQueue.main.async {
                // An error has occured
                completion(success, returnStr)
            }
        }
    }
    
    func setDataWithBioID(data: Data, forKey key: String, completion: @escaping SetBioIDCompletion) {
        
        var error: Unmanaged<CFError>?
        
        let secRefOptional = SecAccessControlCreateWithFlags(kCFAllocatorDefault, kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, .touchIDAny, &error)
        
        guard let secRef = secRefOptional else {
            // Could not create access control
            completion(false)
            
            return
        }
        
        let attributes = [kSecClass: kSecClassGenericPassword,
                          kSecAttrService: Constants.serviceID,
                          kSecValueData: data,
                          kSecAttrAccount: key,
                          kSecUseAuthenticationUI: kSecUseAuthenticationUIAllow,
                          kSecAttrAccessControl: secRef] as [CFString: Any]
        
        
        DispatchQueue.global().async {
            let status = SecItemAdd(attributes as CFDictionary, nil)
            
            var success = false
            
            if status == errSecDuplicateItem {
                // We need to update the item as it aleady exists
                self.updateDataWithBioID(data: data, forKey: key, completion: completion)
                
                return
                
            } else if status == errSecSuccess {
                // Successfuly added
                success = true
            }
            
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    func deleteBioIDItem(forKey key: String, completion: @escaping DeleteBioIDCompletion) {
        let attributes = [kSecClass: kSecClassGenericPassword,
                          kSecAttrService: Constants.serviceID,
                          kSecAttrAccount: key] as [CFString: Any]
        
        DispatchQueue.global().async {
            let status = SecItemDelete(attributes as CFDictionary)
            
            var success = false
            
            if status == errSecSuccess {
                // Success
                success = true
            }
            
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    func getDataWithBioID(forKey key: String, completion: @escaping GetBioIDDataCompletion) {
        
        let attributes = [kSecClass: kSecClassGenericPassword,
                          kSecAttrService: Constants.serviceID,
                          kSecAttrAccount: key,
                          kSecReturnData: true] as [CFString: Any]
        
        DispatchQueue.global().async {
            var dataTypeRef: CFTypeRef?
            
            let status = SecItemCopyMatching(attributes as CFDictionary, &dataTypeRef)
            
            var success = false
            var returnData: Data? = nil
            
            if status == errSecSuccess {
                
                if let data = dataTypeRef as? Data {
                    // Success
                    success = true
                    returnData = data
                }
            }
            
            DispatchQueue.main.async {
                completion(success, returnData)
            }
        }
    }
    
    // MARK: Private methods
    
    private func updateDataWithBioID(data: Data, forKey key: String, completion: @escaping SetBioIDCompletion) {
        let attributes = [kSecClass: kSecClassGenericPassword,
                          kSecAttrService: Constants.serviceID,
                          kSecAttrAccount: key] as [CFString: Any]
        
        let changes = [kSecValueData: data] as [CFString: Any]
        
        DispatchQueue.global().async {
            let status = SecItemUpdate(attributes as CFDictionary, changes as CFDictionary)
            
            var success = false
            
            if status == errSecSuccess {
                // Successfuly updated
                success = true
            }
            
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
}
