#
# Be sure to run `pod lib lint CNCitySelector.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CNCitySelector'
  s.version          = '1.0.0'
  s.summary          = '一个零配置，快速集成的中国行政区域选择Controller'
  s.description      = <<-DESC
一个零配置，快速集成的中国行政区域选择Controller
                       DESC

  s.homepage         = 'https://github.com/enix223/CNCitySelector'
  s.screenshots     = 'https://github.com/enix223/CNCitySelector/Screenshot/screen.jpeg'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Enix Yu' => 'enixyu@cloudesk.top' }
  s.source           = { :git => 'https://github.com/enix223/CNCitySelector.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/enixyu'

  s.ios.deployment_target = '9.0'

  s.source_files = 'CNCitySelector/Classes/**/*'
  
  s.resource_bundles = {
    'CNCitySelector' => ['CNCitySelector/Assets/**/*', 'CNCitySelector/Classes/*.xib']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
