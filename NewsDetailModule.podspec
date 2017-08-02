#
# Be sure to run `pod lib lint NewsDetailModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NewsDetailModule'
  s.version          = '0.1.0'
  s.summary          = 'NewsDetailModule.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of NewsDetailModule.
                       DESC

  s.homepage         = 'https://github.com/LovePlayModule/NewsDetailModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'YunsChou' => '2647754496@qq.com' }
  s.source           = { :git => 'https://github.com/LovePlayModule/NewsDetailModule', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  # s.source_files = 'NewsDetailModule/Classes/**/*'
  
  s.default_subspecs = 'Model', 'View', 'Controller', 'Targets'

  s.subspec 'Model' do |ss|
    ss.source_files = 'NewsDetailModule/Classes/Model/**/*'

    ss.dependency 'NewsCommentModule/Model'
  end

  s.subspec 'View' do |ss|
    ss.source_files = 'NewsDetailModule/Classes/View/**/*'

    ss.dependency 'Tools'
    ss.dependency 'YYKit'
    ss.dependency 'Masonry'

    ss.dependency 'NewsDetailModule/Model'
  end

  s.subspec 'Controller' do |ss|
    ss.source_files = 'NewsDetailModule/Classes/Controller/**/*'

    ss.dependency 'Tools'
    ss.dependency 'YYKit'
    ss.dependency 'Masonry'
    ss.dependency 'Network'

    ss.dependency 'NewsDetailModule/Model'
    ss.dependency 'NewsDetailModule/View'
    ss.dependency 'NewsCommentModule/View' #添加依赖：评论cell组件
  end

  s.subspec 'Targets' do |ss|
    ss.source_files = 'NewsDetailModule/Classes/Targets/**/*'

    ss.dependency 'NewsDetailModule/Controller'
  end
  # s.resource_bundles = {
  #   'NewsDetailModule' => ['NewsDetailModule/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
