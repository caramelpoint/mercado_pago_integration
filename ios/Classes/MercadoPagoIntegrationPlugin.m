#import "MercadoPagoIntegrationPlugin.h"
#if __has_include(<mercado_pago_integration/mercado_pago_integration-Swift.h>)
#import <mercado_pago_integration/mercado_pago_integration-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "mercado_pago_integration-Swift.h"
#endif

@implementation MercadoPagoIntegrationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMercadoPagoIntegrationPlugin registerWithRegistrar:registrar];
}
@end
