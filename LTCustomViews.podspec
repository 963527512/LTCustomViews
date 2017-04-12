#
# Be sure to run `pod lib lint LTCustomViews.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LTCustomViews'
  s.version          = '0.1.0'
  s.summary          = 'LTCustomViews.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'自定义控件集合, 用于存放个人所有自定义的控件'
                       DESC

  s.homepage         = 'https://github.com/963527512/LTCustomViews'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
  s.author           = { '冰凌天' => '963527512@qq.com' }
  s.source           = { :git => 'https://github.com/963527512/LTCustomViews.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  # 上下按钮
  s.subspec 'LTUpDownButton' do |b|
    b.source_files = 'LTCustomViews/Classes/LTUpDownButton/**/*'
  end

  # 左右滑动菜单
  s.subspec 'LTMenueView' do |m|
    m.source_files = 'LTCustomViews/Classes/LTMenueView/**/*'
    m.dependency 'LTCustomViews/LTUpDownButton'
  end
  
  # s.resource_bundles = {
  #   'LTCustomViews' => ['LTCustomViews/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
