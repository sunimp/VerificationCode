Pod::Spec.new do |s|

  s.name         = "MFVerificationCode"
  s.version      = "1.3.1"
  s.summary      = "VerificationCode is a sample and easy phone auth UI Component."
  s.description  = <<-DESC
  VerificationCode is a mobile phone auth UI Component with underlines for each character placeholder.
                   DESC

  s.homepage     = "https://github.com/oneofai/VerificationCode"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Sun" => "holaux@gmail.com" }
  s.source       = { :git => "https://github.com/oneofai/VerificationCode.git", :tag => s.version}
  s.ios.deployment_target = '10.0'

  s.source_files  = "Source/VerificationCode/*"
  s.framework     = "UIKit"
end
