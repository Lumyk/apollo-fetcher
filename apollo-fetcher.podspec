#
# Be sure to run `pod lib lint apollo-mapper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'apollo-fetcher'
  s.version          = `git describe --abbrev=0 --tags`
  s.summary          = 'Helper for fetch apollo requests. Can be used only with "apollo-mapper"'
  s.description      = 'Helper for fetch apollo requests. Can be used only with "apollo-mapper"'
  s.homepage         = 'https://github.com/lumyk/apollo-fetcher'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Evgeny Kalashnikov' => 'lumyk@me.com' }
  s.source           = { :git => 'https://github.com/lumyk/apollo-fetcher.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.dependency 'Apollo'

  s.source_files = 'Sources/**/*'
end
