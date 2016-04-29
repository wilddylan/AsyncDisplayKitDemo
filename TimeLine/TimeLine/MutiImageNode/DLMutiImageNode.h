//
//  DLMutiImageNode.h
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

@class DLImageModel;

@interface DLMutiImageNode : ASDisplayNode

//------------------------------------------------------------------------------
#pragma mark - Initialize
//------------------------------------------------------------------------------

- (instancetype) initWithMutiImage: (NSArray < DLImageModel * > *) imagesModel;

//------------------------------------------------------------------------------
// model for display.

@property ( nonatomic, strong ) NSArray < DLImageModel * > * imagesModel;

@end
