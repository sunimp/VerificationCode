Pod::Spec.new do |s|

  s.name         = "MFVerificationCode"
  s.version      = "1.2.1"
  s.swift_version= "4.2" 
  s.summary      = "VerificationCode is a sample and easy phone auth UI Component."
  s.description  = <<-DESC
  VerificationCode is a mobile phone auth UI Component with underlines for each character placeholder.
                   DESC

  s.homepage     = "https://github.com/oneofai/VerificationCode"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Sun" => "holaux@gmail.com" }
  s.source       = { :git => "https://github.com/oneofai/VerificationCode.git", :tag => s.version}
  # s.ios.deployment_target = '10.0'
  s.platform     = :ios, "10.0"
  s.default_subspec  = "Core"
  
  s.subspec "Core" do |core|
    core.source_files  = "Source/VerificationCode/*"
    core.framework     = "UIKit"
  end

   s.subspec "Rx" do |rx|
     rx.source_files = "Source/Rx/*"
     rx.dependency 'MFVerificationCode/Core'
     rx.dependency 'RxSwift'
     rx.dependency 'RxCocoa'
   end

end
