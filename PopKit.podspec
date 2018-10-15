#
# Be sure to run `pod lib lint PopKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PopKit'
  s.version          = '0.1.6'
  s.summary          = 'A flexible framework as a one size fits all solution for popups, modals, notifications and menus'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
The purpose of this pod is to provide users with a one size fits all solution popups, modals, notifications and menus. The are hundreds of different little libraries that are very specific, which means that in the end your solution gets clogged up with tons of pods, which is completely unnecessary. Popkit is a flexible solution for you to create any form of popup in any size, with control of animations and constraints.
                       DESC

  s.homepage         = 'https://github.com/rohan-jansen/PopKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Rohan Jansen' => 'rohanjansen@gmail.com' }
  s.source           = { :git => 'https://github.com/rohan-jansen/PopKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/rohan_jansen'

    s.platform     = :ios
    s.platform     = :ios, "9.0"

    #  When using multiple platforms
    s.ios.deployment_target = "9.0"

  s.source_files = 'PopKit/Classes/**/*'
end
