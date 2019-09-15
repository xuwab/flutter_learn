//
//  NativeViewFactory.h
//  Runner
//
//  Created by wab on 2019/9/13.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "GeneratedPluginRegistrant.h"

NS_ASSUME_NONNULL_BEGIN

@interface NativeViewFactory : NSObject<FlutterPlatformViewFactory>



- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger> *)messager;

@end

NS_ASSUME_NONNULL_END
