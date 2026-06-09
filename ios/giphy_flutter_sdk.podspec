require 'yaml'

# Load the pubspec.yaml file
pubspec_path = File.join(__dir__, '..', 'pubspec.yaml')
pubspec = YAML.load_file(pubspec_path)

Pod::Spec.new do |s|
  s.name             = pubspec['name']
  s.version          = pubspec['version']
  s.summary          = pubspec['description']
  s.homepage         = pubspec['homepage']
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Giphy Engineering' => 'developers@giphy.com' }
  s.source           = { :path => '.' }
  # SwiftPM-aware sources live at giphy_flutter_sdk/Sources/giphy_flutter_sdk
  # alongside `Package.swift`. The Pod consumer reads from the same tree so
  # there's no duplication between the two distributions.
  s.source_files = 'giphy_flutter_sdk/Sources/giphy_flutter_sdk/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  s.dependency "Giphy", "2.3.2"
end
