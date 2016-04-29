//
//  DLSharedNode.h
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

@class DLSharedModel;

@interface DLSharedNode : ASControlNode

//------------------------------------------------------------------------------
#pragma mark - Initialize
//------------------------------------------------------------------------------

- (instancetype) initWithShared: (DLSharedModel *) shared;

//------------------------------------------------------------------------------
// model for display.

@property ( nonatomic, strong ) DLSharedModel * sharedModel;

@end
