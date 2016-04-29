//
//  DLSImageNode.h
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

@interface DLSImageNode : ASCellNode

//------------------------------------------------------------------------------
#pragma mark - Initialize
//------------------------------------------------------------------------------

- (instancetype) initWithImage: (DLImageModel *) imageModel
                         index: (NSInteger) index
                      allCount: (NSInteger) allCount;

//------------------------------------------------------------------------------
// item for display.

@property ( nonatomic, strong ) DLImageModel * imageModel;

@property ( nonatomic, assign ) NSInteger index;
@property ( nonatomic, assign ) NSInteger allCount;

@end
