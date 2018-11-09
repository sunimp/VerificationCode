#
# Be sure to run `pod lib lint SwiftyCodeView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'VerificationCode'
  s.version          = '0.0.1'
  s.summary          = 'VerificationCode is a sample and easy phone auth element.'
  s.description      = <<-DESC
VerificationCode is a sample and easy phone auth element.
                       DESC
  s.homepage         = 'https://github.com/oneofai/VerificationCode'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'oneofai' => 'holaux@gmail.com' }
  s.source           = { :git => 'https://github.com/oneofai/VerificationCode.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ideerpark'
  s.ios.deployment_target = '10.0'
  s.default_subspec  = "Core"

  s.subspec "Core" do |ss|
    ss.source_files = 'VerificationCode/Sources/*'
    ss.frameworks   = 'UIKit'
  end

  s.subspec "RxSwift" do |ss|
    ss.source_files = "VerificationCode/Sources/*"
    ss.dependency "VerificationCode/Core"
    ss.dependency "RxSwift"
    ss.dependency "RxCocoa"
  end

end