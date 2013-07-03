# For details see: https://github.com/CocoaPods/CocoaPods/wiki/The-podspec-format
Pod::Spec.new do |s|
  s.name         = "TumbleOnUtils"
  s.version      = "0.0.5"
  s.summary      = "A collection of objective-c IOS utilities."
  s.homepage     = "http://www.tumbleonapp.com/code"  
  s.license      = { :type => 'Apache', :file => 'LICENSE.md' }
  s.authors      = { "Jason Baker" => "jason@onejasonforsale.com", "Adam Zacharski" => "zacharski@gmail.com" }
  s.source       = { :git => "https://github.com/codercowboy/TumbleOnUtils.git", :tag => "0.0.6" }  
  s.platform     = :ios, "5.0"
  s.source_files = 'Classes', 'Classes/**/*.{h,m}', 'License.md', 'README.md'
  s.requires_arc = true
  s.frameworks   = 'CoreGraphics', 'Foundation', 'MessageUI', 'MobileCoreServices', 'QuartzCore', 'UIKit'
end
