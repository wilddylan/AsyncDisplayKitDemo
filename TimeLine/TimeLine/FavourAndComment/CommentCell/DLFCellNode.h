//
//  DLFCellNode.h
//  TimeLine
//
//  CREATED BY: Dylan
//  FOLLOW:
//        BLOG: http://www.jianshu.com/users/81c4380481c1/latest_articles
//        FACEBOOK: https://www.facebook.com/Dylanccccc
//        TWITTER: https://twitter.com/Dylanccccc
//  LICENSE: MIT
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@class DLCommentModel;

@interface DLFCellNode : ASCellNode

//------------------------------------------------------------------------------
#pragma mark - Initialize
//------------------------------------------------------------------------------

- (instancetype) initWithComment: (DLCommentModel *) comment;

//------------------------------------------------------------------------------
// model for display.

@property ( nonatomic, strong ) DLCommentModel * comment;

@end
