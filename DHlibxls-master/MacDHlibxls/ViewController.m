//
//  ViewController.m
//  MacDHlibxls
//
//  Created by LHMacCoder on 2020/5/14.
//

#import "ViewController.h"
#import "DHxlsReader.h"
#import "SubViewController.h"
#import "TSDragView.h"

@interface ViewController ()<TSDragDropViewDelegate> {
    NSMutableArray *_sheetViewArray;
}

@property (weak) IBOutlet NSTabView *tabView;
@property (strong) IBOutlet TSDragView *dragView;
@property (weak) IBOutlet NSTextField *remind;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dragView.delegate = self;
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (void)dragDropFilePathList:(nonnull NSArray<NSString *> *)filePathList {
    NSString *path;

    for (NSString *str in filePathList) {
        if ([str.pathExtension isEqualToString:@"xls"]) {
            path = str;
            break;
        }
    }
    if (!path) {
        return ;
    }
    _remind.hidden = YES;
    _sheetViewArray = [[NSMutableArray alloc] init];
    DHxlsReader *reader = [DHxlsReader xlsReaderWithPath:path];
    int numberOfSheets = [reader numberOfSheets];
    // 遍历所有的sheet
    for (int i = 0; i< numberOfSheets; i++) {
        NSString *sheetName = [reader sheetNameAtIndex:i];
        NSTabViewItem *item = [[NSTabViewItem alloc] init];
        item.label = sheetName;
        
        int columnForSheet = [reader numberOfColsInSheet:i];
        int rowForSheet = [reader numberOfRowsInSheet:i];
        SubViewController *subViewCtrl = [[SubViewController alloc] init];
        [subViewCtrl loadView];
        NSMutableDictionary *dic = [NSMutableDictionary new];
        NSString *subTitle;
        // 获取所有列的标题
        for (int j = 2; j < columnForSheet; j++) {
            DHcell *cell = [reader cellInWorkSheetIndex:i row:1 col:j];
            subTitle = cell.str;
            if (subTitle.length == 0) {
                continue;
            }
            [subViewCtrl addTabViewItem:subTitle];
            // 获取该列下所有的行
            NSMutableArray *array = [NSMutableArray new];
            for (int k = 2; k <= rowForSheet; k++) {
                cell = [reader cellInWorkSheetIndex:i row:k col:j];
                NSString *value = cell.str;
                if (!value) {
                    value = @"";
                }
                [array addObject:value];
            }
            if (array && subTitle.length > 0) {
                [dic setValue:array forKey:subTitle];
            }
        }
        
        item.view = subViewCtrl.view;
        [_tabView addTabViewItem:item];
        subViewCtrl.languageDic = dic;
        [_sheetViewArray addObject:subViewCtrl];
        
    }
}


@end
