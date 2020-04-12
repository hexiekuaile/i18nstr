#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint i18nstr.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'i18nstr'
  s.version          = '0.0.1'
  s.summary          = 'flutter国家化插件.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'https://github.com/hexiekuaile/i18nstr'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'yw' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
