# For details see: https://github.com/CocoaPods/CocoaPods/wiki/The-podspec-format
Pod::Spec.new do |s|
  s.name         = "TumbleOnUtils"
  s.version      = "0.0.7"
  s.summary      = "A collection of objective-c IOS utilities."
  s.homepage     = "http://www.tumbleonapp.com/code"  
  s.license      = { :type => 'Apache', :file => 'LICENSE.md' }
  s.authors      = { "Jason Baker" => "jason@onejasonforsale.com", "Adam Zacharski" => "zacharski@gmail.com" }
  s.source       = { :git => "https://github.com/codercowboy/TumbleOnUtils.git", :tag => "#{s.version}" }  
  s.platform     = :ios, "6.0"
  s.source_files = 'TumbleOnUtils/**/*.{h,m}'
  s.resources	 = 'TumbleOnUtils/**/*.{xib,storyboard,lproj,png,json}'
  s.requires_arc = true
  s.frameworks   = 'CoreGraphics', 'Foundation', 'MessageUI', 'MobileCoreServices', 'QuartzCore', 'UIKit'
end
