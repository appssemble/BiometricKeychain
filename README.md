# BiometricKeychain

[![Version](https://img.shields.io/cocoapods/v/BiometricKeychain.svg?style=flat)](https://cocoapods.org/pods/BiometricKeychain)
[![Platform](https://img.shields.io/cocoapods/p/BiometricKeychain.svg?style=flat)](https://cocoapods.org/pods/BiometricKeychain)

## Requirements

- iOS 10

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

## Author

appssemble, office@appssemble.com

## License

BiometricKeychain is available under the MIT license. See the LICENSE file for more info.
