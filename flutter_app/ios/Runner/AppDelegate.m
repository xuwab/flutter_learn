#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "NativeViewFactory.h"

@interface AppDelegate()

@property (nonatomic , strong) FlutterMethodChannel *channel;


@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.

    self.channel = [FlutterMethodChannel methodChannelWithName:@"mychannel" binaryMessenger:(FlutterViewController *)self.window.rootViewController];
    
    [self.channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([@"toast" isEqualToString:call.method]){
            self.window.rootViewController.view.backgroundColor = [UIColor redColor];
            NSLog(@"hulalal");
            
            [self invokeFlutterMethod];
            result(0);
        }else{
            result(FlutterMethodNotImplemented);
        }
    }];

    
    NSObject<FlutterPluginRegistrar> *registrar = [self registrarForPlugin:@"nativeview"];
    NativeViewFactory *factory = [[NativeViewFactory alloc]initWithMessenger:registrar.messenger];
    [registrar registerViewFactory:factory withId:@"iosview"];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void) invokeFlutterMethod{
    [self.channel invokeMethod:@"flutter" arguments:@"ios developer" result:^(id  _Nullable result) {
        NSLog(@"%@", result);
    }];
}



@end
