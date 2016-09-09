//
//  ViewController.m
//  PageCardDemo
//
//  Created by lly on 16/9/1.
//  Copyright © 2016年 lly. All rights reserved.
//

#import "ViewController.h"
#import "PageCardCell.h"
#import "PageCardFlowLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,PageCardFlowLayoutDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;
@property (nonatomic,strong) NSMutableArray *dataSourceArray;
@property (nonatomic,strong) PageCardFlowLayout *layout;

@property (nonatomic,assign) NSInteger indexPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initData];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 初始化
- (void)initUI{

    [self.mCollectionView registerNib:[UINib nibWithNibName:[PageCardCell cellIdentifier] bundle:nil] forCellWithReuseIdentifier:[PageCardCell cellIdentifier]];
    self.layout = [[PageCardFlowLayout alloc]init];
    self.layout.delegate = self;
    self.mCollectionView.collectionViewLayout = _layout;
    self.mCollectionView.showsHorizontalScrollIndicator = NO;
    
}


- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    [self scrollToItemAtIndexPath:1 withAnimated:NO];
}

- (void)initData{

    self.dataSourceArray = [NSMutableArray arrayWithArray:@[@7,@0,@1,@2,@3,@4,@5,@6,@7,@0]];
}

- (NSMutableArray *)dataSourceArray{

    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}



#pragma mark - UICollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    PageCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[PageCardCell cellIdentifier] forIndexPath:indexPath];
    cell.detailLabel.text = [self.dataSourceArray[indexPath.row] stringValue];
    return cell;
}

#pragma mark - PageCardFlowLayoutDelegate
- (void)scrollToPageIndex:(NSInteger)index{

    self.indexPath = index;
    
    NSLog(@"当前选择的是第%ld页",(long)index);
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    if (_indexPath == 0) {
        [self scrollToItemAtIndexPath:8 withAnimated:NO];
    }
    else if (_indexPath == 9){
        [self scrollToItemAtIndexPath:1 withAnimated:NO];
    }
}      // called when scroll view grinds to a halt

- (IBAction)scrollToFirstPage:(id)sender {
    
    NSInteger tag = [(UIButton *)sender tag];
    UICollectionViewLayoutAttributes *attr = [self.mCollectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:(tag+1) inSection:0]];
    [self.mCollectionView scrollToItemAtIndexPath:attr.indexPath
                          atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                  animated:YES];
}

- (void)scrollToItemAtIndexPath:(NSInteger)indexPath withAnimated:(BOOL)animated{

    UICollectionViewLayoutAttributes *attr = [self.mCollectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath inSection:0]];
    [self.mCollectionView scrollToItemAtIndexPath:attr.indexPath
                                     atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                             animated:animated];
    
    self.layout.previousOffsetX = indexPath*290;
}

@end
