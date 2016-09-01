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
    PageCardFlowLayout *layout = [[PageCardFlowLayout alloc]init];
    layout.delegate = self;
    self.mCollectionView.collectionViewLayout = layout;
    self.mCollectionView.showsHorizontalScrollIndicator = NO;
    
}

- (void)initData{

    self.dataSourceArray = [NSMutableArray arrayWithArray:@[@1,@2,@3,@4,@5,@6,@7,@8]];
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
    return cell;
}

#pragma mark - PageCardFlowLayoutDelegate
- (void)scrollToPageIndex:(NSInteger)index{

    NSLog(@"当前选择的是第%ld页",(long)index);
}
@end
