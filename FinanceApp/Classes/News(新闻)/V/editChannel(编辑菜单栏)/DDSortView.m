//
//  DDSortView.m
//  FinanceApp
//
//  Created by SX on 2018/3/22.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "DDSortView.h"
#import "CoclumnCollectionViewCell.h"
#import "ColumnReusableView.h"
#import "HomeHelper.h"

static NSString *cellColumnIdentifier = @"CoclumnCollectionViewCell";
static NSString *headOne = @"ColumnReusableViewOne";
static NSString *headTwo = @"ColumnReusableViewTwo";

@interface DDSortView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DeleteDelegate>
{
    //被拖拽的item
    CoclumnCollectionViewCell *_dragingItem;
    //正在拖拽的indexpath
    NSIndexPath *_dragingIndexPath;
    //目标位置
    NSIndexPath *_targetIndexPath;
}
/**
 *  collectionView
 */
@property (nonatomic, strong)UICollectionView *collectionView;
/**
 *  Whether sort
 */
@property (nonatomic, assign)BOOL isSort;
/**
 * Whether hidden the last
 */
@property (nonatomic, assign)BOOL lastIsHidden;
/**
 *  animation label（insert）
 */
@property (nonatomic, strong)UILabel *animationLabel;
/**
 *  attributes of all cells
 */
@property (nonatomic, strong)NSMutableArray *cellAttributesArray;



@end

@implementation DDSortView

#pragma mark - lazy
- (UILabel *)animationLabel {
    if (!_animationLabel) {
        _animationLabel = [[UILabel alloc] initWithText:@"" textColor:RGBA(101, 101, 101, 1) textFont:k_text_font_args(CalculateHeight(15)) textAlignment:1];
        _animationLabel.numberOfLines = 1;
        _animationLabel.adjustsFontSizeToFitWidth = YES;
        _animationLabel.minimumScaleFactor = 0.1;
        _animationLabel.layer.masksToBounds = YES;
        _animationLabel.layer.borderColor = RGBA(211, 211, 211, 1).CGColor;
        _animationLabel.layer.borderWidth = 0.45;
    }
    return _animationLabel;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) collectionViewLayout:layout];
        _collectionView.backgroundColor = k_back_color;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceVertical = YES;
        
        // 注册class
        [self.collectionView registerClass:[CoclumnCollectionViewCell class] forCellWithReuseIdentifier:cellColumnIdentifier];
        [self.collectionView registerClass:[ColumnReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headOne];
        [self.collectionView registerClass:[ColumnReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headTwo];
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedArray = @[].mutableCopy;
        self.optionalArray = @[].mutableCopy;
        
        self.cellAttributesArray = @[].mutableCopy;
        
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.collectionView];
    
    _dragingItem = [[CoclumnCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, (kScreenWidth - (5*SPACE)) / 4.0, 30)];
    _dragingItem.hidden = true;
    [self.collectionView addSubview:_dragingItem];

    [self.collectionView reloadData];
}

#pragma mark - item 样式
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreenWidth - (5*SPACE)) / 4.0, 30);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(SPACE, SPACE, SPACE, SPACE);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return SPACE;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return SPACE;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(kScreenWidth, 40.0);
    }
    else{
        return CGSizeMake(kScreenWidth, 30.0);
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return  CGSizeMake(kScreenWidth, 0.0);
}

#pragma mark  ----------------- collectionView(datasouce) ---------------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.isSort) {
        return 1;
    }
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.selectedArray.count;
    } else {
        return self.optionalArray.count;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ColumnReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 0) { // 编辑菜单页面
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headOne forIndexPath:indexPath];
            reusableView.buttonHidden = NO;
            reusableView.clickButton.selected = self.isSort;
            reusableView.backgroundColor = k_white_color;
            WS(weakSelf);
            [reusableView clickWithBlock:^(ButtonState state) { // 点击编辑block回调
                if (state == StateSortDelete) {
                    weakSelf.isSort = YES;
                } else {
                    weakSelf.isSort = NO;
                    if (weakSelf.cellAttributesArray.count) {
                        for (UICollectionViewLayoutAttributes *attributes in weakSelf.cellAttributesArray) {
                            CoclumnCollectionViewCell *cell = (CoclumnCollectionViewCell *)[weakSelf.collectionView cellForItemAtIndexPath:attributes.indexPath];
                            for (UIPanGestureRecognizer *pan in cell.gestureRecognizers) {
                                [cell removeGestureRecognizer:pan];
                            }
                        }
                    }
                }
                [weakSelf.collectionView reloadData];
            }];
            reusableView.titleLabel.text = @"已选栏目";
        } else { // 可选的页面
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headTwo forIndexPath:indexPath];
            reusableView.buttonHidden = YES;
            reusableView.backgroundColor = RGBA(240, 240, 240, 1);
            reusableView.titleLabel.text = @"点击添加更多栏目";
        }
    }
    return (UICollectionReusableView *)reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CoclumnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellColumnIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        [cell configCell:self.selectedArray withIndexPath:indexPath];
        // 头条
        if (indexPath.row == 0) {
            cell.deleteButton.hidden = YES;
        } else {
            cell.deleteDelegate = self;
            cell.deleteButton.hidden = !self.isSort;
            if (self.isSort) {
                UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(sortItem:)];
                longPress.minimumPressDuration = 0.3f;
                [self.collectionView addGestureRecognizer:longPress];
                
                
            }
            //最后一位是否影藏(为了动画效果)
            if (indexPath.row == self.selectedArray.count - 1) {
                cell.contentLabel.hidden = self.lastIsHidden;
            }
            
        }
        cell.title = self.selectedArray[indexPath.row];
    } else {
        [cell configCell:self.optionalArray withIndexPath:indexPath];
        cell.deleteButton.hidden = YES;
        cell.title = self.optionalArray[indexPath.row];
    }
//    cell.title = self.selectedArray[indexPath.row];
    return cell;
}

#pragma mark - insert item method
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        self.lastIsHidden = YES;
        
        CoclumnCollectionViewCell *endCell = (CoclumnCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        endCell.contentLabel.hidden = YES;
        
        [self.selectedArray addObject:[self.optionalArray objectAtIndex:indexPath.row]];
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        
        // 移动开始的attribute
        UICollectionViewLayoutAttributes *startAttributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
        
        self.animationLabel.frame = CGRectMake(startAttributes.frame.origin.x, startAttributes.frame.origin.y, startAttributes.frame.size.width , startAttributes.frame.size.height);
        self.animationLabel.layer.cornerRadius = CGRectGetHeight(self.animationLabel.bounds) * 0.5;
        self.animationLabel.text = [self.optionalArray objectAtIndex:indexPath.row];
        [self.collectionView addSubview:self.animationLabel];
        
        NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:self.selectedArray.count-1 inSection:0];
        
        //移动终点的attributes
        UICollectionViewLayoutAttributes *endAttributes = [self.collectionView layoutAttributesForItemAtIndexPath:toIndexPath];
        
        typeof(self) __weak weakSelf = self;
        //移动动画
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.animationLabel.center = endAttributes.center;
        } completion:^(BOOL finished) {
            //展示最后一个cell的contentLabel
            CoclumnCollectionViewCell *endCell = (CoclumnCollectionViewCell *)[weakSelf.collectionView cellForItemAtIndexPath:toIndexPath];
            endCell.contentLabel.hidden = NO;
            
            weakSelf.lastIsHidden = NO;
            [weakSelf.animationLabel removeFromSuperview];
            [weakSelf.optionalArray removeObjectAtIndex:indexPath.row];
            [weakSelf.collectionView deleteItemsAtIndexPaths:@[indexPath]];
        }];
    }
}

#pragma mark -   --------- pan sort ----------
- (void)sortItem:(UILongPressGestureRecognizer *)pan {
    CGPoint point = [pan locationInView:_collectionView];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            [self dragBegin:point];
            break;
        case UIGestureRecognizerStateChanged:
            [self dragChanged:point];
            break;
        case UIGestureRecognizerStateEnded:
            [self dragEnd];
            break;
        default:
            break;
    }
    
//    CoclumnCollectionViewCell *cell =  (CoclumnCollectionViewCell *)pan.view;
//    NSIndexPath *cellIndexPath = [self.collectionView indexPathForCell:cell];
//
//    //开始  获取所有cell的attributes
//    if (pan.state == UIGestureRecognizerStateBegan) {
//        [self.cellAttributesArray removeAllObjects];
//        for (NSInteger i = 0 ; i < self.selectedArray.count; i++) {
//            [self.cellAttributesArray addObject:[self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
//        }
//    }
//
//    CGPoint point = [pan translationInView:self.collectionView];
//    cell.center = CGPointMake(cell.center.x + point.x, cell.center.y + point.y);
//    [pan setTranslation:CGPointMake(0, 0) inView:self.collectionView];
//
//    //进行是否排序操作
//    BOOL ischange = NO;
//    for (UICollectionViewLayoutAttributes *attributes in self.cellAttributesArray) {
//        CGRect rect = CGRectMake(attributes.center.x - 6, attributes.center.y - 6, 12, 12);
//        if (CGRectContainsPoint(rect, CGPointMake(pan.view.center.x, pan.view.center.y)) & (cellIndexPath != attributes.indexPath)) {
//
//            //后面跟前面交换
//            if (cellIndexPath.row > attributes.indexPath.row) {
//                //交替操作0 1 2 3 变成（3<->2 3<->1 3<->0）
//                for (NSInteger index = cellIndexPath.row; index > attributes.indexPath.row; index -- ) {
//                    [self.selectedArray exchangeObjectAtIndex:index withObjectAtIndex:index - 1];
//                }
//            }
//            //前面跟后面交换
//            else{
//                //交替操作0 1 2 3 变成（0<->1 0<->2 0<->3）
//                for (NSInteger index = cellIndexPath.row; index < attributes.indexPath.row; index ++ ) {
//                    [self.selectedArray exchangeObjectAtIndex:index withObjectAtIndex:index + 1];
//                }
//            }
//            ischange = YES;
//            [self.collectionView moveItemAtIndexPath:cellIndexPath toIndexPath:attributes.indexPath];
//        }
//        else{
//            ischange = NO;
//        }
//    }
//
//    //结束
//    if (pan.state == UIGestureRecognizerStateEnded){
//        if (ischange) {
//
//        }
//        else{
//            cell.center = [self.collectionView layoutAttributesForItemAtIndexPath:cellIndexPath].center;
//        }
//    }
}

#pragma mark - -------  delete delegate -----------
- (void)deleteItemWithIndexPath:(NSIndexPath *)indexPath {
    //数据整理
    [self.optionalArray insertObject:[self.selectedArray objectAtIndex:indexPath.row] atIndex:0];
    [self.selectedArray removeObjectAtIndex:indexPath.row];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    
    //删除之后更新collectionView上对应cell的indexPath
    for (NSInteger i = 0; i < self.selectedArray.count; i++) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        CoclumnCollectionViewCell *cell = (CoclumnCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:newIndexPath];
        cell.indexPath = newIndexPath;
    }
}

#pragma mark - ------  new drag method ————----
-(void)dragBegin:(CGPoint)point{
    _dragingIndexPath = [self getDragingIndexPathWithPoint:point];
    if (!_dragingIndexPath) {return;}
    [self.collectionView bringSubviewToFront:_dragingItem];
    CoclumnCollectionViewCell *item = (CoclumnCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:_dragingIndexPath];
    
    //更新被拖拽的item
    _dragingItem.hidden = false;
    _dragingItem.frame = item.frame;
    _dragingItem.title = item.title;
    [_dragingItem setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
}

//正在被拖拽、、、
-(void)dragChanged:(CGPoint)point{
    if (!_dragingIndexPath) {return;}
    _dragingItem.center = point;
    _targetIndexPath = [self getTargetIndexPathWithPoint:point];
    //交换位置 如果没有找到_targetIndexPath则不交换位置
    if (_dragingIndexPath && _targetIndexPath) {
        //更新数据源
        [self rearrangeInUseTitles];
        //更新item位置
        [self.collectionView moveItemAtIndexPath:_dragingIndexPath toIndexPath:_targetIndexPath];
        _dragingIndexPath = _targetIndexPath;
    }
}

//拖拽结束
-(void)dragEnd{
    if (!_dragingIndexPath) {return;}
    CGRect endFrame = [_collectionView cellForItemAtIndexPath:_dragingIndexPath].frame;
    [_dragingItem setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
    [UIView animateWithDuration:0.3 animations:^{
        _dragingItem.frame = endFrame;
    }completion:^(BOOL finished) {
        _dragingItem.hidden = true;
//        CoclumnCollectionViewCell *item = (CoclumnCollectionViewCell*)[_collectionView cellForItemAtIndexPath:_dragingIndexPath];
        
    }];
}

//获取被拖动IndexPath的方法
-(NSIndexPath*)getDragingIndexPathWithPoint:(CGPoint)point{
    NSIndexPath* dragIndexPath = nil;
    //最后剩一个怎不可以排序
    if ([_collectionView numberOfItemsInSection:0] == 1) {return dragIndexPath;}
    for (NSIndexPath *indexPath in _collectionView.indexPathsForVisibleItems) {
        //下半部分不需要排序
        if (indexPath.section > 0) {continue;}
        //在上半部分中找出相对应的Item
        if (CGRectContainsPoint([_collectionView cellForItemAtIndexPath:indexPath].frame, point)) {
            if (indexPath.row != 0) {
                dragIndexPath = indexPath;
            }
            break;
        }
    }
    return dragIndexPath;
}

//获取目标IndexPath的方法
-(NSIndexPath*)getTargetIndexPathWithPoint:(CGPoint)point{
    NSIndexPath *targetIndexPath = nil;
    for (NSIndexPath *indexPath in _collectionView.indexPathsForVisibleItems) {
        //如果是自己不需要排序
        if ([indexPath isEqual:_dragingIndexPath]) {continue;}
        //第二组不需要排序
        if (indexPath.section > 0) {continue;}
        //在第一组中找出将被替换位置的Item
        if (CGRectContainsPoint([_collectionView cellForItemAtIndexPath:indexPath].frame, point)) {
            if (indexPath.row != 0) {
                targetIndexPath = indexPath;
            }
        }
    }
    return targetIndexPath;
}

//拖拽排序后需要重新排序数据源
-(void)rearrangeInUseTitles
{
    id obj = [self.selectedArray objectAtIndex:_dragingIndexPath.row];
    [self.selectedArray removeObject:obj];
    [self.selectedArray insertObject:obj atIndex:_targetIndexPath.row];
}
@end
