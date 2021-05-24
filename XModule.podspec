#
# Be sure to run `pod lib lint XModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XModule'
  s.version          = '0.1.0'
  s.summary          = 'A short description of XModule.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/hbbdsqd/XModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '苏秋东' => 'suqiudong@fltrp.com' }
  s.source           = { :git => 'https://github.com/hbbdsqd/XModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.source_files = 'XModule/Classes/**/*'
  s.prefix_header_file = 'XModule/Classes/PrefixHeader.pch'
  s.static_framework = true
  s.resource_bundles = {
    'XModule' => ['XModule/Assets/*']
  }
   
  s.frameworks = 'UIKit', 'Foundation'
  
  s.dependency 'FMDB', '2.7.5'
  s.dependency 'FCUUID', '1.3.1'
  s.dependency 'CTMediator', '32'
  s.dependency 'WGKCategories', '0.1.0'
  s.dependency 'ReactiveCocoa', '2.1.8'
  s.dependency 'FDFullscreenPopGesture', '1.1'

  s.dependency 'Luban_iOS', '1.0.6'
  s.dependency 'SDWebImage', '5.10.0'
  s.dependency 'AFNetworking','4.0.0'
  s.dependency 'AlicloudHTTPDNS','1.19.2.7'
  
  s.dependency 'YYText', '1.0.7'
  s.dependency 'YYModel','1.0.4'
  s.dependency 'YYImage','1.0.4'
  s.dependency 'YYImage/WebP'

  s.dependency 'MJRefresh','3.5.0'
  s.dependency 'MJExtension','3.2.2'
  
  s.dependency 'Masonry', '1.1.0'
  s.dependency 'MBProgressHUD', '1.2.0'
  s.dependency 'JXCategoryView','1.5.8'
  s.dependency 'CRBoxInputView' , '1.2.1'
  s.dependency 'IQKeyboardManager', '6.0.6'
  s.dependency 'SDCycleScrollView','1.82'
  
  
  s.dependency 'TFHpple','2.0.0'
  s.dependency 'WebViewJavascriptBridge', '6.0.3'
  
  s.dependency 'Bugly','2.5.71'
  s.dependency 'YKWoodpecker','1.2.9' #debug工具 
end
