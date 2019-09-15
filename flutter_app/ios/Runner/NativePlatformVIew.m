//
//  NativePlatformVIew.m
//  Runner
//
//  Created by wab on 2019/9/13.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "NativePlatformVIew.h"

@implementation NativePlatformVIew{
    UIView *_bgView;
    FlutterMethodChannel *_channel;
}

- (instancetype)initWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    self = [super init];
    if(self){
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor grayColor];
        _channel = [FlutterMethodChannel methodChannelWithName:[NSString stringWithFormat:@"nativeview_%lld",viewId ] binaryMessenger:messenger];
        
        __weak __typeof__(self)  weakSelf = self;
        [_channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
            [weakSelf onMethodCall:call result:result];
        }];
    }
    
    return self;
}

- (void) onMethodCall : (FlutterMethodCall *) call  result:(FlutterResult)result {
    if([[call method] isEqualToString:@"changeBackgroundColor"]){
        _bgView.backgroundColor = [UIColor orangeColor];
        result(0);
    }else{
        result(FlutterMethodNotImplemented);
    }
}




- (nonnull UIView *)view {
    return _bgView;
}

@end
