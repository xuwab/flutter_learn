//
//  NativeViewFactory.m
//  Runner
//
//  Created by wab on 2019/9/13.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "NativeViewFactory.h"
#import "NativePlatformVIew.h"

@implementation NativeViewFactory{
    NSObject<FlutterBinaryMessenger> *_messenger ;
}

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    self = [super init];
    if(self){
        _messenger = messenger;
    }
    
    return self;
}

- (NSObject<FlutterMessageCodec> *)createArgsCodec{
    return [FlutterStandardMessageCodec sharedInstance];
}

- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {
    NativePlatformVIew *view = [[NativePlatformVIew alloc]initWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    
    return view;
}

@end
