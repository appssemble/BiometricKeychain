#
# Be sure to run `pod lib lint BiometricKeychain.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BiometricKeychain'
  s.version          = '0.1.0'
  s.summary          = 'Biometric keychain helper, saves and fetches data from keychain only after the biometric validation succeded.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Biometric keychain helper, saves and fetches data from keychain only after the biometric validation succeded, if your device has biometrics enabled, otherwise it will work like a simple keychain store.
                       DESC

  s.homepage         = 'https://github.com/appssemble/BiometricKeychain'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'appssemble' => 'dragos@appssemble.com' }
  s.source           = { :git => 'https://github.com/appssemble/BiometricKeychain/tree/master/bio'}
  s.social_media_url = 'https://twitter.com/dobreandl'

  s.ios.deployment_target = '10.0'

  s.source_files = 'BiometricKeychain/Classes/**/*'
  
  # s.resource_bundles = {
  #   'BiometricKeychain' => ['BiometricKeychain/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'LocalAuthentication', 'Security'

end
