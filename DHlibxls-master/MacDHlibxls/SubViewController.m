//
//  SubViewController.m
//  MacDHlibxls
//
//  Created by LHMacCoder on 2020/5/18.
//

#import "SubViewController.h"

@interface SubViewController ()<NSTabViewDelegate> {
    NSMutableDictionary *_dic;
}

@property (weak) IBOutlet NSTabView *tabView;
@property (unsafe_unretained) IBOutlet NSTextView *detailText;


@end

@implementation SubViewController

@synthesize languageDic = _languageDic;

- (instancetype)init {
    if (self = [super initWithNibName:@"SubViewController" bundle:nil]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
}

- (NSDictionary *)languageDic {
    if (!_languageDic) {
        _languageDic = [[NSDictionary alloc] init];
    }
    return _languageDic;
}

- (void)setLanguageDic:(NSDictionary *)languageDic {
    _languageDic = languageDic;
    NSArray *enArray = [languageDic valueForKey:@"英语"];
    NSInteger count = enArray.count;
    if (!_dic) {
        _dic = [NSMutableDictionary new];
    }
    [languageDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSArray *obj, BOOL * _Nonnull stop) {
        NSMutableString *string = [[NSMutableString alloc] init];
        if (obj.count == count) {
            for (NSInteger i = 0; i < count; i++) {
                NSString *str = [NSString stringWithFormat:@"\"%@\" = \"%@\";\n",enArray[i],obj[i]];
                if ([str isEqualToString:@"\"\" = \"\";\n"]) {
                    continue;
                }
                [string appendString:str];
            }
            [self->_dic setValue:string forKey:key];
        }
    }];
    NSString *detail = [_dic valueForKey:@"简体中文"];
    if (detail) {
        _detailText.string = detail;
    }
 }

- (void)addTabViewItem:(NSString *)title {
    if (!title) {
        return ;
    }
    NSTabViewItem *item = [[NSTabViewItem alloc] init];
    item.label = title;
    [_tabView addTabViewItem:item];
}

- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(nullable NSTabViewItem *)tabViewItem {
    NSString *detail = [_dic valueForKey:tabViewItem.label];
    if (detail) {
        _detailText.string = detail;

    }
}
@end
