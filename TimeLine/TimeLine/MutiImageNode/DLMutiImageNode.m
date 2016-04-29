//
//  DLMutiImageNode.m
//  TimeLine
//
//  CREATED BY: Dylan
//  FOLLOW:
//        BLOG: http://www.jianshu.com/users/81c4380481c1/latest_articles
//        FACEBOOK: https://www.facebook.com/Dylanccccc
//        TWITTER: https://twitter.com/Dylanccccc
//  LICENSE: MIT
//

#import "DLMutiImageNode.h"
#import "DLSImageNode.h"
#import "TimeLineDisplayLayout.h"

@interface DLMutiImageNode () <ASCollectionViewDelegate, ASCollectionViewDataSource>

@property ( nonatomic, strong ) ASCollectionNode * collectionView;

@end

@implementation DLMutiImageNode

- (instancetype) initWithMutiImage: (NSArray < DLImageModel * > *) imagesModel {
    
    self = [super init];
    if ( self ) {
        
        _imagesModel = imagesModel;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 2;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[ASCollectionNode alloc] initWithCollectionViewLayout:layout];
        _collectionView.view.asyncDataSource = self;
        _collectionView.view.asyncDelegate = self;
        _collectionView.view.backgroundColor = [UIColor whiteColor];
        _collectionView.view.scrollEnabled = NO;
        
        [self.view addSubnode:_collectionView];
    }
    
    return self;
}

//------------------------------------------------------------------------------
#pragma mark - Delegate Method
//------------------------------------------------------------------------------

- (NSInteger) numberOfSectionsInCollectionView: (UICollectionView *) collectionView {
    
    return 1;
}

- (NSInteger) collectionView: (UICollectionView *) collectionView numberOfItemsInSection: (NSInteger) section {
    
    return _imagesModel.count;
}

- (ASCellNode *) collectionView: (ASCollectionView *) collectionView nodeForItemAtIndexPath: (NSIndexPath *) indexPath {
    
    DLSImageNode * imageNode = [[DLSImageNode alloc] initWithImage:_imagesModel[indexPath.row]
                                                             index:indexPath.row
                                                          allCount:_imagesModel.count];
    
    return imageNode;
}

- (ASLayoutSpec *) layoutSpecThatFits: (ASSizeRange) constrainedSize {
    
    if ( _imagesModel.count == 1 ) {
    
        DLImageModel *_imageModel = _imagesModel.firstObject;
            // only one picture. box -> (w: 200, h: 200)
            CGFloat width = _imageModel.width;
            CGFloat height = _imageModel.height;
            
            CGFloat maxLine = MAX(width, height);
            
            if ( maxLine > 200 ) {
                
                CGFloat scale = 200 / maxLine * 1.0;
                _collectionView.preferredFrameSize = CGSizeMake(width * scale, height * scale);
            } else {
                
                _collectionView.preferredFrameSize = CGSizeMake(width, height);
            }
    } else {
        
        CGFloat width = _imagesModel.count >= 3 ? 244 : 240 + (2 * _imagesModel.count - 1);
        
        _collectionView.preferredFrameSize = CGSizeMake(width, 80 * ((_imagesModel.count / 3) % 3 == 0 ? (_imagesModel.count / 3) : (_imagesModel.count / 3) + 1));
    }
    
    ASStackLayoutSpec * layout = [ASStackLayoutSpec horizontalStackLayoutSpec];
    layout.horizontalAlignment = ASHorizontalAlignmentLeft;
    [layout setChildren:@[_collectionView]];
    
    return layout;
}

@end
