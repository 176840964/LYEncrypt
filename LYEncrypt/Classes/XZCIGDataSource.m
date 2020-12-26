//
//  XZCIGDataSource.m
//  AFNetworking
//
//  Created by zxl on 2020/12/15.
//

#import "XZCIGDataSource.h"

@interface XZCIGDataSource ()

@end

@implementation XZCIGDataSource

- (id)initWithIdentifier:(NSString *)identifier configBlock:(CellConfig)config selectedHandle:(SelectedHandle)selected {
    if (self = [super init]) {
        _cellIdentifier = identifier;
        _cellConfig = config;
        _cellSelected = selected;
    }
    return self;
}

- (void)setupDataArray:(NSArray *)datas {
    if(!datas) {
        return;
    }
    
    if (self.dataArr.count > 0) {
        [self.dataArr removeAllObjects];
    }

    [self.dataArr addObjectsFromArray:datas];
}

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataArr.count > indexPath.row ? self.dataArr[indexPath.row] : nil;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id model = [self modelsAtIndexPath:indexPath];
    if(self.cellConfig) {
        self.cellConfig(cell, model, indexPath);
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = [self modelsAtIndexPath:indexPath];
    if (self.cellSelected) {
        self.cellSelected(model, indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 44;
    id model = [self modelsAtIndexPath:indexPath];
    if (self.cellHeight) {
        height = self.cellHeight(model, indexPath);
    } else {
        height = tableView.rowHeight;
    }
    return height;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id model = [self modelsAtIndexPath:indexPath];
    if(self.cellConfig) {
        self.cellConfig(cell, model,indexPath);
    }

    return cell;
}

#pragma mark - UICollectionViewDataSource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id model = [self modelsAtIndexPath:indexPath];
    if (self.cellSelected) {
        self.cellSelected(model, indexPath);
    }
}

#pragma mark - lazy load
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArr;
}

@end
