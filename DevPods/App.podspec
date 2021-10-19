# require 'cocoapods-mpaas'

Pod::Spec.new do |s|
  s.name             = 'App'
  s.version          = '0.1.0'
  s.summary          = 'ByteDance App Demo.'
  s.description      = 'ByteDance App Demo..'
  s.homepage         = 'https://github.com/volcengine/ve_Template_iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'duanwenbin' => 'duanwenbin@bytedance.com' }
  s.source           = { :path => '.' }
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.static_framework = true
  s.default_subspecs = 'Base', 'Debug'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES'}

  s.subspec 'Base' do |bd|
    bd.source_files = 'App/Base/**/*.{h,m,c}'
    bd.public_header_files = 'App/Base/**/*.h'
    bd.frameworks = 'Foundation','UIKit'
    bd.dependency 'OneKit/StartUp'
    bd.dependency 'TTNetworkManager'
  end

  s.subspec 'Debug' do |bd|
    bd.source_files = 'App/Debug/**/*.{h,m,c,mm}'
    bd.resources = 'App/Debug/**/*.js'
    bd.dependency 'App/Base'
    bd.dependency 'TTNetworkManager'
    bd.dependency 'OneKit/Defaults'
  end

end
