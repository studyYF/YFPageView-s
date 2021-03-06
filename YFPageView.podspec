#
# Be sure to run `pod lib lint YFPageView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YFPageView'
  s.version          = '0.3.0'
  s.summary          = 'YFPageView.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = '类似于今日头条的顶部滑动控件'
  s.homepage         = 'https://github.com/studyYF/YFPageView-s'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '13818556154@163.com' => '13818556154@163.com' }
  s.source           = { :git => 'https://github.com/studyYF/YFPageView-s.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'YFPageView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'YFPageView' => ['YFPageView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'YFBase/Frame'
end
