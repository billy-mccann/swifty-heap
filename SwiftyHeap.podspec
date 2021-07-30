#
# Be sure to run `pod lib lint SwiftyHeap.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyHeap'
  s.version          = '1.0'
  s.summary          = 'A Swift implementation of the heap data structure.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
SwiftyHeap provides a heap data structure for the Swift programming language. MaxHeap<T> and MinHeap<T> can accept any generic class conforming to Swift's Comparable protocol.
DESC

  s.homepage         = 'https://github.com/billy-mccann/swifty-heap'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Bill McCann' => 'hyperfine262@gmail.com' }
  s.source           = { :git => 'https://github.com/billy-mccann/swifty-heap.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.swift_versions = "5.0"
  s.source_files = 'SwiftyHeap/Classes/**/*'
end

