#
# Be sure to run `pod lib lint ChofyExtensions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ChofyExtensions'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ChofyExtensions.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Juan Alfredo García González/ChofyExtensions'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Juan Alfredo García González' => 'sensei_12c4@hotmail.com' }
  s.source           = { :git => 'https://github.com/Juan Alfredo García González/ChofyExtensions.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'ChofyExtensions/Classes/**/*'
  
  s.dependency 'SDWebImage', '~> 5.0'
  s.dependency 'RxSwift', '6.1.0'
  s.dependency 'RxCocoa', '6.1.0'
  s.dependency 'Alamofire', '~> 5.2'
  
  s.resource_bundles = {
    'ChofyExtensionsResources' => [
      'ChofyExtensions/Assets/**/*.{storyboard,xib,json,pem,html,strings,xcassets,otf}'
    ]
  }
  
  # s.resource_bundles = {
  #   'ChofyExtensions' => ['ChofyExtensions/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
