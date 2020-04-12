#import "I18nstrPlugin.h"
#if __has_include(<i18nstr/i18nstr-Swift.h>)
#import <i18nstr/i18nstr-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "i18nstr-Swift.h"
#endif

@implementation I18nstrPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftI18nstrPlugin registerWithRegistrar:registrar];
}
@end
