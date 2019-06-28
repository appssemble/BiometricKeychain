# BiometricKeychain

[![Version](https://img.shields.io/cocoapods/v/BiometricKeychain.svg?style=flat)](https://cocoapods.org/pods/BiometricKeychain)
[![Platform](https://img.shields.io/cocoapods/p/BiometricKeychain.svg?style=flat)](https://cocoapods.org/pods/BiometricKeychain)

## Description

BiometricKeychain saves and fetches data from keychain only after the biometric validation succeded. If your device does not support biometric authentication or is not enabled, the library will store the items in the keychain without the need for authentication.

By default it supports the following data types **String**, **Date**, **NSNumber**, **Bool**. More types can be easily added.


## Requirements

- iOS 10
- Swift

## Installation

BiometricKeychain is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BiometricKeychain'
```

## Usage

```swift
  import BiometricKeychain
  
  class ViewController: UIViewController {
    
    let bioKeychain = BioIDKeychain()
    
    func demoType() {
      let fetchedBioType = bioKeychain.bioType // The type of the biometric installed on the device
    }
    
    func demoSave() {
        bioKeychain.setBoolForKey(bool: false, forKey: "bool") { (success) in
            guard success else {
                print("failed saving the bool value")

                return
            }

            print("bool value saved")
        }
    }
    
    func demoGet() {
        self.bioKeychain.getBool(forKey: "bool") { (success, bool) in
            guard success, let value = bool else {
                print("failed saving the bool value")
                
                return
            }
            
            print("The saved value is \(value)")
        }
    }
```

## API

```swift

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

```

## Author

appssemble, office@appssemble.com

## License

BiometricKeychain is available under the MIT license. See the LICENSE file for more info.
