//
//  SubViewController.h
//  MacDHlibxls
//
//  Created by LHMacCoder on 2020/5/18.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface SubViewController : NSViewController

@property (nonatomic,copy) NSDictionary *languageDic;

- (void)addTabViewItem:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
