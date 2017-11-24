# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'summary' do
  use_frameworks!

  pod 'RxSwift', '~> 4.0'
  pod 'RxCocoa', '~> 4.0'

  # Firebase
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firestore', :podspec => 'https://storage.googleapis.com/firebase-preview-drop/ios/firestore/0.7.0/Firestore.podspec.json'
  pod 'Firebase/DynamicLinks'
  pod 'Firebase/AdMob'

  # Facebook
  pod 'FacebookCore'
  pod 'FacebookLogin'
  pod 'FacebookShare'

  # Form
  pod 'Eureka'

  target 'summaryTests' do
    inherit! :search_paths
  end

  target 'summaryUITests' do
    inherit! :search_paths
  end

end
