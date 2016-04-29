//
//  DLSharedNode.m
//  TimeLine
//
//  CREATED BY: Dylan
//  FOLLOW:
//        BLOG: http://www.jianshu.com/users/81c4380481c1/latest_articles
//        FACEBOOK: https://www.facebook.com/Dylanccccc
//        TWITTER: https://twitter.com/Dylanccccc
//  LICENSE: MIT
//

#import "DLSharedNode.h"
#import "TimeLineDisplayLayout.h"

@interface DLSharedNode ()

@property ( nonatomic, strong ) ASNetworkImageNode * logoImageNode;
@property ( nonatomic, strong ) ASTextNode * descNode;

@end

@implementation DLSharedNode

- (instancetype) initWithShared: (DLSharedModel *) shared {
    
    self = [super init];
    if ( self ) {
        
        self.backgroundColor = ASDisplayNodeDefaultPlaceholderColor();
        _sharedModel = shared;
        [self initializeComponentWithModel:_sharedModel];
    }
    
    return self;
}

//------------------------------------------------------------------------------
#pragma mark - Layout
//------------------------------------------------------------------------------

- (ASLayoutSpec *) layoutSpecThatFits: (ASSizeRange) constrainedSize {

    _logoImageNode.preferredFrameSize = CGSizeMake(45, 45);
    
    _descNode.flexShrink = YES;
    
    ASStackLayoutSpec * logoAndDesc = [ASStackLayoutSpec horizontalStackLayoutSpec];
    logoAndDesc.spacing = 10;
    logoAndDesc.verticalAlignment = ASVerticalAlignmentCenter;
    [logoAndDesc setChildren:@[_logoImageNode, _descNode]];
    
    ASInsetLayoutSpec * sepc = [ASInsetLayoutSpec
                                insetLayoutSpecWithInsets:UIEdgeInsetsMake(5, 5, 5, 5)
                                child:logoAndDesc];
    
    return sepc;
}

//------------------------------------------------------------------------------
#pragma mark - Load commons
//------------------------------------------------------------------------------

- (void) initializeComponentWithModel: (DLSharedModel *) sharedModel {
    
    _logoImageNode = [[ASNetworkImageNode alloc] init];
    _logoImageNode.placeholderColor = ASDisplayNodeDefaultPlaceholderColor();
    _logoImageNode.URL = sharedModel.logoURL;
    [self addSubnode:_logoImageNode];
    
    _descNode = [[ASTextNode alloc] init];
    _descNode.maximumNumberOfLines = 2;
    _descNode.attributedString = [[NSAttributedString alloc] initWithString:sharedModel.desc
                                                                     attributes:@{
                                                                                  
                                                                                  NSFontAttributeName : [UIFont fontForFontName:FontNameSTHeitiSCLight size:13.],
                                                                                  NSForegroundColorAttributeName : RGB(81, 81, 81)
                                                                                  
                                                                                  }];
    [self addSubnode:_descNode];
}

@end
