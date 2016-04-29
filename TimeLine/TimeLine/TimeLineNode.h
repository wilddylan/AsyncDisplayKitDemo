//
//  TimeLineNode.h
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

// at classes.
@class TimeLineDisplayLayout, TimeLineNode, DLMutiImageNode, DLSharedNode, DLFavourAndComment;

/*!
 * @name TimeLineNodeDelegate
 * @discussion
 */
@protocol TimeLineNodeDelegate <NSObject>



@end

@interface TimeLineNode : ASCellNode

//------------------------------------------------------------------------------

//
// Data object and some layout.
//
@property ( nonatomic, strong ) TimeLineDisplayLayout * displayLayout;

//
// Delegate for item event.
//
@property ( nonatomic, assign ) id<TimeLineNodeDelegate> delegate;

//------------------------------------------------------------------------------
#pragma mark - Initialize method
//------------------------------------------------------------------------------

- (instancetype) initWithDisplayLayout: (TimeLineDisplayLayout *) displayLayout;

@end
