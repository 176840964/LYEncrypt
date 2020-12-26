//
//  XZCIGDataSource.h
//  AFNetworking
//
//  Created by zxl on 2020/12/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CellConfig)(id cell, id model, NSIndexPath *indexPath);
typedef void (^SelectedHandle)(id model, NSIndexPath *indexPath);
typedef CGFloat (^RowHeight)(id model, NSIndexPath *indexPath);

@interface XZCIGDataSource : NSObject <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) CellConfig cellConfig;
@property (nonatomic, copy) SelectedHandle cellSelected;
@property (nonatomic, copy) RowHeight cellHeight;

- (id)initWithIdentifier:(NSString *)identifier configBlock:(CellConfig)config selectedHandle:(SelectedHandle)selected;

- (void)setupDataArray:(NSArray *)datas;
- (id)modelsAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
