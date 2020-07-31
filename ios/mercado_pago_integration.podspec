#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint mercado_pago_integration.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'mercado_pago_integration'
  s.version          = '0.0.1'
  s.summary          = 'MercadoPago Mobile Checkout Integration.'
  s.description      = <<-DESC
MercadoPago Mobile Checkout Integration
                       DESC
  s.homepage         = 'https://github.com/caramelpoint/mercado_pago_integration'
  s.license          = { :type => 'MIT', :file => '../LICENSE.md' }
  s.author           = { 'Caramel Point' => 'caramelpointdev@gmail.com' }
  s.source           = { :http => 'https://github.com/caramelpoint/mercado_pago_integration/tree/master/ios' }
  s.documentation_url = 'https://pub.dev/packages/mercado_pago_integration'
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'MercadoPagoSDK', '~>4.32.4'
  s.static_framework = true
  s.platform = :ios, '10.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }

end

