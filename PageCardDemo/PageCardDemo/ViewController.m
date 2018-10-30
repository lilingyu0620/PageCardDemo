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

#define MaxSections 100



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
    self.mCollectionView.decelerationRate = 0;
    self.layout = [[PageCardFlowLayout alloc]init];
    self.layout.delegate = self;
    self.mCollectionView.collectionViewLayout = _layout;
    self.mCollectionView.showsHorizontalScrollIndicator = NO;
    
}


- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
//    [self scrollToItemAtIndexPath:2 withAnimated:NO];
    self.indexPath = 0;
    [self scrollToItemAtIndexPath:0 andSection:(MaxSections/2 - 1) withAnimated:NO];
}

- (void)initData{

    self.dataSourceArray = [NSMutableArray arrayWithArray:@[@0,@1,@2,@3,@4,@5,@6,@7]];
}

- (NSMutableArray *)dataSourceArray{

    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}



#pragma mark - UICollectionView DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return MaxSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    PageCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[PageCardCell cellIdentifier] forIndexPath:indexPath];
    cell.detailLabel.text = [self.dataSourceArray[indexPath.row] stringValue];
    return cell;
}

//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat width = ((collectionView.frame.size.width - 280)-(10*2))/2;

    if (section == 0) {
        return UIEdgeInsetsMake(0, width + 10, 0, 0);//分别为上、左、下、右
    }
    else if(section == (MaxSections - 1)){
        return UIEdgeInsetsMake(0, 0, 0, width + 10);//分别为上、左、下、右
    }
    else{
        return UIEdgeInsetsMake(0, 10, 0, 0);//分别为上、左、下、右
    }
}

#pragma mark - PageCardFlowLayoutDelegate
- (void)scrollToPageIndex:(NSInteger)index{
    
    NSInteger curIdx = index % 8;
    
    if(curIdx == 0 && self.indexPath == 7){
        NSLog(@"左滑 且section++");
    }
    else if (curIdx == 7 && self.indexPath == 0){
        NSLog(@"右滑 且section--");
    }
    
    self.indexPath = curIdx;
    
    NSLog(@"当前选择的是第%ld页",curIdx);

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

   }

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{

    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

   

}      // called when scroll view grinds to a halt


- (IBAction)scrollToFirstPage:(id)sender {
    
    NSInteger tag = [(UIButton *)sender tag];
    UICollectionViewLayoutAttributes *attr = [self.mCollectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:(tag+1) inSection:0]];
    [self.mCollectionView scrollToItemAtIndexPath:attr.indexPath
                          atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                  animated:YES];
}

- (void)scrollToItemAtIndexPath:(NSInteger)indexPath andSection:(NSInteger)section withAnimated:(BOOL)animated{

    UICollectionViewLayoutAttributes *attr = [self.mCollectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath inSection:section]];
    [self.mCollectionView scrollToItemAtIndexPath:attr.indexPath
                                     atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                             animated:animated];
    
    self.layout.previousOffsetX = (indexPath + section * self.dataSourceArray.count) * 290;
}

@end
