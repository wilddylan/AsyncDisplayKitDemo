//
//  DLFavourAndComment.h
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

@class DLCommentModel, DLUser;

@interface DLFavourAndComment : ASDisplayNode

//------------------------------------------------------------------------------
#pragma mark - Initialize
//------------------------------------------------------------------------------

- (instancetype) initWithFavour: (NSArray < DLUser * > *) favours andComment: (NSArray < DLCommentModel * > *) comments;

//------------------------------------------------------------------------------
// model for display.

@property ( nonatomic, strong ) NSArray < DLUser * > * favours;
@property ( nonatomic, strong ) NSArray < DLCommentModel * > * comments;

@end
