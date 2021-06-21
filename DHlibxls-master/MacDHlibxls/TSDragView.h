//
//  TSDragView.h
//  TSAgentCustomization
//
//  Created by LHMacCoder on 2020/5/15.
//  Copyright © 2020 LHMacCoder. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TSDragDropViewDelegate <NSObject>

/**
 Callback the user to drag the file path array
 回调用户拖拽文件的路径数组
 
 @param filePathList 文件路径数组
 */
- (void)dragDropFilePathList:(NSArray<NSString *> *)filePathList;

@end

@interface TSDragView : NSView

@property (weak) id<TSDragDropViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
