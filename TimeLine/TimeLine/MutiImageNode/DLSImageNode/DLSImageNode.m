//
//  DLSImageNode.m
//  TimeLine
//
//  CREATED BY: Dylan
//  FOLLOW:
//        BLOG: http://www.jianshu.com/users/81c4380481c1/latest_articles
//        FACEBOOK: https://www.facebook.com/Dylanccccc
//        TWITTER: https://twitter.com/Dylanccccc
//  LICENSE: MIT
//

#import "DLSImageNode.h"
#import "TimeLineDisplayLayout.h"

@interface DLSImageNode ()

@property ( nonatomic, strong ) ASNetworkImageNode * imageNode;

@end

@implementation DLSImageNode

- (instancetype) initWithImage: (DLImageModel *) imageModel
                         index: (NSInteger) index
                      allCount: (NSInteger) allCount {
    
    self = [super init];
    if ( self ) {
        
        _imageModel = imageModel;
        _index = index;
        _allCount = allCount;
        
        _imageNode = [[ASNetworkImageNode alloc] init];
        _imageNode.placeholderColor = ASDisplayNodeDefaultPlaceholderColor();
        _imageNode.URL = imageModel.thumbURL;
        [self addSubnode:_imageNode];
    }
    
    return self;
}

//------------------------------------------------------------------------------
#pragma mark - Layout
//------------------------------------------------------------------------------

- (ASLayoutSpec *) layoutSpecThatFits: (ASSizeRange) constrainedSize {
    
    _imageNode.preferredFrameSize = CGSizeMake(80, 80);
    
    if ( _allCount == 1 ) {
        
        // only one picture. box -> (w: 200, h: 200)
        CGFloat width = _imageModel.width;
        CGFloat height = _imageModel.height;
        
        CGFloat maxLine = MAX(width, height);
        
        if ( maxLine >= 200 ) {
            
            CGFloat scale = 200 / maxLine * 1.0;
            _imageNode.preferredFrameSize = CGSizeMake(width * scale, height * scale);
        } else {
            
            _imageNode.preferredFrameSize = CGSizeMake(width, height);
        }
    }
    
    ASInsetLayoutSpec * imageLayout = [ASInsetLayoutSpec
                                       insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)
                                       child:_imageNode];
    
    return imageLayout;
}

@end
