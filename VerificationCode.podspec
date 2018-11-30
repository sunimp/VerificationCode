Pod::Spec.new do |s|

  s.name         = "VerificationCode"
  s.version      = "0.0.1"
  s.summary      = "VerificationCode is a sample and easy phone auth UI Component."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
  VerificationCode is a mobile phone auth UI Component with underlines for each character placeholder.
                   DESC

  s.homepage     = "https://github.com/oneofai/VerificationCode"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Sun" => "holaux@gmail.com" }
  s.source       = { :git => "https://github.com/oneofai/VerificationCode.git" }
  # s.ios.deployment_target = '10.0'
  s.platform     = :ios, "10.0"
  s.default_subspec  = "Core"
  
  s.subspec "Core" do |core|
    core.source_files  = "Source/VerificationCode/*"
    core.framework     = "UIKit"
  end

  s.subspec "Rx" do |rx|
    rx.source_files = "Source/RxSwift/*"
    rx.dependency 'VerificationCode/Core'
    rx.dependency 'RxSwift'
    rx.dependency 'RxCocoa'
  end

end
