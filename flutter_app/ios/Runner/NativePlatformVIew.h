//
//  NativePlatformVIew.h
//  Runner
//
//  Created by wab on 2019/9/13.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "GeneratedPluginRegistrant.h"


NS_ASSUME_NONNULL_BEGIN

@interface NativePlatformVIew : NSObject<FlutterPlatformView>

- (instancetype) initWithFrame:(CGRect) frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args binaryMessenger :(NSObject<FlutterBinaryMessenger> *) messenger;

@end

NS_ASSUME_NONNULL_END
