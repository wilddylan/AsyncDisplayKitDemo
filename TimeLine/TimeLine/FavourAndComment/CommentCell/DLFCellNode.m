//
//  DLFCellNode.m
//  TimeLine
//
//  CREATED BY: Dylan
//  FOLLOW:
//        BLOG: http://www.jianshu.com/users/81c4380481c1/latest_articles
//        FACEBOOK: https://www.facebook.com/Dylanccccc
//        TWITTER: https://twitter.com/Dylanccccc
//  LICENSE: MIT
//

#import "DLFCellNode.h"
#import "TimeLineDisplaylayout.h"

@interface DLFCellNode ()

@property ( nonatomic, strong ) ASTextNode * textNode;

@end

@implementation DLFCellNode

- (instancetype) initWithComment: (DLCommentModel *) comment {
    
    self = [super init];
    if ( self ) {
    
        _comment = comment;
        
        _textNode = [[ASTextNode alloc] init];
        _textNode.attributedString = comment.comment;
        [self addSubnode:_textNode];
    }
    
    return self;
}

//------------------------------------------------------------------------------
#pragma mark - Layout
//------------------------------------------------------------------------------

- (ASLayoutSpec *) layoutSpecThatFits: (ASSizeRange) constrainedSize {
    
    _textNode.flexShrink = YES;
    
    ASStackLayoutSpec * spec = [ASStackLayoutSpec horizontalStackLayoutSpec];
    [spec setChildren:@[_textNode]];
    spec.horizontalAlignment = ASHorizontalAlignmentLeft;
    
    ASInsetLayoutSpec * inset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsZero child:spec];
    
    return inset;
}

@end
